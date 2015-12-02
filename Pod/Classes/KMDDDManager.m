//
//  KMDDDManager.m
//  Pods
//
//  Created by Ian Outterside on 02/12/2015.
//
//

#import "KMDDDManager.h"
#import <KMDDeDupeDictionaries/KMDDDPlistStorage.h>
#import <CommonCrypto/CommonDigest.h>

@interface KMDDDManager()

@property (assign) KMDDDStoreType currentStoreType;
@property (strong, nonatomic) id <KMDDDStorageType> internalStorage;
@property (strong, nonatomic) NSString *currentIdentifier;
@property (assign) NSTimeInterval storeTimeoutInterval;

- (void)boostrapStorage;
- (void)setStorage:(id <KMDDDStorageType>)storage;

@end

@implementation KMDDDManager

// Singleton access
+ (KMDDDManager *)sharedDictionaryManager {
    static KMDDDManager *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    
    return _sharedInstance;
}

// Configuration
- (void)setStoreType:(KMDDDStoreType)storeType identifier:(NSString *)identifier timeout:(NSTimeInterval)timeout {
    
    self.currentStoreType = storeType;
    self.currentIdentifier = identifier;
    self.storeTimeoutInterval = timeout;
}

- (void)setStorage:(id <KMDDDStorageType>)storage {
    
    if (self.currentStoreType == KMDDDStoreTypeCustom) {
        self.internalStorage = storage;
    }
    else {
        @throw [NSException exceptionWithName:NSInternalInconsistencyException reason:@"Unable to set KMDDDStorage if storeType is not KMDDDStoreTypeCustom." userInfo:nil];
    }
}

- (void)boostrapStorage {
    
    if (!self.internalStorage) {
        
        // If storage type is custom and delegate is set, we will ask delegate for storage
        if (self.currentStoreType == KMDDDStoreTypeCustom && self.delegate) {
            
            if ([self.delegate respondsToSelector:@selector(storageForManager:)]) {
                [self setStorage:[self.delegate storageForManager:self]];
            }
        }
        else if (self.currentStoreType == KMDDDStoreTypePlist) {
            
            self.internalStorage = [[KMDDDPlistStorage alloc] init];
            
            // Additional setup here
        }
        // Add mode implementations here
    }
    
    if (self.internalStorage) {
        [self.internalStorage cleanStorageWithIdenfitier:self.currentIdentifier afterTimeout:self.storeTimeoutInterval];
    }
}

- (void)flushStoreageWithIdentifier:(NSString *)identifier {
    
    if (self.internalStorage) {
        [self.internalStorage flushStorageWithIdentifier:identifier];
    }
}

- (NSString *)hashForDictionary:(NSDictionary *)dictionary {
    
    NSError *error = NULL;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if (error != nil) {
        NSLog(@"Serialization Error: %@", error);
        return nil;
    }
    
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    // Now create the MD5 hashs
    const char *ptr = [jsonString UTF8String];
    unsigned char md5Buffer[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(ptr, (CC_LONG)strlen(ptr), md5Buffer);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x",md5Buffer[i]];
    
    return output;
}

// Usage
- (void)manageDictionary:(NSDictionary *)dictionary {
    
    [self boostrapStorage];
    
    if (self.internalStorage) {
        [self.internalStorage storeHash:[self hashForDictionary:dictionary] inStorageWithIdentifier:self.currentIdentifier];
    }
}

- (void)removeDictionary:(NSDictionary *)dictionary {
    
    [self boostrapStorage];
    
    if (self.internalStorage) {
        [self.internalStorage removeHash:[self hashForDictionary:dictionary] inStorageWithIdentifier:self.currentIdentifier];
    }
}

- (BOOL)checkDictionaryisDuplicate:(NSDictionary *)dictionary {
    
    [self boostrapStorage];
    
    if (self.internalStorage) {
        return [self.internalStorage checkHash:[self hashForDictionary:dictionary] inStorageWithIdentifier:self.currentIdentifier];
    }
    else {
        NSLog(@"Storage not loaded when checking duplicate.");
        return NO;
    }
}

@end