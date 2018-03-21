//
//  ADImageCacheManager.m
//  ADMonitorPlatform
//
//  Created by Andy on 06/02/2018.
//  Copyright © 2018 Andy. All rights reserved.
//

#import "ADImageCacheManager.h"
#import "NSMutableDictionary+ADWeakReference.h"

@interface ADImageCacheManager()

@property (nonatomic, strong) NSMutableDictionary *cacheDictionary;
@property (nonatomic, strong) NSDate *reductionDate;

@end

@implementation ADImageCacheManager

+ (instancetype)manager;
{
    static ADImageCacheManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ADImageCacheManager alloc] init];
    });
    return manager;
}

- (instancetype)init
{
    if (self = [super init]) {
        _threshold = 3000;
        _reductionDate = [NSDate distantPast];
        [self _taskBeforeRunLoopEnterWaiting];
    }
    return self;
}

#pragma mark - public method

- (NSArray *)allCachedImages
{
    NSMutableArray *arr = [NSMutableArray array];
    for (NSString *key in self.cacheDictionary.allKeys) {
        id (^value)(void) = self.cacheDictionary[key];
        if (value()) {
            [arr addObject:value()];
        }else {
            [self.cacheDictionary removeObjectForKey:key];
        }
    }
    return arr.copy;
}

- (void)cacheObject:(id)object forKey:(NSString *)key
{
    [self.cacheDictionary ad_weak_setObject:object forKey:key];
}

- (id)objectForKey:(NSString *)key
{
    return [self.cacheDictionary ad_weak_objectForKey:key];
}

#pragma mark - private method

- (void)_taskBeforeRunLoopEnterWaiting
{
    __weak typeof(self) weakSelf = self;
    CFRunLoopRef runLoop = CFRunLoopGetCurrent();
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, kCFRunLoopBeforeWaiting, true, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        [weakSelf _cacheDictionaryReduction];
    });
    CFRunLoopAddObserver(runLoop, observer, kCFRunLoopDefaultMode);
}

- (void)_cacheDictionaryReduction
{
    NSDate *hourAgo = [NSDate dateWithTimeIntervalSinceNow:-60 * 60];
    if (self.cacheDictionary.count > self.threshold && [hourAgo compare:self.reductionDate] == NSOrderedDescending) {
        self.reductionDate = [NSDate date];
        for (NSString *key in self.cacheDictionary.allKeys) {
            id (^value)(void) = self.cacheDictionary[key];
            if (nil == value()) {
                [self.cacheDictionary removeObjectForKey:key];
            }
        }
    }
}

#pragma mark - getter and setter

- (NSMutableDictionary *)cacheDictionary
{
    if (!_cacheDictionary) {
        _cacheDictionary = [[NSMutableDictionary alloc] init];
    }
    return _cacheDictionary;
}

@end
