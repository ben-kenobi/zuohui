//
//  ZHUtil.h
//  zuohui
//
//  Created by yf on 2018/2/23.
//  Copyright © 2018年 oceanwing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZHUtil : NSObject

//基础金额
+(void)setBase:(NSInteger)base;
+(NSInteger)base;

//总人数
+(void)setTotalNum:(NSInteger)totalNum;
+(NSInteger)totalNum;

//最低竞标金额
+(void)setMinBid:(NSInteger)minBid;
+(NSInteger)minBid;

//每月竞标次数
+(void)setTimesPerMonth:(CGFloat)timesPerMonth;
+(CGFloat)timesPerMonth;
@end
