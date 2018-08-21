//
//  BiddingScheduleMod.h
//  zuohui
//
//  Created by yf on 2018/8/20.
//  Copyright © 2018年 oceanwing. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 标会的时间周期模型
 */
@interface BiddingScheduleMod : NSObject
@property (nonatomic,strong)NSDate *fromTime;// 开始时间
@property (nonatomic,assign)NSInteger scheduleOneCount;// 计划1生效次数,单位 周期（两月）
@property (nonatomic,strong)NSArray<NSArray<NSString *>*> *scheduleOneSetting;//计划1次数内的设置 (格式：两个数组，代表一个周期内两个月，数组那存放每月标的日期)
@property (nonatomic,strong)NSArray<NSArray<NSString *>*> *defSetting;//其他设置（不在计划1次数内的） (格式：两个数组，代表一个周期内两个月，数组那存放每月标的日期)


+(instancetype)savedScheduleMod;

-(NSString *)descBy:(NSInteger)count;//次数的具体描述
@end
