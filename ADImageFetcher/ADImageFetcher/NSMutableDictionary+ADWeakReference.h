//
//  NSMutableDictionary+ADWeakReference.h
//  ADMonitorPlatform
//
//  Created by Andy on 05/02/2018.
//  Copyright © 2018 Andy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (ADWeakReference)

- (void)ad_weak_setObject:(id)object forKey:(NSString *)key;
- (id)ad_weak_objectForKey:(NSString *)key;
- (void)ad_weak_setObjectsWithDictionary:(NSDictionary *)dictionary;

@end
