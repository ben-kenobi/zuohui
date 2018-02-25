
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
    
    // 标的当月，标者不交钱，拿其他人当月交的钱总合加会头给一份活钱为标者总所得
     // 最开始所有人交一份base到会头， 这份钱会头拿走，会头每月交一份活钱给标者
    // 总共标totalCount次会，所有人交totalCount次钱，开始前交一次给会头，每次标会交一次，并且自己标的那次不交钱
    self.totalIncome=(self.vm->base-realbidprice)*(leftNum+1)+self.vm->base*(curNum-1);// leftNum+1为剩余未标人数加会头给的一次活钱
    
    self.totalOutcome=self.vm->base * (leftNum+1) + self.formerOutcome;//leftNum+1为剩余未标人数加开始前交一次base
    
    self.yearInteresteRate=(self.totalIncome-self.totalOutcome)*12.0*self.vm->timesPerMonth/self.vm->totalCount/self.totalOutcome*2.0;
    
    //剩余年数
    CGFloat leftYear = leftNum/(12.0*self.vm->timesPerMonth);
    self.finalTotalIncome=self.totalIncome*(1+self.vm->afterBidYearRate*leftYear);
     self.finalInteresteRate=(self.finalTotalIncome-self.totalOutcome)*12.0*self.vm->timesPerMonth/self.vm->totalCount/self.totalOutcome*2.0;
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
