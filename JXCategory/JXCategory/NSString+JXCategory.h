//
//  NSString+BJYCategory.h
//  CloudWork
//
//  Created by BaiJiaYun on 2019/4/30.
//  Copyright © 2019 BaiJiaYun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface NSString (JXCategory)


/**
 计算一段文字的size

 @param maxSize 最大size
 @param font 文字的font
 @return 文字的size
 */
- (CGSize)calculateContentSizeWithMaxSize:(CGSize)maxSize font:(UIFont *)font;

/// 计算文字高度，可以处理计算带行间距的等属性
- (CGSize)boundingRectWithSize:(CGSize)size paragraphStyle:(NSMutableParagraphStyle *)paragraphStyle font:(UIFont*)font;
/**
 * 计算文字高度，可以处理计算带行间距的
 */
- (CGSize)boundingRectWithSize:(CGSize)size font:(UIFont*)font  lineSpacing:(CGFloat)lineSpacing;
/**
 * 计算最大行数文字高度，可以处理计算带行间距的
 */
- (CGFloat)boundingRectWithSize:(CGSize)size font:(UIFont*)font  lineSpacing:(CGFloat)lineSpacing maxLines:(NSInteger)maxLines;

/**
 *  计算是否超过一行
 */
- (BOOL)isMoreThanOneLineWithSize:(CGSize)size font:(UIFont *)font lineSpaceing:(CGFloat)lineSpacing;
//计算高度
+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize;
//普通lab的宽高
+ (CGSize )sizeForLabelText:(NSString *)text font:(UIFont *)font;
/**
 时间戳转时间模板
 
 @param timestamp 时间戳
 @param format 时间模板
 @return 转好的时间
 */
+ (NSString *)timeStampToTimeStr:(NSString *)timestamp format:(NSString *)format;

/**
 时间字符串转时间模板
 
 @param timeString 时间字符串
 @param format 时间模板
 @return 转好的时间
 */
+ (NSDate *)timeStringFormatDateWithString:(NSString *)timeString format:(NSString *)format;

/**
 获取格式化后的时间字符串
 
 @param date 时间
 @param format 时间样式
 @return 格式化后的时间字符串
 */
+ (NSString *)stringWithDate:(NSDate *)date format:(NSString *)format;

//获取当前时间戳
+(NSString *)currentTimeStr;

//去除字符串空格
+(NSString *)textQuKongGe:(NSString *)str;

// 计算两个时间的差值
+ (NSDateComponents *)dateTimeDifferenceWithStartTime:(NSString *)startTime endTime:(NSString *)endTime;

@end

NS_ASSUME_NONNULL_END
