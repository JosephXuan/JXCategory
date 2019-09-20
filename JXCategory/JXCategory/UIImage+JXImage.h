//
//  UIImage+JXImage.h
//  分类
//
//  Created by apple on 15-3-4.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (JXImage)
// instancetype默认会识别当前是哪个类或者对象调用，就会转换成对应的类的对象
// UIImage *

// 加载最原始的图片，没有渲染
+ (instancetype)imageWithOriginalName:(NSString *)imageName;

+ (instancetype)imageWithStretchableName:(NSString *)imageName;

+ (instancetype)createWithColor:(UIColor *)color size:(CGSize)size;
/*
 缩放图片，将图片缩放为指定尺寸大小
 */
- (UIImage*)imageWithOriginalImage:(UIImage*)originalImage scaledToSize:(CGSize)newSize;

/**
 高斯模糊

 @param image 图片
 @param blur 22
 @return 21
 */
+ (UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur ;

/**
 生成一张渐变色的图片
 @param colors 颜色数组
 @param rect 图片大小
 @return 返回渐变图片
 */
+ (UIImage *)gradientImageWithColors:(NSArray *)colors rect:(CGRect)rect;
/**
 噪点图片
  图片加入杂色, intensity: 0.0 ~ 1.0f, gary: YES标示单色噪点
 scale 比1 大就是噪点比较细密
 */

- (UIImage *)imageWithNoiseIntensity:(CGFloat)intensity gray:(BOOL)isGray imgSizescale:(CGFloat)scale;
@end
