//
//  APCache.h
//  AdPieSDK
//
//  Created by sunny on 2017. 11. 7..
//  Copyright © 2017년 GomFactory. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APCache : NSObject

+ (instancetype)sharedCache;

/*
 * Do NOT call any of the following methods on the main thread, potentially lengthy wait for disk IO
 */
- (BOOL)cachedDataExistsForKey:(NSString *)key;
- (NSData *)retrieveDataForKey:(NSString *)key;
- (void)storeData:(NSData *)data forKey:(NSString *)key;
- (void)removeAllDataFromCache;
- (void)setInMemoryCacheEnabled:(BOOL)enabled;

@end
