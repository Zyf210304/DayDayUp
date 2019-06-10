//
//  ViewController.m
//  semaphore
//
//  Created by 张亚飞 on 2019/6/10.
//  Copyright © 2019 张亚飞. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
//    [self defalut];
    
//    [self semaphore];
    
//    [self AFsemaphore];
    
//    [self notify];
    
//    [self semaphoreAndqueue];
    
    [self enterAndLeave];
    
}




- (void)defalut {
    dispatch_queue_t queue = dispatch_queue_create("serial", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        NSLog(@"111:%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"222:%@",[NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"333:%@",[NSThread currentThread]);
    });
}


- (void)semaphore {
    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSLog(@"任务1:%@",[NSThread currentThread]);
        dispatch_semaphore_signal(sem);
    });
    
    dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"任务2:%@",[NSThread currentThread]);
        dispatch_semaphore_signal(sem);
    });
    
    dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"任务3:%@",[NSThread currentThread]);
    });
}


- (void)AFsemaphore {
    NSString *urlString1 = @"/Users/ws/Downloads/Snip20161223_20.png";
    NSString *urlString2 = @"/Users/ws/Downloads/Snip20161223_21.png";
    // 创建信号量
    dispatch_semaphore_t sem = dispatch_semaphore_create(0);
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//
//        [manager POST:urlString1 parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
//
//        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            NSLog(@"1完成！");
//            // 发送信号量
//            dispatch_semaphore_signal(sem);
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            NSLog(@"1失败！");
//            // 发送信号量
//            dispatch_semaphore_signal(sem);
//        }];
//    });
//
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        // 等待信号量
//        dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
//        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//
//        [manager POST:urlString2 parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
//
//        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            NSLog(@"2完成！");
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            NSLog(@"2失败！");
//        }];
//    });
}



- (void)notify {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, queue, ^{
        NSLog(@"1");
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"2");
    });
    dispatch_group_async(group, queue, ^{
        NSLog(@"3");
    });
    
    dispatch_group_notify(group, queue, ^{
        NSLog(@"done");
    });
}

//信号量+异步组
- (void)semaphoreAndqueue {
    dispatch_group_t grp = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("concurrent.queue", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_group_async(grp, queue, ^{
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        NSLog(@"task1 begin : %@",[NSThread currentThread]);
        dispatch_async(queue, ^{
            NSLog(@"task1 finish : %@",[NSThread currentThread]);
            dispatch_semaphore_signal(sema);
        });
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    });
    dispatch_group_async(grp, queue, ^{
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        NSLog(@"task2 begin : %@",[NSThread currentThread]);
        dispatch_async(queue, ^{
            NSLog(@"task2 finish : %@",[NSThread currentThread]);
            dispatch_semaphore_signal(sema);
        });
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    });
    dispatch_group_notify(grp, dispatch_get_main_queue(), ^{
        NSLog(@"refresh UI");
    });
}

//dispatch_group_enter()和dispatch_group_leave()
- (void)enterAndLeave {
    dispatch_group_t group =dispatch_group_create();
    dispatch_queue_t globalQueue=dispatch_get_global_queue(0, 0);
    
    dispatch_group_enter(group);
    
    //模拟多线程耗时操作
    dispatch_group_async(group, globalQueue, ^{
        dispatch_async(globalQueue, ^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                NSLog(@"%@---block1结束。。。",[NSThread currentThread]);
                dispatch_group_leave(group);
            });
        });
        NSLog(@"%@---1结束。。。",[NSThread currentThread]);
    });
    
    dispatch_group_enter(group);
    //模拟多线程耗时操作
    dispatch_group_async(group, globalQueue, ^{
        dispatch_async(globalQueue, ^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                NSLog(@"%@---block2结束。。。",[NSThread currentThread]);
                dispatch_group_leave(group);
            });
        });
        NSLog(@"%@---2结束。。。",[NSThread currentThread]);
    });
    
    dispatch_group_notify(group, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"%@---全部结束。。。",[NSThread currentThread]);
    });
}

//dispatch_semaphore_t将数据追加到数组
- (void)addData {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:100];
    // 创建为1的信号量
    dispatch_semaphore_t sem = dispatch_semaphore_create(1);
    for (int i = 0; i < 10000; i++) {
        dispatch_async(queue, ^{
            // 等待信号量
            dispatch_semaphore_wait(sem, DISPATCH_TIME_FOREVER);
            [arrayM addObject:[NSNumber numberWithInt:i]];
            NSLog(@"%@",[NSNumber numberWithInt:i]);
            // 发送信号量
            dispatch_semaphore_signal(sem);
        });
    }
}

@end
