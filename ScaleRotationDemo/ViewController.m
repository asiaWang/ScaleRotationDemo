//
//  ViewController.m
//  ScaleRotationDemo
//
//  Created by bo on 16/3/10.
//  Copyright © 2016年 com.pencho.com. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIGestureRecognizerDelegate>
@property (nonatomic,assign)CGFloat scale;
@property (nonatomic,assign)CGFloat rotation;
@property (nonatomic,assign)CGFloat tx;
@property (nonatomic,assign)CGFloat ty;

@property (nonatomic,strong)UIView *demoView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [self addSubViews];
}

- (void)addSubViews {
    self.demoView = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width / 2 - 40, self.view.frame.size.height / 2 - 40, 80, 80)];
    self.demoView.userInteractionEnabled = YES;
    self.demoView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:self.demoView];
    self.view.userInteractionEnabled = YES;
    
    [self addGestures];
}

- (void)addGestures {
    UIPinchGestureRecognizer *pichGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchGestureRecognizer:)];
    [self.view  addGestureRecognizer:pichGesture];
    
    UIRotationGestureRecognizer *rotationGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotationGestureRecognizer:)];
    [self.view addGestureRecognizer:rotationGesture];
}

- (void)pinchGestureRecognizer:(UIPinchGestureRecognizer *)sender {
    self.scale = sender.scale;
    [self updateTransformWithOffset:CGPointZero];
}

- (void)rotationGestureRecognizer:(UIRotationGestureRecognizer *)sender {
    self.rotation = sender.rotation;
    [self updateTransformWithOffset:CGPointZero];
}

- (void)updateTransformWithOffset:(CGPoint)translation {
    self.demoView.transform = CGAffineTransformMakeTranslation(translation.x + self.tx, translation.y + self.ty);
    self.demoView.transform = CGAffineTransformScale(self.demoView.transform, self.scale, self.scale);
    self.demoView.transform = CGAffineTransformRotate(self.demoView.transform, self.rotation);
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
