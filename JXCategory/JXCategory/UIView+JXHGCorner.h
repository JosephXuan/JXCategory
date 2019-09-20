//
//  UIView+JXHGCorner.h
//  HGCorner
//
//  Created by zhh on 16/9/8.
//  Copyright © 2016年 zhh. All rights reserved.
//
//指定圆角 在原有基础上做了改动
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HGCornerPosition) {
    HGCornerPositionTop,
    HGCornerPositionLeft,
    HGCornerPositionBottom,
    HGCornerPositionRight,
    HGCornerPositionAll,
    HGCornerPositionCustom,
    HGCornerPositionBottomLeft,
    HGCornerPositionBottomRight,
    HGCornerPositionTopLeft,
    HGCornerPositionTopRight,
    HGCornerPositionWithLine// 有问题不要用
};

@interface UIView (JXHGCorner)

@property (nonatomic, assign) HGCornerPosition hg_cornerPosition;
@property (nonatomic, assign) CGFloat hg_cornerRadius;

@property (strong, nonatomic) UIColor * hg_lineColor;
//左上+右上
- (void)hg_setCornerOnTopWithRadius:(CGFloat)radius;
//左上+左下
- (void)hg_setCornerOnLeftWithRadius:(CGFloat)radius;
//左下+右下
- (void)hg_setCornerOnBottomWithRadius:(CGFloat)radius;
//右上+右下
- (void)hg_setCornerOnRightWithRadius:(CGFloat)radius;
//全部都切圆角
- (void)hg_setAllCornerWithCornerRadius:(CGFloat)radius;
//左下+右上
- (void)hg_setCornerOnCustomWithCornerRadius:(CGFloat)radius;
//左下
- (void)hg_setCornerOnBottomLeftWithCornerRadius:(CGFloat)radius;
//右下
- (void)hg_setCornerOnBottomRightWithCornerRadius:(CGFloat)radius;
//左上
- (void)hg_setCornerOnTopLeftWithCornerRadius:(CGFloat)radius;
//右上
- (void)hg_setCornerOnTopRightWithCornerRadius:(CGFloat)radius;
//切圆角并画边框颜色 // 有问题不要用
- (void)hg_setCornerOnCustomLineWithCornerRadius:(CGFloat)radius withLineColor:(UIColor *)lineColor;


//没有圆角
- (void)hg_setNoneCorner;

@end
