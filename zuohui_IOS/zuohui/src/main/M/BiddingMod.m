
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
    self.totalIncome=(self.vm->base-realbidprice)*(leftNum+1)+self.vm->base*(curNum-1);
    self.totalOutcome=self.vm->base * leftNum + self.formerOutcome;
    self.yearInteresteRate=(self.totalIncome-self.totalOutcome)*12.0*self.vm->timesPerMonth/self.vm->totalCount/self.totalOutcome*2.0;
}
//已经支出的数额
-(NSInteger)formerOutcome{
    //当前名额
    NSInteger curNum = self.idx+1;
    
    NSInteger sum = 0;
    for(int i=0;i<curNum;i++){
        NSInteger bidprice = [self.vm.bidRecordDict objectForKey:iFormatStr(@"%d",i)].integerValue;
        bidprice=bidprice?bidprice:self.minBid;
        sum+=self.vm->base-bidprice;
    }
    return sum;
}
@end
