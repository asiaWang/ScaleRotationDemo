//
//  PointCategory.m
//  PAI2.0
//
//  Created by bo on 16/3/7.
//  Copyright © 2016年 pencho. All rights reserved.
//

#import "PointCategory.h"


#define pi 3.14159265358979323846
#define degreesToRadian(x) (pi * x /180.0)
#define radiansToDegrees(x) (180.0 * x / pi)

@implementation PointCategory

+ (CGFloat)distansePoint:(CGPoint)firstPoint toPoint:(CGPoint)secondPoint {
    CGFloat deltaX = secondPoint.x - firstPoint.x;
    CGFloat deltaY = secondPoint.y - firstPoint.y;
    return sqrt(deltaX *deltaX + deltaY *deltaY);
    
}

+ (CGFloat)anglePoint:(CGPoint)firstPoint toPoint:(CGPoint)secondPoint {
    CGFloat height = secondPoint.y - firstPoint.y;
    CGFloat width = firstPoint.x - secondPoint.x;
    CGFloat rads = atan(height / width);
    return radiansToDegrees(rads);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
