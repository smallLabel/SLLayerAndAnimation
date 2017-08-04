//
//  ViewController.m
//  SLReplicatorLayer
//
//  Created by smallLabel on 2017/8/4.
//  Copyright © 2017年 smallLabel. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *replicatorView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CAReplicatorLayer *layer = [CAReplicatorLayer layer];
    layer.instanceCount = 60;
    layer.frame = self.replicatorView.bounds;
    [self.replicatorView.layer addSublayer:layer];
    
    CATransform3D transform = CATransform3DIdentity;
    transform = CATransform3DRotate(transform, M_PI / 30.0, 0, 0, 1);
    layer.instanceTransform = transform;
    
    layer.instanceBlueOffset = -0.01;
//    layer.instanceGreenOffset = -0.1;
    layer.instanceRedOffset = -0.01;
    
    CALayer *llayer = [CALayer layer];
    llayer.frame = CGRectMake((sqrt(2)-1)/2*200/sqrt(2), (sqrt(2)-1)/2*200/sqrt(2), 15, 3);
    llayer.backgroundColor = [UIColor whiteColor].CGColor;
    llayer.transform = CATransform3DMakeRotation(M_PI_4, 0, 0, 1);
    [layer addSublayer:llayer];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
