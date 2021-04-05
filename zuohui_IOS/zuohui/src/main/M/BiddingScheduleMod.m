
//
//  BiddingScheduleMod.m
//  zuohui
//
//  Created by yf on 2018/8/20.
//  Copyright © 2018年 oceanwing. All rights reserved.
//

#import "BiddingScheduleMod.h"
static NSString *bidScheduleKey=@"bidScheduleKey";
@interface BiddingScheduleMod()
@property (nonatomic,strong)NSMutableArray *scheduleOneSettingMerge;
@property (nonatomic,strong)NSMutableArray *defSettingMerge;

@end
@implementation BiddingScheduleMod

+(instancetype)savedScheduleMod{
    NSDictionary *dict =[iPref(0) dictionaryForKey:bidScheduleKey];
    if(dict){
        BiddingScheduleMod *mod = [BiddingScheduleMod setDict:dict];
        return mod;
    }
    if(YES){
        BiddingScheduleMod *mod = [[BiddingScheduleMod alloc]init];
        mod.fromTime=[NSDate dateFromStr:@"2018-1-1"];
        mod.scheduleOneCount=12;
        mod.scheduleOneSetting=@[@[@"5"],@[@"5",@"20"]];
        mod.defSetting=@[@[@"5",@"20"],@[@"5",@"20"]];
        return mod;
    }
    return nil;
}

-(void)setScheduleOneSetting:(NSArray<NSArray<NSString *> *> *)scheduleOneSetting{
    _scheduleOneSetting=scheduleOneSetting;
    self.scheduleOneSettingMerge=[NSMutableArray array];
    [self.scheduleOneSettingMerge addObjectsFromArray:_scheduleOneSetting.firstObject];
    [self.scheduleOneSettingMerge addObjectsFromArray:_scheduleOneSetting.lastObject];

}

-(NSInteger)scheduleOneSettingCount{
    return self.scheduleOneSettingMerge.count;
}

-(NSString *)scheduleOneSettingByIdx:(NSInteger)idx{
    return self.scheduleOneSettingMerge[idx];
}


-(void)setDefSetting:(NSArray<NSArray<NSString *> *> *)defSetting{
    _defSetting=defSetting;
    self.defSettingMerge=[NSMutableArray array];
    [self.defSettingMerge addObjectsFromArray:defSetting.firstObject];
    [self.defSettingMerge addObjectsFromArray:defSetting.lastObject];
}
-(NSInteger)defSettingCount{
    return self.defSettingMerge.count;
}
-(NSString *)defSettingByIdx:(NSInteger)idx{
    return self.defSettingMerge[idx];
}




#pragma mark - actions
//根据标会的次数得出该次的时间,次数下标从1开始
-(NSString *)descBy:(NSInteger)idx{
    
    //判断该次数是否在计划1之内
    NSInteger scheduleOneMax=self.scheduleOneSettingCount*self.scheduleOneCount;
    BOOL withinCount = scheduleOneMax>=idx;
    
    //计算该次数是第几个月，在那个月的哪一天
    NSInteger monthToAdd = 0;
    NSString *dayStr = @"";
    
    if(withinCount){
        NSInteger i1=(int)(idx/self.scheduleOneSettingCount)*2;
        NSInteger i2 =idx%self.scheduleOneSettingCount;
        monthToAdd=i1-1;//因为第一个月就是在开始的当月，所以需要减去1
        NSArray *first = self.scheduleOneSetting.firstObject;
        if(i2>first.count){
            monthToAdd+=2;
        }else if(i2<=first.count && i2>0){
            monthToAdd+=1;
        }
        
        //当次数刚好是一个周期，则为周期最后一次配置
        dayStr=[self scheduleOneSettingByIdx:i2>0?i2-1:self.scheduleOneSettingCount-1];
        
    }else{
        monthToAdd = self.scheduleOneCount *2;
        idx-=scheduleOneMax;
        
        NSInteger i1=(int)(idx/self.defSettingCount)*2;
        NSInteger i2 =idx%self.defSettingCount;
        
        monthToAdd += i1-1;//因为第一个月就是在开始的当月，所以需要减去1
        NSArray *first = self.defSetting.firstObject;
        if(i2>first.count){
            monthToAdd+=2;
        }else if(i2<=first.count && i2>0){
            monthToAdd+=1;
        }
        
        //当次数刚好是一个周期，则为周期最后一次配置
        dayStr=[self defSettingByIdx:i2>0?i2-1:self.defSettingCount-1];
    }
    
    NSDate *date =  [[NSCalendar currentCalendar] dateByAddingUnit:(NSCalendarUnitMonth) value:monthToAdd toDate:self.fromTime options:0];
    
    NSDateFormatter *df =[[NSDateFormatter alloc] init];
    df.dateFormat=@"yyyy 年\nMM月";
    return iFormatStr(@"%@%@日" ,[df stringFromDate:date],dayStr);
    
}
@end
