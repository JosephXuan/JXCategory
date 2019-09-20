//
//  UIView+JXHGCorner.m
//  HGCorner
//
//  Created by zhh on 16/9/8.
//  Copyright © 2016年 zhh. All rights reserved.
//

#import "UIView+JXHGCorner.h"
#import <objc/runtime.h>

static NSString * const HGCornerPositionKey = @"HGCornerPositionKey";
static NSString * const HGCornerRadiusKey = @"HGCornerRadiusKey";
static NSString * const HGLineColorKey = @"HGLineColorKey";

@implementation UIView (JXHGCorner)

@dynamic hg_cornerPosition;
- (HGCornerPosition)hg_cornerPosition
{
    return [objc_getAssociatedObject(self, &HGCornerPositionKey) integerValue];
}

- (void)setHg_cornerPosition:(HGCornerPosition)hg_cornerPosition
{
    objc_setAssociatedObject(self, &HGCornerPositionKey, @(hg_cornerPosition), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@dynamic hg_cornerRadius;
- (CGFloat)hg_cornerRadius
{
    return [objc_getAssociatedObject(self, &HGCornerRadiusKey) floatValue];
}

- (void)setHg_cornerRadius:(CGFloat)hg_cornerRadius
{
    objc_setAssociatedObject(self, &HGCornerRadiusKey, @(hg_cornerRadius), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@dynamic hg_lineColor;
- (UIColor *)hg_lineColor
{
    return objc_getAssociatedObject(self, &HGLineColorKey);
}

- (void)setHg_lineColor:(UIColor *)hg_lineColor
{
    objc_setAssociatedObject(self, &HGLineColorKey, hg_lineColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


+ (void)load
{
    SEL ori = @selector(layoutSublayersOfLayer:);
    SEL new = NSSelectorFromString([@"hh_" stringByAppendingString:NSStringFromSelector(ori)]);
    hh_swizzle(self, ori, new);
}

void hh_swizzle(Class c, SEL orig, SEL new)
{
    Method origMethod = class_getInstanceMethod(c, orig);
    Method newMethod = class_getInstanceMethod(c, new);
    
    method_exchangeImplementations(origMethod, newMethod);
}

- (void)hh_layoutSublayersOfLayer:(CALayer *)layer
{
    [self hh_layoutSublayersOfLayer:layer];
    
    if (self.hg_cornerRadius > 0) {
        
        UIBezierPath *maskPath;
        switch (self.hg_cornerPosition) {
            case HGCornerPositionTop:
                maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                 byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight)
                                                       cornerRadii:CGSizeMake(self.hg_cornerRadius, self.hg_cornerRadius)];
                break;
            case HGCornerPositionLeft:
                maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                 byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerBottomLeft)
                                                       cornerRadii:CGSizeMake(self.hg_cornerRadius, self.hg_cornerRadius)];
                break;
            case HGCornerPositionBottom:
                maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                 byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerBottomRight)
                                                       cornerRadii:CGSizeMake(self.hg_cornerRadius, self.hg_cornerRadius)];
                break;
            case HGCornerPositionRight:
                maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                 byRoundingCorners:(UIRectCornerTopRight | UIRectCornerBottomRight)
                                                       cornerRadii:CGSizeMake(self.hg_cornerRadius, self.hg_cornerRadius)];
                break;
            case HGCornerPositionAll:
                maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                 byRoundingCorners:UIRectCornerAllCorners
                                                       cornerRadii:CGSizeMake(self.hg_cornerRadius, self.hg_cornerRadius)];
                break;
            case HGCornerPositionCustom:
                maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                 byRoundingCorners:(UIRectCornerBottomLeft | UIRectCornerTopRight)
                                                       cornerRadii:CGSizeMake(self.hg_cornerRadius, self.hg_cornerRadius)];
                break;
            case HGCornerPositionBottomLeft:
                maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                 byRoundingCorners:(UIRectCornerBottomLeft)
                                                       cornerRadii:CGSizeMake(self.hg_cornerRadius, self.hg_cornerRadius)];
                break;
            case HGCornerPositionBottomRight:
                maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                 byRoundingCorners:(UIRectCornerBottomRight )
                                                       cornerRadii:CGSizeMake(self.hg_cornerRadius, self.hg_cornerRadius)];
                break;
            case HGCornerPositionTopLeft:
                maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                 byRoundingCorners:(UIRectCornerTopLeft )
                                                       cornerRadii:CGSizeMake(self.hg_cornerRadius, self.hg_cornerRadius)];
                break;
            case HGCornerPositionTopRight:
                maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                 byRoundingCorners:(UIRectCornerTopRight )
                                                       cornerRadii:CGSizeMake(self.hg_cornerRadius, self.hg_cornerRadius)];
                break;
            case HGCornerPositionWithLine:
               maskPath= [self hg_setCornerForLineAllWithStrokeColor:self.hg_lineColor withFillColorWithFillColor:[UIColor clearColor] withCornerRadius:self.hg_cornerRadius];
                
                break;
                
                
        }
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = self.bounds;
        maskLayer.path = maskPath.CGPath;
        self.layer.mask = maskLayer;
        
    }
}

