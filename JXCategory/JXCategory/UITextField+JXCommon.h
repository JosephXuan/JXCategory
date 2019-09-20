//
//  UITextField+Common.h
//  zijiban
//
//  Created by JackySong on 17/1/3.
//  Copyright © 2017年 JackySong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (JXCommon)

- (void)settextLeftWidth:(float)leftWidth;

/**
 *  加上一个长度(int)，就可以实现了字数限制,配合tools中的方法  可以支持汉字。汉字占2个长度
 *
 *
 */
- (void)limitTextLength:(int)length;
/**
 *  uitextField 抖动效果
 */
- (void)shake;

-(int)convertToInt:(NSString*)strtemp;
@end
