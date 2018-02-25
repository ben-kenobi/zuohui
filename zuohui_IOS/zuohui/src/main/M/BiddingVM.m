
//
//  BiddingVM.m
//  zuohui
//
//  Created by yf on 2018/2/22.
//  Copyright © 2018年 oceanwing. All rights reserved.
//

#import "BiddingVM.h"
#import "BiddingMod.h"

static NSString *bidRecordKey=@"bidRecordKey";
@interface BiddingVM()

@end

@implementation BiddingVM
+(instancetype)vmWith:(NSInteger)base total:(NSInteger)total min:(NSInteger)min times:(CGFloat)times afterBidYearRate:(CGFloat)afterBidYearRate;{
    BiddingVM *vm = [[BiddingVM alloc]init];
    vm->base=base;
    vm->minBid=min;
    vm->totalCount=total;
    vm->timesPerMonth=times;
    vm->afterBidYearRate=afterBidYearRate;
    vm.bidRecordDict=[NSMutableDictionary dictionaryWithDictionary:[iPref(0) dictionaryForKey:bidRecordKey]];
    return vm;
}

-(NSInteger)row{
    return totalCount;
}
-(BiddingMod *)modBy:(NSIndexPath *)idxpath{
    NSInteger row = idxpath.row;
    BiddingMod *mod = [[BiddingMod alloc]init];
    mod.idx=row;
    mod.vm=self;
    return mod;
}
-(void)updateBidPrice:(BiddingMod *)mod{
    if(mod.bidPrice<=0){
        [self.bidRecordDict removeObjectForKey:iFormatStr(@"%ld",mod.idx)];
    }else
        [self.bidRecordDict setObject:@(mod.bidPrice) forKey:iFormatStr(@"%ld",mod.idx)];
    [self save];
    [iNotiCenter postNotificationName:ON_BIDDING_CHANGE_NOTI object:nil];
}
-(void)save{
    [iPref(0) setObject:self.bidRecordDict forKey:bidRecordKey];
    [iPref(0) synchronize];
}
-(void)clearData{
    [self.bidRecordDict removeAllObjects];
    [self save];
    [iNotiCenter postNotificationName:ON_BIDDING_CHANGE_NOTI object:nil];
}
-(BOOL)hasBidRecord{
    return self.bidRecordDict.count;
}
@end
