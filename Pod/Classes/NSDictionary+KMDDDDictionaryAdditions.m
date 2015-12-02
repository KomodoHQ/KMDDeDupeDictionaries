//
//  NSDictionary+KMDDDDictionaryAdditions.m
//  Pods
//
//  Created by Ian Outterside on 02/12/2015.
//
//

#import "NSDictionary+KMDDDDictionaryAdditions.h"
#import <KMDDeDupeDictionaries/KMDDDManager.h>

@implementation NSDictionary (KMDDDDictionaryAdditions)

- (BOOL)isDuplicated {
    return [[KMDDDManager sharedDictionaryManager] checkDictionaryisDuplicate:self];
}

- (void)trackDuplicate {
    return [[KMDDDManager sharedDictionaryManager] manageDictionary:self];
}

@end
