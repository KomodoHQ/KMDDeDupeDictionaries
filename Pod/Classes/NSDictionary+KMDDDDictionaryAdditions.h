//
//  NSDictionary+KMDDDDictionaryAdditions.h
//  Pods
//
//  Created by Ian Outterside on 02/12/2015.
//
//

#import <Foundation/Foundation.h>

@interface NSDictionary (KMDDDDictionaryAdditions)

- (BOOL)isDuplicated;
- (void)trackDuplicate;

@end
