//
//  KMDDDManager.h
//  Pods
//
//  Created by Ian Outterside on 02/12/2015.
//
//

#import <Foundation/Foundation.h>
#import <KMDDeDupeDictionaries/KMDDDStorage.h>
#import <KMDDeDupeDictionaries/NSDictionary+KMDDDDictionaryAdditions.h>

// May support other store types in future
typedef NS_ENUM(NSInteger, KMDDDStoreType) {
    KMDDDStoreTypePlist,                    // Default store Plist
    KMDDDStoreTypeCustom,                   // Custom store type provided by user
    KMDDDStoreTypeDefault = KMDDDStoreTypePlist,
};

@interface KMDDDManager : NSObject

@property (assign) BOOL enabled;
@property (nonatomic, weak) id <KMDDDStorageDelegate> delegate;

// Singleton access
+ (KMDDDManager *)sharedDictionaryManager;

// Configuration
- (void)setStoreType:(KMDDDStoreType)storeType identifier:(NSString *)identifier timeout:(NSTimeInterval)timeout;
- (void)flushStoreageWithIdentifier:(NSString *)identifier;

// Usage
- (void)manageDictionary:(NSDictionary *)dictionary;
- (void)removeDictionary:(NSDictionary *)dictionary;
- (BOOL)checkDictionaryisDuplicate:(NSDictionary *)dictionary;

@end