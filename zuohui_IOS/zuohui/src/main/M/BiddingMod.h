//
//  BiddingMod.h
//  zuohui
//
//  Created by yf on 2018/2/22.
//  Copyright © 2018年 oceanwing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BiddingVM.h"
@interface BiddingMod : NSObject
@property (nonatomic,assign)NSInteger idx;
@property (nonatomic,assign)NSInteger bidPrice;
@property (nonatomic,assign)NSInteger totalOutcome;
@property (nonatomic,assign)NSInteger totalIncome;
@property (nonatomic,assign)NSInteger minBid;
@property (nonatomic,assign)CGFloat yearInteresteRate;


@property (nonatomic,assign)CGFloat finalInteresteRate;//计算标出后预期年利率的最后收益率
@property (nonatomic,assign)NSInteger finalTotalIncome;//计算标出后预期年利率的最后总得
@property (nonatomic,weak)BiddingVM *vm;
-(void)updateBidPrice:(NSInteger)bidPrice;
-(void)cal;
@end
