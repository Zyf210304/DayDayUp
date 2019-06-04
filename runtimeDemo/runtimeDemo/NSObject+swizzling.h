//
//  NSObject+swizzling.h
//  runtimeDemo
//
//  Created by 张亚飞 on 2019/6/4.
//  Copyright © 2019 张亚飞. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

@interface NSObject (swizzling)


+ (void)swizzleSelector:(SEL)originalSelector withSwizzledSelector:(SEL)swizzledSelector;


@end

NS_ASSUME_NONNULL_END
