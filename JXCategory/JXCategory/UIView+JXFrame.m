//
//  UIView+JXFrame.m
//  kyt
//
//  Created by apple on 14-6-27.
//  Copyright (c) 2014年 kyt. All rights reserved.
//

#import "UIView+JXFrame.h"

@implementation UIView (JXFrame)
/** view的x坐标的set方法*/
- (void)setX_X:(CGFloat)x_X
{
    CGRect frame = self.frame;
    frame.origin.x = x_X;
    self.frame = frame;
}
/** view的x坐标的get方法*/
- (CGFloat)x_X
{
    return self.frame.origin.x;
}
/** view的y坐标的set方法*/
- (void)setY_Y:(CGFloat)y_Y
{
    CGRect frame = self.frame;
    frame.origin.y = y_Y;
    self.frame = frame;
}
/** view的y坐标的get方法*/
- (CGFloat)y_Y
{
    return self.frame.origin.y;
}
/** viewx中心的set方法*/
- (void)setCenter_X:(CGFloat)center_X
{
    CGPoint center = self.center;
    center.x = center_X;
    self.center = center;
}
/** viewx中心的get方法*/
- (CGFloat)center_X
{
    return self.center.x;
}
/** viewy中心的set方法*/
- (void)setCenter_Y:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}
/** viewy中心的get方法*/
- (CGFloat)center_Y
{
    return self.center.y;
}
/** 宽度的set方法*/
- (void)setWidth_W:(CGFloat)width_W
{
    CGRect frame = self.frame;
    frame.size.width = width_W;
    self.frame = frame;
}
/** 宽度的get方法*/
- (CGFloat)width_W
{
    return self.frame.size.width;
}
/** 高度的set方法*/
- (void)setHeight_H:(CGFloat)height_H
{
    CGRect frame = self.frame;
    frame.size.height = height_H;
    self.frame = frame;
}
/** 高的的get方法*/
- (CGFloat)height_H
{
    return self.frame.size.height;
}
/** size的set方法*/
- (void)setSize_S:(CGSize)size_S
{
//    self.width = size.width;
//    self.height = size.height;
    CGRect frame = self.frame;
    frame.size = size_S;
    self.frame = frame;
}
/** size的get方法*/
- (CGSize)size_S
{
    return self.frame.size;
}

@end
