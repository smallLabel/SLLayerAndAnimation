//
//  ViewController.m
//  SL3DLayer
//
//  Created by smallLabel on 2017/8/3.
//  Copyright © 2017年 smallLabel. All rights reserved.
//

#import "ViewController.h"
#import <GLKit/GLKit.h>
#import <CoreGraphics/CoreGraphics.h>

#define LIGHT_DIRECTION 0, 1, -0.5
#define AMBIENT_LIGHT 0.5

@interface ViewController ()

{
    CGPoint _lastTranslation;
}
@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *faces;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self addGesture];
    
    CATransform3D perspective = CATransform3DIdentity;
    perspective.m34 = -1.0 / 500.0;
    perspective = CATransform3DRotate(perspective, -M_PI_4, 1, 0, 0);
    perspective = CATransform3DRotate(perspective, -M_PI_4, 0, 1, 0);
    self.view.layer.sublayerTransform = perspective;
    //add cube face 1
    CATransform3D transform = CATransform3DMakeTranslation(0, 0, 100);
//    [self addFace:0 withTransform:transform];
    //add cube face 2
    transform = CATransform3DMakeTranslation(50, 50, 0);
//    transform = CATransform3DMakeTranslation(100, 0, 0);
    transform = CATransform3DTranslate(transform, 100, 0, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 0, 1, 0);
//    transform = CATransform3DMakeRotation(M_PI_2, 0, 1, 0);
//    transform = CATransform3DTranslate(transform, 100, 0, 0);
    [self addFace:1 withTransform:transform];
    //add cube face 3
    transform = CATransform3DMakeTranslation(50, 50, 0);
    transform = CATransform3DTranslate(transform, 0, -100, 0);
    
//    transform = CATransform3DMakeTranslation(0, -100, 0);
    transform = CATransform3DRotate(transform, M_PI_2, 1, 0, 0);
    [self addFace:2 withTransform:transform];
    //add cube face 4
    transform = CATransform3DMakeTranslation(0, 100, 0);
    transform = CATransform3DRotate(transform, -M_PI_2, 1, 0, 0);
//    [self addFace:3 withTransform:transform];
    //add cube face 5
    transform = CATransform3DMakeTranslation(-100, 0, 0);
    transform = CATransform3DRotate(transform, -M_PI_2, 0, 1, 0);
//    [self addFace:4 withTransform:transform];
    //add cube face 6
    transform = CATransform3DMakeTranslation(0, 0, -100);
    transform = CATransform3DRotate(transform, M_PI, 0, 1, 0);
//    [self addFace:5 withTransform:transform];
    
}

- (void)addGesture {
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.view addGestureRecognizer:pan];
    UIRotationGestureRecognizer *rotation = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotation:)];
    [self.view addGestureRecognizer:rotation];
}

- (void)pan:(UIPanGestureRecognizer *)pan {
    if (pan.state == UIGestureRecognizerStateBegan) {
        _lastTranslation = CGPointZero;
    }
    CGPoint translation = [pan translationInView:self.view];
    CGPoint realTranslation = CGPointMake(translation.x - _lastTranslation.x, translation.y - _lastTranslation.y);
    _lastTranslation = translation;
    NSLog(@"%@",NSStringFromCGPoint(translation));
    [self updateTranslation:realTranslation];
}

- (void)rotation:(UIRotationGestureRecognizer *)rotation {
    
}

- (void)updateTranslation:(CGPoint)translation {
//    CATransform3D transform = CATransform3DMakeTranslation( translation.x, translation.y, 0);
    
    for (UIView *face in self.faces) {
//        face.layer.transform =  CATransform3DTranslate(face.layer.transform, <#CGFloat tx#>, <#CGFloat ty#>, <#CGFloat tz#>)
//        face.layer.transform = CATransform3DMakeTranslation(<#CGFloat tx#>, <#CGFloat ty#>, <#CGFloat tz#>)
    }
}


- (void)addFace:(NSInteger)index withTransform:(CATransform3D)transform3D {
    UIView *face = self.faces[index];
    CGSize center = self.view.bounds.size;
    face.center = CGPointMake(center.width/2.0, center.height/2.0);
    face.layer.transform = transform3D;
    [self applyLightingToFace:face.layer];
}

- (void)applyLightingToFace:(CALayer *)face
{
    //add lighting layer
    CALayer *layer = nil;
    if (face.sublayers.count == 0) {
        layer = [CALayer layer];
        layer.frame = face.bounds;
        [face addSublayer:layer];
    }
    layer = face.sublayers.lastObject;
    //convert the face transform to matrix
    //(GLKMatrix4 has the same structure as CATransform3D)
    //译者注：GLKMatrix4和CATransform3D内存结构一致，但坐标类型有长度区别，所以理论上应该做一次float到CGFloat的转换，感谢[@zihuyishi](https://github.com/zihuyishi)同学~
    CATransform3D transform = face.transform;
//    GLKMatrix4 matrix4 = *(GLKMatrix4 *)&transform;
    GLKMatrix4 matrix4 = GLKMatrix4Make(transform.m11, transform.m12, transform.m13, transform.m14, transform.m21, transform.m22, transform.m23, transform.m24, transform.m31, transform.m32, transform.m33, transform.m34, transform.m41, transform.m42, transform.m43, transform.m44);
    GLKMatrix3 matrix3 = GLKMatrix4GetMatrix3(matrix4);
    //get face normal
    GLKVector3 normal = GLKVector3Make(0, 0, 1);
    normal = GLKMatrix3MultiplyVector3(matrix3, normal);
    normal = GLKVector3Normalize(normal);
    //get dot product with light direction
    GLKVector3 light = GLKVector3Normalize(GLKVector3Make(LIGHT_DIRECTION));
    float dotProduct = GLKVector3DotProduct(light, normal);
    //set lighting layer opacity
    CGFloat shadow = 1 + dotProduct - AMBIENT_LIGHT;
//    UIColor *color = [UIColor colorWithRed:1.0 green:0 blue:0 alpha:shadow];
    UIColor *color = [UIColor colorWithWhite:0 alpha:shadow];
    
    layer.backgroundColor = color.CGColor;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
