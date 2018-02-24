
//
//  BiddingMod.m
//  zuohui
//
//  Created by yf on 2018/2/22.
//  Copyright © 2018年 oceanwing. All rights reserved.
//

#import "BiddingMod.h"

@implementation BiddingMod
-(void)updateBidPrice:(NSInteger)bidPrice{
    _bidPrice=bidPrice;
    [self.vm updateBidPrice:self];
}

-(NSInteger)minBid{
    return self.vm->minBid;
}

-(void)setVm:(BiddingVM *)vm{
    _vm=vm;
    [self cal];
}
-(void)cal{
    if(!_vm)return;
    self.bidPrice=[self.vm.bidRecordDict objectForKey:iFormatStr(@"%ld",self.idx)].integerValue;
    
    //当前名额
    NSInteger curNum = self.idx+1;
    //剩余名额
    NSInteger leftNum=self.vm->totalCount-curNum;
   
    NSInteger realbidprice = self.bidPrice?self.bidPrice:self.vm->minBid;
    
    // 标的当月，标者不交钱，拿其他人当月交的钱总合为标者总所得
     // 最开始所有人交一份base到会头， 剩最后一位时，所有人不交钱，这份钱给最后一人
    // 所有人交totalCount-1次钱，最后一位交totalCount次钱，也多拿一份base钱
    self.totalIncome=(self.vm->base-realbidprice)*leftNum+self.vm->base*(curNum-1);
    
    self.totalOutcome=self.vm->base * leftNum + self.formerOutcome;
    
    // 特殊处理最后一位 ，最后一位没有标，所以多交一次base钱，也多拿一次base钱
    if(self.idx==self.vm->totalCount-1){
        self.totalIncome+=self.vm->base;
        self.totalOutcome+=self.vm->base;
    }
    
    self.yearInteresteRate=(self.totalIncome-self.totalOutcome)*12.0*self.vm->timesPerMonth/self.vm->totalCount/self.totalOutcome*2.0;
    
 
}
//已经支出的数额
-(NSInteger)formerOutcome{
    //当前名额
    NSInteger curNum = self.idx+1;
    
    NSInteger sum = 0;
    //自己标的当月不交钱，所以curNum-1处的标价忽略
    for(int i=0;i<curNum-1;i++){
        NSInteger bidprice = [self.vm.bidRecordDict objectForKey:iFormatStr(@"%d",i)].integerValue;
        bidprice=bidprice?bidprice:self.minBid;
        sum+=self.vm->base-bidprice;
    }
    return sum;
}
@end
