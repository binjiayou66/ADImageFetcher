//
//  UIImage+ADCache.m
//  ADMonitorPlatform
//
//  Created by Andy on 05/02/2018.
//  Copyright © 2018 Andy. All rights reserved.
//

#import "UIImage+ADCache.h"
#import "NSMutableDictionary+ADWeakReference.h"
#import "ADImageCacheManager.h"

@implementation UIImage (ADCache)

+ (instancetype)ad_imageNamed:(NSString *)name
{
    return [self ad_imageNamed:name cache:YES];
}

+ (instancetype)ad_imageNamed:(NSString *)name cache:(BOOL)cache
{
    if (name.length <= 0) return nil;
    if ([name hasSuffix:@"/"]) return nil;
    NSString *res = name.stringByDeletingPathExtension;
    NSString *ext = name.pathExtension;
    NSString *path = nil;
    CGFloat scale = 1;
    NSArray *exts = ext.length > 0 ? @[ext] : @[@"", @"png", @"jpeg", @"jpg", @"gif", @"webp", @"apng"];
    NSArray *scales = [self preferredScales];
    for (int s = 0; s <= scales.count; s++) {
        NSString *scaledName = nil;
        if (s < scales.count) {
            scale = [scales[s] floatValue];
            scaledName = [res stringByAppendingFormat:@"@%@x", @(scale)];
        } else {
            scaledName = res;
        }
        for (NSString *e in exts) {
            path = [[NSBundle mainBundle] pathForResource:scaledName ofType:e];
            if (path) break;
        }
        if (path) break;
    }
    if (path.length == 0) return nil;
    UIImage *image = nil;
    if (cache) {
        image = [[ADImageCacheManager manager] objectForKey:path];
        if (image) return image;
    }
    image = [UIImage imageWithContentsOfFile:path];
    if (image && cache) [[ADImageCacheManager manager] cacheObject:image forKey:path];
    
    return image;
}

# pragma mark - private method

+ (NSArray *)preferredScales
{
    static NSArray *scales;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CGFloat screenScale = [[UIScreen mainScreen] scale];
        if (screenScale <= 1) {
            scales = @[@1, @2, @3];
        } else if (screenScale <= 2) {
            scales = @[@2, @3, @1];
        } else {
            scales = @[@3, @2, @1];
        }
    });
    return scales;
}

@end
