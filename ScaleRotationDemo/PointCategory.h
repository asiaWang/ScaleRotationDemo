//
//  PointCategory.h
//  PAI2.0
//
//  Created by bo on 16/3/7.
//  Copyright © 2016年 pencho. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PointCategory : UIView


/*
 * 2点之间的距离
 **/
+ (CGFloat)distansePoint:(CGPoint)firstPoint toPoint:(CGPoint)secondPoint;

/*
 * 2点之间的角度
 **/
+ (CGFloat)anglePoint:(CGPoint)firstPoint toPoint:(CGPoint)secondPoint;

@end
