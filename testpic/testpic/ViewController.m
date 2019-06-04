//
//  ViewController.m
//  testpic
//
//  Created by 张亚飞 on 2018/8/9.
//  Copyright © 2018年 张亚飞. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIImageView *imagev = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 199)];
    UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://3fef8ca1dba563652e0b4b08dfb63fe5.oss-cn-hangzhou.aliyuncs.com/images/other/1533802744213.jpg"]]];
    imagev.image = img;
    [self.view addSubview:imagev];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
