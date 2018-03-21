//
//  NSMutableDictionary+ADWeakReference.m
//  ADMonitorPlatform
//
//  Created by Andy on 05/02/2018.
//  Copyright © 2018 Andy. All rights reserved.
//

#import "NSMutableDictionary+ADWeakReference.h"

typedef id (^ADWeakReference)(void);

ADWeakReference ad_weakReferenceAndWrap(id object)
{
    __weak id weakref = object;
    return ^{return weakref;};
}

id ad_weakReferenceNonretainedObjectValue(ADWeakReference ref)
{
    return ref ? ref() : nil;
}

@implementation NSMutableDictionary (ADWeakReference)

- (void)ad_weak_setObject:(id)object forKey:(NSString *)key
{
    if (!object || key.length <= 0) return;
    [self setObject:ad_weakReferenceAndWrap(object) forKey:key];
}

- (id)ad_weak_objectForKey:(NSString *)key
{
    if(key.length <= 0) return nil;
    return ad_weakReferenceNonretainedObjectValue(self[key]);
}

- (void)ad_weak_setObjectsWithDictionary:(NSDictionary *)dictionary
{
    for (NSString *key in dictionary.allKeys) {
        [self ad_weak_setObject:dictionary[key] forKey:key];
    }
}

@end
