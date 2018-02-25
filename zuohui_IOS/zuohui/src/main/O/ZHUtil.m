
//
//  ZHUtil.m
//  zuohui
//
//  Created by yf on 2018/2/23.
//  Copyright © 2018年 oceanwing. All rights reserved.
//

#import "ZHUtil.h"

@implementation ZHUtil

//基础金额
+(void)setBase:(NSInteger)base{
    [iPref(0) setInteger:base forKey:@"baseKey"];
    [iPref(0) synchronize];
}
+(NSInteger)base{
    return [iPref(0) integerForKey:@"baseKey"];
}

//总人数，不包括会头，会头不参与标会
+(void)setTotalNum:(NSInteger)totalNum{
    [iPref(0) setInteger:totalNum forKey:@"totalNumKey"];
    [iPref(0) synchronize];
}
+(NSInteger)totalNum{
    return [iPref(0) integerForKey:@"totalNumKey"];
}

//最低竞标金额
+(void)setMinBid:(NSInteger)minBid{
    [iPref(0) setInteger:minBid forKey:@"minBidKey"];
    [iPref(0) synchronize];
}
+(NSInteger)minBid{
    return [iPref(0) integerForKey:@"minBidKey"];
}

//每月竞标次数
+(void)setTimesPerMonth:(CGFloat)timesPerMonth{
    [iPref(0) setFloat:timesPerMonth forKey:@"timesPerMonthKey"];
    [iPref(0) synchronize];
}
+(CGFloat)timesPerMonth{
    return [iPref(0) floatForKey:@"timesPerMonthKey"];
}

//标出后的资金预期年利率
+(void)setAfterBidYearRate:(CGFloat)afterBidYearRate{
    [iPref(0) setFloat:afterBidYearRate forKey:@"afterBidYearRateKey"];
    [iPref(0) synchronize];
}
+(CGFloat)afterBidYearRate{
    return [iPref(0) floatForKey:@"afterBidYearRateKey"];
}

@end
