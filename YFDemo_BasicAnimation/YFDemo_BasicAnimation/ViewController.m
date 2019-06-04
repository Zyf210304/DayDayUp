//
//  ViewController.m
//  YFDemo_BasicAnimation
//
//  Created by 张亚飞 on 2018/4/15.
//  Copyright © 2018年 张亚飞. All rights reserved.
//

#import "ViewController.h"

#define buttonName @[@"位移",@"缩放",@"透明度",@"旋转",@"圆角"]

@interface ViewController ()<CAAnimationDelegate>

@property(nonatomic,strong)CALayer *aniLayer;

@property(nonatomic,strong)CADisplayLink *displayLink;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.aniLayer = [[CALayer alloc] init];
    _aniLayer.bounds = CGRectMake(0, 0, 100, 100);
    _aniLayer.position = self.view.center;
    _aniLayer.backgroundColor = [UIColor redColor].CGColor;
    [self.view.layer addSublayer:_aniLayer];
    //
    for (int i = 0; i < 5; i++) {
        UIButton *aniButton = [UIButton buttonWithType:UIButtonTypeCustom];
        aniButton.tag = i;
        [aniButton setTitle:buttonName[i] forState:UIControlStateNormal];
        aniButton.exclusiveTouch = YES;
        aniButton.frame = CGRectMake(10, 50 + 60 * i, 100, 50);
        aniButton.backgroundColor = [UIColor blueColor];
        [aniButton addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:aniButton];
    }
    //
    //    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(handleDisplayLink:)];
    //    _displayLink.frameInterval = 30;
    //    [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

-(void)tapAction:(UIButton*)button{
    [self basicAnimationWithTag:button.tag];
}

-(void)handleDisplayLink:(CADisplayLink *)displayLink{
    NSLog(@"modelLayer_%@,presentLayer_%@",[NSValue valueWithCGPoint:_aniLayer.position],[NSValue valueWithCGPoint:_aniLayer.presentationLayer.position]);
}

-(void)basicAnimationWithTag:(NSInteger)tag{
    CABasicAnimation *basicAni = nil;
    switch (tag) {
        case 0:
            //初始化动画并设置keyPath
            basicAni = [CABasicAnimation animationWithKeyPath:@"position"];
            //到达位置
            basicAni.byValue = [NSValue valueWithCGPoint:CGPointMake(100, 100)];
            break;
        case 1:
            //初始化动画并设置keyPath
            basicAni = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
            //到达缩放
            basicAni.toValue = @(0.1f);
            break;
        case 2:
            //初始化动画并设置keyPath
            basicAni = [CABasicAnimation animationWithKeyPath:@"opacity"];
            //透明度
            basicAni.toValue=@(0.1f);
            break;
        case 3:
            //初始化动画并设置keyPath
            basicAni = [CABasicAnimation animationWithKeyPath:@"transform"];
            //3D
            basicAni.toValue=[NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_2+M_PI_4, 1, 1, 0)];
            break;
        case 4:
            //初始化动画并设置keyPath
            basicAni = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
            //圆角
            basicAni.toValue=@(50);
            break;
            
        default:
            break;
    }
    
    //设置代理
    basicAni.delegate = self;
    //延时执行
    //basicAni.beginTime = CACurrentMediaTime() + 2;
    //动画时间
    basicAni.duration = 1;
    //动画节奏
    basicAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //动画速率
    //basicAni.speed = 0.1;
    //图层是否显示执行后的动画执行后的位置以及状态
    //basicAni.removedOnCompletion = NO;
    //basicAni.fillMode = kCAFillModeForwards;
    //动画完成后是否以动画形式回到初始值
    basicAni.autoreverses = YES;
    //动画时间偏移
    //basicAni.timeOffset = 0.5;
    //添加动画
    [_aniLayer addAnimation:basicAni forKey:NSStringFromSelector(_cmd)];
}
//暂停动画
-(void)animationPause{
    //获取当前layer的动画媒体时间
    CFTimeInterval interval = [_aniLayer convertTime:CACurrentMediaTime() toLayer:nil];
    //设置时间偏移量,保证停留在当前位置
    _aniLayer.timeOffset = interval;
    //暂定动画
    _aniLayer.speed = 0;
}
//恢复动画
-(void)animationResume{
    //获取暂停的时间
    CFTimeInterval beginTime = CACurrentMediaTime() - _aniLayer.timeOffset;
    //设置偏移量
    _aniLayer.timeOffset = 0;
    //设置开始时间
    _aniLayer.beginTime = beginTime;
    //开始动画
    _aniLayer.speed = 1;
}
//停止动画
-(void)animationStop{
    //[_aniLayer removeAllAnimations];
    //[_aniLayer removeAnimationForKey:@"groupAnimation"];
}

#pragma mark - CAAnimationDelegate
-(void)animationDidStart:(CAAnimation *)anim{
    
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
