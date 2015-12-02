//
//  KMDDDStorage.h
//  Pods
//
//  Created by Ian Outterside on 02/12/2015.
//
//

#import <Foundation/Foundation.h>

@class KMDDDManager, KMDDDStorage;

@protocol KMDDDStorageType;

@protocol KMDDDStorageDelegate <NSObject>

- (id <KMDDDStorageType>)storageForManager:(KMDDDManager *)manager;

@end

@protocol KMDDDStorageType <NSObject>

- (void)storeHash:(NSString *)hash inStorageWithIdentifier:(NSString *)identifier;
- (BOOL)checkHash:(NSString *)hash inStorageWithIdentifier:(NSString *)identifier;
- (void)removeHash:(NSString *)hash inStorageWithIdentifier:(NSString *)identifier;
- (void)flushStorageWithIdentifier:(NSString *)identifier;
- (void)cleanStorageWithIdenfitier:(NSString *)identifier afterTimeout:(NSTimeInterval)timeout;

@end

@interface KMDDDStorage : NSObject

@end
