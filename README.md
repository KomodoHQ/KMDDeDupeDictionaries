# KMDDeDupeDictionaries

[![Version](https://img.shields.io/cocoapods/v/KMDDeDupeDictionaries.svg?style=flat)](http://cocoapods.org/pods/KMDDeDupeDictionaries)
[![License](https://img.shields.io/cocoapods/l/KMDDeDupeDictionaries.svg?style=flat)](http://cocoapods.org/pods/KMDDeDupeDictionaries)
[![Platform](https://img.shields.io/cocoapods/p/KMDDeDupeDictionaries.svg?style=flat)](http://cocoapods.org/pods/KMDDeDupeDictionaries)

## Description

KMDDeDupeDictionaries is an iOS Library to track if dictionaries are duplicated within a given timeout period. This can be useful for example in discarding duplicate remote notifications by examining the dictionaries sent from the server.

This libary supports overriding the default storage type (PList) with custom storage such as SQLLite or NSUserDefaults. Simply conform to KMDDDStorageType and set StorageType to be custom on the manager.

Note: This library is an initial version, as such has not been extensively tested yet (nor does it include tests as yet). Library is very much subject to change.

## Usage

1. Pod install.
2. Setup a manager. A manager requires a storage type (default will use PLists), a unique identifier (in case you wish to have more than one tracker) and a timeout after which old entries will be pruned
  
    ```objective-c
    [[KMDDDManager sharedDictionaryManager] setStoreType:KMDDDStoreTypeDefault identifier:@"NotificationManager" timeout:60*60*24];
    ```

3. Check a dictionary is a duplicate
  
    ```objective-c
    [[KMDDDManager sharedDictionaryManager] checkDictionaryisDuplicate:userInfo];
    ```
    
     OR use convenience method added to NSDictionary
    
    ```objective-c
    [userInfo isDuplicated]
    ```
4. Track a dictionary

    ```objective-c
    [[KMDDDManager sharedDictionaryManager] manageDictionary:userInfo];
    ```

    OR use convenience method added to NSDictionary

    ```objective-c
    [userInfo trackDuplicate]
    ```

## Requirements
No dependancies, though please note this library uses CommonCrypto to generate MD5 hashes and may need to be considered as part of US Export Licence law.

## Installation

KMDDeDupeDictionaries is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "KMDDeDupeDictionaries"
```

## Author

Ian Outterside, ian@komododigital.co.uk

## License

KMDDeDupeDictionaries is available under the MIT license. See the LICENSE file for more info.
