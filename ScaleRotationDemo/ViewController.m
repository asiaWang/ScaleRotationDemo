//
//  ViewController.m
//  ScaleRotationDemo
//
//  Created by bo on 16/3/10.
//  Copyright © 2016年 com.pencho.com. All rights reserved.
//


/*
 * cource http://iphonedevsdk.com/forum/iphone-sdk-development/79136-rotate-scale-and-drag-more-than-one-uiimageview.html
 **/

#import "ViewController.h"
#import "PointCategory.h"

@interface ViewController ()<UIGestureRecognizerDelegate>
@property (nonatomic,assign)CGFloat scale;
@property (nonatomic,assign)CGFloat rotation;
@property (nonatomic,assign)CGFloat tx;
@property (nonatomic,assign)CGFloat ty;

@property (nonatomic,assign)CGFloat angle;
@property (nonatomic,assign)CGFloat pointScale;
@property (nonatomic,assign)CGFloat pointEndDistense;
@property (nonatomic,assign)CGFloat pointStartDistense;

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
    
//    [self addGestures];
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


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSSet *set = (NSSet *)[event allTouches];
    NSArray *touchArray = [set allObjects];

    if (touchArray.count == 1) {
        
    }else if (touchArray.count == 2){
        self.pointScale = 1;
        
        UITouch *touch1 = (UITouch *)touchArray[0];
        UITouch *touch2 = (UITouch *)touchArray[1];
        
        CGPoint point1,point2;
        point1 = [touch1 locationInView:self.view];
        point2 = [touch2 locationInView:self.view];
        
        self.angle = [PointCategory anglePoint:point1 toPoint:point2];
        self.pointStartDistense = [PointCategory distansePoint:point1 toPoint:point2];
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSSet *set = (NSSet *)[event allTouches];
    NSArray *touchArray = [set allObjects];
    if (touchArray.count == 1) {
        
    }else if (touchArray.count == 2){        

        UITouch *touch1 = (UITouch *)touchArray[0];
        UITouch *touch2 = (UITouch *)touchArray[1];
        
        CGPoint point1,point2;
        point1 = [touch1 locationInView:self.view];
        point2 = [touch2 locationInView:self.view];
        
        self.angle = [PointCategory anglePoint:point1 toPoint:point2];
        self.pointEndDistense = [PointCategory distansePoint:point1 toPoint:point2];
        self.pointScale = [self scaleWithDistense:self.pointStartDistense endDistense:self.pointEndDistense];
        [self updateTansform];
        self.pointStartDistense = self.pointEndDistense;
        self.pointScale = 1;
        self.angle = 0;
    }
}

- (void)updateTansform {
    self.demoView.transform = CGAffineTransformScale(self.demoView.transform, self.pointScale, self.pointScale);
    self.demoView.transform = CGAffineTransformRotate(self.demoView.transform, self.angle);
}
                           
- (CGFloat)scaleWithDistense:(CGFloat)startDistense endDistense:(CGFloat)endDistense {
    if (startDistense > endDistense) {
        return endDistense / startDistense;
    }else {
        return 1 + startDistense / endDistense;
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
