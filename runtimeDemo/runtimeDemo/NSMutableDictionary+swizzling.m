//
//  NSMutableDictionary+swizzling.m
//  runtimeDemo
//
//  Created by 张亚飞 on 2019/6/4.
//  Copyright © 2019 张亚飞. All rights reserved.
//

#import "NSMutableDictionary+swizzling.h"
#import <objc/runtime.h>
#import "NSObject+swizzling.h"

@implementation NSMutableDictionary (swizzling)


+(void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [objc_getClass("__NSDictionaryM") swizzleSelector:@selector(setValue:forKey:) withSwizzledSelector:@selector(safeSetValue:forKey:)];
        [objc_getClass("__NSDictionaryM") swizzleSelector:@selector(setObject:forKey:) withSwizzledSelector:@selector(safeSetObject:forKey:)];
        [objc_getClass("__NSDictionaryM") swizzleSelector:@selector(removeObjectForKey:) withSwizzledSelector:@selector(safeRemoveObjectForKey:)];
        
    });
}
- (void)safeSetValue:(id)value forKey:(NSString *)key
{
    if (key == nil || value == nil || [key isEqual:[NSNull null]] || [value isEqual:[NSNull null]]) {
#if DEBUG
        NSLog(@"%s call -safeSetValue:forKey:, key或vale为nil或null", __FUNCTION__);
#endif
        return;
    }
    
    [self safeSetValue:value forKey:key];
}

- (void)safeSetObject:(id)anObject forKey:(id<NSCopying>)aKey
{
    if (aKey == nil || anObject == nil || [anObject isEqual:[NSNull null]]) {
#if DEBUG
        NSLog(@"%s call -safeSetObject:forKey:, key或vale为nil或null", __FUNCTION__);
#endif
        return;
    }
    
    [self safeSetObject:anObject forKey:aKey];
}

- (void)safeRemoveObjectForKey:(id)aKey
{
    if (aKey == nil || [aKey isEqual:[NSNull null]] ) {
#if DEBUG
        NSLog(@"%s call -safeRemoveObjectForKey:, aKey为nil或null", __FUNCTION__);
#endif
        return;
    }
    [self safeRemoveObjectForKey:aKey];
}





@end
