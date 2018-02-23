//
//  ZHCell.m
//  zuohui
//
//  Created by yf on 2018/2/22.
//  Copyright © 2018年 oceanwing. All rights reserved.
//

#import "ZHCell.h"
#import "YFClearableTF.h"
@interface ZHCell()
@property (nonatomic,strong)UILabel *idxLab;
@property (nonatomic,strong)YFClearableTF *biddingTf;
@property (nonatomic,strong)UILabel *summary;
@end

@implementation ZHCell
-(void)setMod:(BiddingMod *)mod{
    _mod=mod;
    [self updateUI];
}
-(void)updateUI{
    self.backgroundColor=(_mod.idx%2)?[UIColor whiteColor]:iColor(0xff, 0xfa, 0xf0, 1);
    self.idxLab.text=iFormatStr(@"%ld",self.mod.idx+1);
    self.biddingTf.text=_mod.bidPrice>0?iFormatStr(@"%ld",self.mod.bidPrice):@"";
    self.biddingTf.placeholder=iFormatStr(@"%ld",self.mod.minBid);
    
    NSString *totalOutcome = iFormatStr(@"%ld",_mod.totalOutcome);
    NSString *totalIncome = iFormatStr(@"%ld",_mod.totalIncome);
    NSString *yearRate = iFormatStr(@"%.3f%%",_mod.yearInteresteRate*100+.00049);
    NSString *sumStr = iFormatStr(@"总支出：%@\n总收入：%@\n年利率：%@",totalOutcome,totalIncome,yearRate);
    NSMutableAttributedString *astr = [[NSMutableAttributedString alloc]initWithString: sumStr];
    [astr addAttribute:NSForegroundColorAttributeName value:iColor(0xee, 0x88, 0x88, 1) range:NSMakeRange([sumStr rangeOfString:@"总支出："].location+4, totalOutcome.length)];
    [astr addAttribute:NSForegroundColorAttributeName value:iColor(0x88, 0xee, 0x88, 1) range:NSMakeRange([sumStr rangeOfString:@"总收入："].location+4, totalIncome.length)];
    [astr addAttribute:NSForegroundColorAttributeName value:iColor(0x88, 0x88, 0xee, 1) range:NSMakeRange([sumStr rangeOfString:@"年利率："].location+4, yearRate.length)];
    self.summary.attributedText=astr;

}

-(void)cal{
    [_mod cal];
    [self updateUI];
}


#pragma mark - UI

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initUI];
        [iNotiCenter addObserver:self selector:@selector(cal) name:ON_BIDDING_CHANGE_NOTI object:nil];

    }
    return self;
}
-(void)dealloc{
    [iNotiCenter removeObserver:self];
}

-(void)initUI{
    self.idxLab=[IProUtil commonLab:iBFont(18) color:[UIColor blackColor]];
    self.biddingTf=[[YFClearableTF alloc]init];
    self.summary=[IProUtil commonLab:iFont(dp2po(14)) color:[UIColor darkGrayColor]];
    self.summary.numberOfLines=0;
    self.selectionStyle=0;
    self.biddingTf.keyboardType=UIKeyboardTypeDecimalPad;
    @weakRef(self)
    [self.biddingTf setOnEditingChangeCB:^(YFClearableTF *tf) {
        if(!tf.isEditing)
            [weak_self.mod updateBidPrice:tf.text.integerValue];
    }];
    
    // layout --
    [self.contentView addSubview:self.idxLab];
    [self.contentView addSubview:self.biddingTf];
    [self.contentView addSubview:self.summary];

    [self.idxLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.leading.equalTo(@15);
    }];
    [self.biddingTf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(@0);
        make.leading.equalTo(@50);
        make.height.equalTo(@50);
        make.width.equalTo(@(dp2po(146)));
    }];
    [self.summary mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.biddingTf.mas_trailing).offset(15);
        make.centerY.equalTo(@0);
    }];
    
    
    
    
}

@end
