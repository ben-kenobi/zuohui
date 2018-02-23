//
//  BiddingVM.h
//  zuohui
//
//  Created by yf on 2018/2/22.
//  Copyright © 2018年 oceanwing. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BiddingMod;
@interface BiddingVM : NSObject
{@public
    NSInteger base,minBid,totalCount;
    CGFloat timesPerMonth;
    
}
@property (nonatomic,strong)NSMutableDictionary<NSString *,NSNumber *> *bidRecordDict;
+(instancetype)vmWith:(NSInteger)base total:(NSInteger)total min:(NSInteger)min times:(CGFloat)times;
-(NSInteger)row;
-(BiddingMod *)modBy:(NSIndexPath *)idxpath;
-(void)updateBidPrice:(BiddingMod *)mod;
-(void)clearData;
-(BOOL)hasBidRecord;
@end
