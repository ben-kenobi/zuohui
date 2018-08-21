
//
//  ZHSettingVC.m
//  zuohui
//
//  Created by yf on 2018/2/23.
//  Copyright © 2018年 oceanwing. All rights reserved.
//

#import "ZHSettingVC.h"
#import "YFClearableTF.h"
#import "ZHUtil.h"
@interface ZHSettingVC ()
@property (nonatomic,strong)UITextField *totalNumTf;
@property (nonatomic,strong)UITextField *baseTf;
@property (nonatomic,strong)UITextField *minBidTf;
@property (nonatomic,strong)UITextField *timesPerMonthTf;
@property (nonatomic,strong)UITextField *afterYearRate;
@end

@implementation ZHSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self updateUI];
}

-(void)updateUI{
    self.totalNumTf.text=iFormatStr(@"%ld", ZHUtil.totalNum);
    self.baseTf.text=iFormatStr(@"%ld",ZHUtil.base);
    self.minBidTf.text=iFormatStr(@"%ld",ZHUtil.minBid);
    self.timesPerMonthTf.text=iFormatStr(@"%.1f",ZHUtil.timesPerMonth);
    self.afterYearRate.text=iFormatStr(@"%.2f%%",ZHUtil.afterBidYearRate);
}
#pragma mark - actions
-(void)save{
    [ZHUtil setTotalNum: self.totalNumTf.text.integerValue];
    [ZHUtil setBase: self.baseTf.text.integerValue];
    [ZHUtil setMinBid: self.minBidTf.text.integerValue];
    [ZHUtil setTimesPerMonth: self.timesPerMonthTf.text.floatValue];
    [ZHUtil setAfterBidYearRate: self.afterYearRate.text.floatValue];
    [iNotiCenter postNotificationName:ON_BIDDING_SETTING_CHANGE object:nil];
    [UIViewController popVC];
}
-(void)toCustTime:(id)sender{
    
}


#pragma mark - UI
-(void)initUI{
    self.title=iStr(@"设置");
    self.view.backgroundColor=iGlobalBG;
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:iStr(@"保存") style:UIBarButtonItemStylePlain target:self action:@selector(save)];
    
    UIView *totalBg,*baseBg,*minBidBg,*timesPerMonthBg,*afterYearRateBg;
    
    self.totalNumTf=[self tfWith:iStr(@"总共名额:") bg:&totalBg];
    self.baseTf=[self tfWith:iStr(@"每月金额:") bg:&baseBg];
    self.minBidTf=[self tfWith:iStr(@"期望标额:") bg:&minBidBg];
    self.timesPerMonthTf=[self tfWith:iStr(@"月标次数:") bg:&timesPerMonthBg];
    self.afterYearRate=[self tfWith:iStr(@"预期年利:") bg:&afterYearRateBg];
    self.timesPerMonthTf.rightViewMode=UITextFieldViewModeAlways;
    UIButton *btn = [IProUtil commonTextBtn:iFont(dp2po(16)) color:iGlobalFocusColor title:iStr(@"自定义")];
    btn.contentEdgeInsets=UIEdgeInsetsMake(8, 8, 8, 8);
    [btn sizeToFit];
    self.timesPerMonthTf.rightView=btn;
    [btn addTarget:self action:@selector(toCustTime:) forControlEvents:UIControlEventTouchUpInside];
    
    // layout -----
    [self.view addSubview:totalBg];
    [self.view addSubview:baseBg];
    [self.view addSubview:minBidBg];
    [self.view addSubview:timesPerMonthBg];
    [self.view addSubview:afterYearRateBg];

    CGFloat gap = 15,h=50;
    [totalBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(h));
        make.centerX.equalTo(@0);
        make.width.equalTo(@(dp2po(280)));
        make.bottom.equalTo(self.view.mas_top).offset((gap+h)*1);
    }];
    
    [baseBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.centerX.width.equalTo(totalBg);
        make.bottom.equalTo(self.view.mas_top).offset((gap+h)*2);
    }];
    [minBidBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.centerX.width.equalTo(totalBg);
        make.bottom.equalTo(self.view.mas_top).offset((gap+h)*3);
    }];
    [timesPerMonthBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.centerX.width.equalTo(totalBg);
        make.bottom.equalTo(self.view.mas_top).offset((gap+h)*4);
    }];
    [afterYearRateBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.centerX.width.equalTo(totalBg);
        make.bottom.equalTo(self.view.mas_top).offset((gap+h)*5);
    }];
}

-(UITextField *)tfWith:(NSString *)title bg:(UIView **)bgRef{
    UIView *bg = [[UIView alloc]init];
    UILabel *titleLab = [IProUtil commonLab:iBFont(18) color:[UIColor darkGrayColor]];
    titleLab.text=title;
    
    UITextField *tf = [[YFClearableTF alloc]init];
    tf.keyboardType=UIKeyboardTypeDecimalPad;

    // layout ------
    [bg addSubview:titleLab];
    [bg addSubview:tf];
    
    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.centerY.equalTo(@0);
    }];
    [tf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(titleLab.mas_trailing);
        make.top.bottom.trailing.equalTo(@0);
    }];
    *bgRef=bg;
    return tf;
}

@end
