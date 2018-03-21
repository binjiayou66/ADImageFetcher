//
//  UIImage+ADCache.h
//  ADMonitorPlatform
//
//  Created by Andy on 05/02/2018.
//  Copyright © 2018 Andy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ADCache)

+ (instancetype)ad_imageNamed:(NSString *)name;
+ (instancetype)ad_imageNamed:(NSString *)name cache:(BOOL)cache;

@end
