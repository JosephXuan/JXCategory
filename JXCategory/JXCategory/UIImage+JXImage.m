//
//  UIImage+JXImage.m
//  分类
//
//  Created by apple on 15-3-4.
//  Copyright (c) 2012年 itcast. All rights reserved.
//

#import "UIImage+JXImage.h"
#import <Accelerate/Accelerate.h>

@implementation UIImage (JXImage)

+ (instancetype)imageWithOriginalName:(NSString *)imageName
{
   UIImage *image = [UIImage imageNamed:imageName];
    
    return [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

+ (instancetype)imageWithStretchableName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}


+ (UIImage *)imageWithSize:(CGSize)size drawBlock:(void (^)(CGContextRef context))drawBlock {
    if (!drawBlock) return nil;
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (!context) return nil;
    drawBlock(context);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (instancetype)createWithColor:(UIColor *)color size:(CGSize)size {
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
-(UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
}



/*
 缩放图片，将图片缩放为指定尺寸大小
 */
- (UIImage*)imageWithOriginalImage:(UIImage*)originalImage scaledToSize:(CGSize)newSize
{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    
    [originalImage drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}


+ (UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur {
    if (blur < 0.f || blur > 1.f) {
        blur = 0.5f;
    }
    int boxSize = (int)(blur * 40);
    boxSize = boxSize - (boxSize % 2) + 1;
    
    CGImageRef img = image.CGImage;
    
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    
    void *pixelBuffer;
    //从CGImage中获取数据
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    //设置从CGImage获取对象的属性
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) *
                         CGImageGetHeight(img));
    
    if(pixelBuffer == NULL)
        NSLog(@"No pixelbuffer");
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(
                                             outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    CFRelease(inBitmapData);
    
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    
    return returnImage;
}
/**
 生成一张渐变色的图片
 @param colors 颜色数组
 @param rect 图片大小
 @return 返回渐变图片
 */
+ (UIImage *)gradientImageWithColors:(NSArray *)colors rect:(CGRect)rect
{
    if (!colors.count || CGRectEqualToRect(rect, CGRectZero)) {
        return nil;
    }
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    
    gradientLayer.frame = rect;
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    NSMutableArray *mutColors = [NSMutableArray arrayWithCapacity:colors.count];
    for (UIColor *color in colors) {
        [mutColors addObject:(__bridge id)color.CGColor];
    }
    gradientLayer.colors = [NSArray arrayWithArray:mutColors];
    
    UIGraphicsBeginImageContextWithOptions(gradientLayer.frame.size, gradientLayer.opaque, 0);
    [gradientLayer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return outputImage;
}

/**
 *  伪随机数
 */
static NSInteger ATNoiseRseed = 115;
static inline NSInteger ATNoiseRand() {
    return (ATNoiseRseed = (ATNoiseRseed * 214013 + 2531011) & ((1U << 31) - 1)) >> 16;
}
/**
 *  图片加入杂色, intensity: 0.0 ~ 1.0f, gary: YES标示单色噪点
 */
- (UIImage *)imageWithNoiseIntensity:(CGFloat)intensity gray:(BOOL)isGray imgSizescale:(CGFloat)scale
{
    UIImage *image;
    //self.scale=1.0f;
    
    int width = self.size.width * scale;
    int height = self.size.height * scale;
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    if (colorspace == NULL) {
        // ATLog(@"Create Colorspace Error!");
        return nil;
    }
    
    Byte *imgData = NULL;
    imgData = malloc(width * height * 4);
    if (imgData == NULL) {
        // ATLog(@"Memory Error!");
        CGColorSpaceRelease(colorspace);
        return nil;
    }
    
    CGContextRef bmpContext = CGBitmapContextCreate(imgData, width, height, 8, width * 4, colorspace, (CGBitmapInfo)kCGImageAlphaPremultipliedLast);
    if (!bmpContext) {
        // ATLog(@"Create Bitmap context Error!");
        CGColorSpaceRelease(colorspace);
        return nil;
    }
    
    CGContextDrawImage(bmpContext, CGRectMake(0, 0, width, height), self.CGImage);
    for (long i = 0; i < width * height; i++) {
        int randR = (ATNoiseRand()%511-255) * intensity;
        int randG = isGray ? randR : (ATNoiseRand()%511-255) * intensity;
        int randB = isGray ? randR : (ATNoiseRand()%511-255) * intensity;
        
        imgData[4*i+0] = MAX(0, MIN(255, (imgData[4*i+0] + randR)));
        imgData[4*i+1] = MAX(0, MIN(255, (imgData[4*i+1] + randG)));
        imgData[4*i+2] = MAX(0, MIN(255, (imgData[4*i+2] + randB)));
        imgData[4*i+3] = 255;
    }
    
    CGImageRef imageRef = CGBitmapContextCreateImage(bmpContext);
    if (imageRef != NULL) {
        image = [[UIImage alloc] initWithCGImage:imageRef];
        CGImageRelease(imageRef);
    }
    
    CGColorSpaceRelease(colorspace);
    CGContextRelease(bmpContext);
    free(imgData);
    
    return image;
    //https://www.jianshu.com/p/07ddd22a26fb
}

@end
