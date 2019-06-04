//
//  ViewController.m
//  runtimeDemo
//
//  Created by 张亚飞 on 2019/6/4.
//  Copyright © 2019 张亚飞. All rights reserved.
//

#import "ViewController.h"

#import "NSMutableArray+swizzling.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self arrayAbout];
    [self addButtonUI];
}

- (void)arrayAbout {
    NSMutableArray *array = [@[@"value", @"value1"]     mutableCopy];
    [array lastObject];
    
    [array removeObject:@"value"];
    [array removeObject:nil];
    [array addObject:@"12"];
    [array addObject:nil];
    [array insertObject:nil atIndex:0];
    [array insertObject:@"sdf" atIndex:10];
    [array objectAtIndex:100];
    [array removeObjectAtIndex:10];
    
    NSMutableArray *anotherArray = [[NSMutableArray alloc] init];
    [anotherArray objectAtIndex:0];
    
    NSString *nilStr = nil;
    NSArray *array1 = @[@"ara", @"sdf", @"dsfdsf", nilStr];
    NSLog(@"array1.count = %lu", array1.count);
    
    // 测试数组中有数组
    NSArray *array2 = @[@[@"12323", @"nsdf", nilStr],     @[@"sdf", @"nilsdf", nilStr, @"sdhfodf"]];
}



- (void)addButtonUI {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 100, 100);
    [self.view addSubview:btn];
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(btndidSelect) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btndidSelect {
    NSLog(@"11111");
}


@end
