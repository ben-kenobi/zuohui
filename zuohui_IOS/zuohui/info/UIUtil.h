//
//  UIUtil.h
//  BatteryCam
//
//  Created by yf on 2017/9/13.
//  Copyright © 2017年 oceanwing. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MJRefreshBackNormalFooter,MJRefreshNormalHeader;
@interface BCSlider:UISlider
@end

@interface UIUtil : NSObject
+(void)commonShadow:(UIView *)view opacity:(CGFloat)opacity;
+(void)commonShadowWithRadius:(NSInteger)rad view:(UIView *)view opacity:(CGFloat)opacity;
+(void)commonShadowWithRadius:(NSInteger)rad size:(CGSize)size view:(UIView *)view opacity:(CGFloat)opacity;
+(UISlider *)commonSlider:(UIImage *)maxiumTrackImg;
+(MJRefreshNormalHeader *)commonMJHeaderWithTar:(id)tar action:(SEL)sel;
+(MJRefreshBackNormalFooter *)commonMJFooterWithTar:(id)tar action:(SEL)sel;
+(CAShapeLayer *)dashLayer:(CGFloat)wid;
+(UIView *)dashView:(CGFloat)wid;
+(CAShapeLayer *)dashCompactLayer:(CGFloat)wid;
+(void)showProgAt:(UIView *)view;
+(void)dismissProg;
+(void)commonTransiWith:(UIView *)view blo:(void(^)())blo;
+(void)commonNav:(UIViewController *)vc shadow:(BOOL)shadow line:(BOOL)line translucent:(BOOL)translucent;
+(void)commonNav:(UIViewController *)vc shadow:(BOOL)shadow line:(BOOL)line translucent:(BOOL)translucent color:(UIColor *)bartintcolor;
@end
