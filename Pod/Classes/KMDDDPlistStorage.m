//
//  KMDDDPlistStorage.m
//  Pods
//
//  Created by Ian Outterside on 02/12/2015.
//
//

#import "KMDDDPlistStorage.h"

@interface KMDDDPlistStorage()

@end

@implementation KMDDDPlistStorage

- (NSString *)pathForFileWithIdentifier:(NSString *)identifier {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", identifier]];
    
    return path;
}

- (NSMutableDictionary *)plistWithIdentifier:(NSString *)identifier {

    NSString *path = [self pathForFileWithIdentifier:identifier];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath:path]) {
        return [NSMutableDictionary dictionary];
    }
    else {
        NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithContentsOfFile:path];
        return dictionary;
    }
}

- (void)storePlist:(NSMutableDictionary *)plist withIdentifier:(NSString *)identifier {
    
    NSString *path = [self pathForFileWithIdentifier:identifier];
    [plist writeToFile:path atomically:NO];
}

- (void)storeHash:(NSString *)hash inStorageWithIdentifier:(NSString *)identifier {
    
    NSMutableDictionary *set = [self plistWithIdentifier:identifier];
    [set setObject:[NSDate date] forKey:hash];
    [self storePlist:set withIdentifier:identifier];
}

- (BOOL)checkHash:(NSString *)hash inStorageWithIdentifier:(NSString *)identifier {
    
    NSMutableDictionary *set = [self plistWithIdentifier:identifier];
    return ([set valueForKey:hash]) ? YES : NO;
}

- (void)removeHash:(NSString *)hash inStorageWithIdentifier:(NSString *)identifier {
    
    NSMutableDictionary *set = [self plistWithIdentifier:identifier];
    [set removeObjectForKey:hash];
    [self storePlist:set withIdentifier:identifier];
}

- (void)flushStorageWithIdentifier:(NSString *)identifier {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error = nil;
    [fileManager removeItemAtPath:[self pathForFileWithIdentifier:identifier] error:&error];
    
    if (error) {
        NSLog(@"Unable to flush storage with identifier: %@", identifier);
        NSLog(@"%@", error);
    }
}

- (void)cleanStorageWithIdenfitier:(NSString *)identifier afterTimeout:(NSTimeInterval)timeout {
    
    NSMutableDictionary *set = [self plistWithIdentifier:identifier];
    NSDictionary *iterator = [set copy];
    
    for (NSString *key in [iterator allKeys]) {
        
        NSDate *date = [set valueForKey:key];
        
        if ([date timeIntervalSinceNow] < (timeout * -1)) {
            [set removeObjectForKey:key];
        }
    }
    
    [self storePlist:set withIdentifier:identifier];
}

@end
