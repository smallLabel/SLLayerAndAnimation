//
//  ViewController.m
//  SLGradientLayer
//
//  Created by smallLabel on 2017/8/4.
//  Copyright © 2017年 smallLabel. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = self.view.frame;
    [self.view.layer addSublayer:layer];
    
    //红橙黄绿青蓝紫
    UIColor *red = [UIColor redColor];
    UIColor *orange = [UIColor orangeColor];
    UIColor *yellow = [UIColor yellowColor];
    UIColor *green = [UIColor greenColor];
    UIColor *magenta = [UIColor magentaColor];
    UIColor *blue = [UIColor blueColor];
    UIColor *purple = [UIColor purpleColor];
    layer.colors = @[(__bridge id)red.CGColor, (__bridge id)orange.CGColor,(__bridge id)yellow.CGColor,(__bridge id)green.CGColor,(__bridge id)magenta.CGColor,(__bridge id)blue.CGColor,(__bridge id)purple.CGColor];
    layer.startPoint = CGPointMake(0, 0);
    layer.endPoint = CGPointMake(1, 1);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