- (void)hg_setCornerOnTopWithRadius:(CGFloat)radius
{
    self.hg_cornerPosition = HGCornerPositionTop;
    self.hg_cornerRadius = radius;
}

- (void)hg_setCornerOnLeftWithRadius:(CGFloat)radius
{
    self.hg_cornerPosition = HGCornerPositionLeft;
    self.hg_cornerRadius = radius;
}

- (void)hg_setCornerOnBottomWithRadius:(CGFloat)radius
{
    self.hg_cornerPosition = HGCornerPositionBottom;
    self.hg_cornerRadius = radius;
}

- (void)hg_setCornerOnRightWithRadius:(CGFloat)radius
{
    self.hg_cornerPosition = HGCornerPositionRight;
    self.hg_cornerRadius = radius;
}

- (void)hg_setAllCornerWithCornerRadius:(CGFloat)radius
{
    self.hg_cornerPosition = HGCornerPositionAll;
    self.hg_cornerRadius = radius;
}
- (void)hg_setCornerOnCustomWithCornerRadius:(CGFloat)radius{
    self.hg_cornerPosition = HGCornerPositionCustom;
    self.hg_cornerRadius = radius;
}
- (void)hg_setCornerOnBottomLeftWithCornerRadius:(CGFloat)radius{
    self.hg_cornerPosition = HGCornerPositionBottomLeft;
    self.hg_cornerRadius = radius;
}
- (void)hg_setCornerOnBottomRightWithCornerRadius:(CGFloat)radius{
    self.hg_cornerPosition = HGCornerPositionBottomRight;
    self.hg_cornerRadius = radius;
}
- (void)hg_setCornerOnTopLeftWithCornerRadius:(CGFloat)radius{
    self.hg_cornerPosition = HGCornerPositionTopLeft;
    self.hg_cornerRadius = radius;
}
- (void)hg_setCornerOnTopRightWithCornerRadius:(CGFloat)radius{
    self.hg_cornerPosition = HGCornerPositionTopRight;
    self.hg_cornerRadius = radius;
}
- (void)hg_setCornerOnCustomLineWithCornerRadius:(CGFloat)radius withLineColor:(UIColor *)lineColor{
    self.hg_cornerPosition = HGCornerPositionWithLine;
    self.hg_cornerRadius = radius;
    self.hg_lineColor = lineColor;
}
-(UIBezierPath *)hg_setCornerForLineAllWithStrokeColor:(UIColor *)strokeColor withFillColorWithFillColor:(UIColor *)fillColor withCornerRadius:(CGFloat)radius{
    
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.bounds;
    
    CAShapeLayer *borderLayer = [CAShapeLayer layer];
    borderLayer.frame = self.bounds;
    borderLayer.lineWidth = 1.0f;
    //边框颜色
    borderLayer.strokeColor = strokeColor.CGColor;
    if (fillColor==nil) {
        fillColor=[UIColor clearColor];
    }
    //填充颜色
    borderLayer.fillColor = fillColor.CGColor;
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:radius];
    maskLayer.path = bezierPath.CGPath;
    borderLayer.path = bezierPath.CGPath;
    [self.layer insertSublayer:borderLayer atIndex:0];
    
    return bezierPath;
    
}

- (void)hg_setNoneCorner
{
    self.layer.mask = nil;
}

@end
