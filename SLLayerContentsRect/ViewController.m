//
//  ViewController.m
//  SLLayerContentsRect
//
//  Created by smallLabel on 2017/8/1.
//  Copyright © 2017年 smallLabel. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSCalendar *_calendar;
}
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *views;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *image = [UIImage imageNamed:@"nums"];
    _calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    for (UIView *view in self.views) {
        view.layer.contents = (__bridge id _Nullable)(image.CGImage);
        view.layer.contentsRect = CGRectMake(0, 0, 0.1, 1.0);
        view.layer.contentsGravity = kCAGravityResizeAspect;
    }
    [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [self tick];
    }];
    
}

- (void)tick {
    
    NSUInteger units = NSCalendarUnitHour | NSCalendarUnitMinute |
    NSCalendarUnitSecond;
    NSDateComponents *components = [_calendar components:units fromDate:[NSDate date]];
    [self setNum:components.hour/10 toLayer:self.views[0]];
    [self setNum:components.hour%10 toLayer:self.views[1]];
    [self setNum:components.minute/10 toLayer:self.views[2]];
    [self setNum:components.minute%10 toLayer:self.views[3]];
    [self setNum:components.second/10 toLayer:self.views[4]];
    [self setNum:components.second%10 toLayer:self.views[5]];
    
}

- (void)setNum:(NSUInteger)num toLayer:(UIView *)view {
    view.layer.contentsRect = CGRectMake(num*0.1, 0, 0.1, 1.0);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
