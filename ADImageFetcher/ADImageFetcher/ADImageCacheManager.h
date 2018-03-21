//
//  ADImageCacheManager.h
//  ADMonitorPlatform
//
//  Created by Andy on 06/02/2018.
//  Copyright © 2018 Andy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADImageCacheManager : NSObject

@property (nonatomic, assign) NSUInteger threshold;

+ (instancetype)manager;
- (NSArray *)allCachedImages;

- (void)cacheObject:(id)object forKey:(NSString *)key;
- (id)objectForKey:(NSString *)key;

@end
