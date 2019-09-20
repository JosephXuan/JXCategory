//
//  UIView+JXFrame.h
//  kyt
//
//  Created by apple on 14-6-27.
//  Copyright (c) 2014年 kyt. All rights reserved.
//


#pragma mark  快速获取 View的 尺寸 宽高 大小等等
/**
 *  快速获取 View的 尺寸 宽高 大小等等 后面加_? 后缀为了防止和第三方布局发生冲突
 *
 */

#import <UIKit/UIKit.h>

@interface UIView (JXFrame)
/** View的 X 坐标*/
@property (nonatomic, assign) CGFloat x_X;
/** View的 Y 坐标*/
@property (nonatomic, assign) CGFloat y_Y;
/** View的 中心X*/
@property (nonatomic, assign) CGFloat center_X;
/** View的 中心Y*/
@property (nonatomic, assign) CGFloat center_Y;
/** View的 宽度*/
@property (nonatomic, assign) CGFloat width_W;
/** View的 高度*/
@property (nonatomic, assign) CGFloat height_H;
/** View的 size 大小*/
@property (nonatomic, assign) CGSize size_S;


@end
