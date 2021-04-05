//
//  BCScheduleSettingsVC.m
//  BatteryCam
//
//  Created by yf on 2018/4/16.
//  Copyright © 2018年 oceanwing. All rights reserved.
//

//#import "BCScheduleSettingsVC.h"
//#import "comm_protocol_define.h"
//#import "BCComCtrlManager.h"
//#import "BCStrokeHLBtn.h"
//#import "BCTimePickerCellT.h"
//#import "BCScheduleSettingCell.h"
//#import "BCLoadingBtn.h"
//
//static NSString *pickercelliden1=@"pickercelliden1";
//static NSString *pickercelliden2=@"pickercelliden2";
//
//@interface BCScheduleSettingsVC ()
//{
//    BCSceneScheduleMod *_mod;
//    BCSceneScheduleMod *originMod;
//    NSMutableArray<UIButton *> *btns;
//    BOOL timeselect[2];
//}
//@property (nonatomic,strong)BCLoadingBtn *deleteBtn;
//@property (nonatomic,strong)BCLoadingBtn *saveBtn;
//@property (nonatomic,strong)UITableViewCell *repeatCell;
//@end
//
//@implementation BCScheduleSettingsVC
//
//- (void)viewDidLoad {
//    self.pname=@"BCSceneScheduleSetting.plist";
//    self.cellClz=BCScheduleSettingCell.class;
//    [super viewDidLoad];
//    [self initUI];
//    [self updateData];
//}
//
//-(void)updateData{
//    dispatch_async(dispatch_get_main_queue(), ^{
////        UIImage *selSceneImg=img(@"circle_selected_con");
////        UIImage *defSceneImg=img(@"circle_default_con");
////        [self modByIdxpath:[NSIndexPath indexPathForRow:0 inSection:0]].img=self.mod.sceneType==SceneHome?selSceneImg:defSceneImg;
////        [self modByIdxpath:[NSIndexPath indexPathForRow:1 inSection:0]].img=self.mod.sceneType==SceneHome?defSceneImg:selSceneImg;
//        [self modByIdxpath:[NSIndexPath indexPathForRow:0 inSection:1]].on=self.mod.repeat;
//        [self modByIdxpath:[NSIndexPath indexPathForRow:0 inSection:0]].detail=self.mod.startTimeDesc;
//        [self modByIdxpath:[NSIndexPath indexPathForRow:2 inSection:0]].detail=self.mod.overTimeDesc;
//
//        [self->btns enumerateObjectsUsingBlock:^(UIButton *  obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            obj.selected = self.mod->custDay[idx];
//        }];
//        [self.tv reloadData];
//        [self validation];
//
//    });
//}
//
//#pragma mark - actions
//-(BOOL)validation{
////    BOOL b = [self.mod isValidData];
////    self.saveBtn.enabled=b;
////    return b;
//    self.saveBtn.enabled=YES;
//    return YES;
//}
//-(void)homeSelect{
//    self.mod.sceneType=SceneHome;
//    [self updateData];
//}
//-(void)awaySelect{
//    self.mod.sceneType=SceneAway;
//    [self updateData];
//}
//-(void)RepeatClick{
//    self.mod.repeat=!self.mod.repeat;
//    [self modByIdxpath:[NSIndexPath indexPathForRow:0 inSection:1]].on=self.mod.repeat;
//    [self.tv reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:0];
//    [btns enumerateObjectsUsingBlock:^(UIButton *  obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        obj.selected = self.mod->custDay[idx];
//    }];
//    [self validation];
//}
//
//-(void)save{
//    if(![self validation]){
//        [iPop toastWarn:NSLocalizedString(@"In onece mode, the end time needs to be later than the current time",0)];
//        return;
//    }
//    if(originMod){
//        [self.vm rm:originMod];
//    }
//    if(![self.vm canAdd:self.mod]){
//        [self.vm add:originMod];
//        return;
//    }
//    
//    [self.mod validize];
//    [self.vm add:self.mod];
//    
//    @weakRef(self)
//    [self.saveBtn startLoding];
//     [self.vm  save:^(BOOL suc) {
//         [self.saveBtn stopLoading];
//         if(suc){
//             self.mod.newUpdated=YES;
//             [UIViewController popVC];
//         }else{
//             [weak_self.vm rm:weak_self.mod];
//             if(self->originMod){
//                 [weak_self.vm add:self->originMod];
//             }
//         }
//     }];
//}
//-(void)delete{
//    [self.vm rm:originMod];
//    @weakRef(self)
//    [self.deleteBtn startLoding];
//    [self.vm save:^(BOOL suc) {
//        [self.deleteBtn stopLoading];
//        if(suc)
//            [UIViewController popVC];
//        else
//            [weak_self.vm add:self->originMod];
//    }];
//}
//
//-(void)onBtnsClicked:(UIButton *)btn{
//    NSInteger idx = btn.tag;
//    [self.mod setCustDayAt:idx];
//    [self updateData];
//}
//
//-(void)chooseTime:(NSIndexPath *)idx{
//    if(idx.row==0){
//        timeselect[0]=!timeselect[0];
//        timeselect[1]=NO;
//        [self modByIdxpath:[NSIndexPath indexPathForRow:0 inSection:0]].hasDetail=!timeselect[0];
//        [self modByIdxpath:[NSIndexPath indexPathForRow:2 inSection:0]].hasDetail=YES;
//    }else if(idx.row==2){
//        timeselect[1]=!timeselect[1];
//        timeselect[0]=NO;
//        [self modByIdxpath:[NSIndexPath indexPathForRow:2 inSection:0]].hasDetail=!timeselect[1];
//        [self modByIdxpath:[NSIndexPath indexPathForRow:0 inSection:0]].hasDetail=YES;
//    }
//    [self.tv reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:0];
//}
//
//
//#pragma mark - getter & setting
//-(BCSceneScheduleMod *)mod{
//    if(!_mod){
//        _mod=[[BCSceneScheduleMod alloc]init];
//        _mod.on=YES;
//    }
//    return _mod;
//}
//-(void)setMod:(BCSceneScheduleMod *)mod{
//    originMod=mod;
//    _mod=mod.clone;
//}
//-(void)setFromHour:(NSInteger)fromHour{
//    _fromHour=fromHour;
//    NSInteger era,year,month,day;
//    NSCalendar *calendar=[NSCalendar currentCalendar];
//    [calendar getEra:&era year:&year month:&month day:&day fromDate:self.mod.fromTime];
//    NSDate *begindate = [calendar dateWithEra:era year:year month:month day:day hour:_fromHour minute:0 second:0 nanosecond:0];
//    self.mod.fromTime=begindate;
//    NSInteger tohour = _fromHour+2>=24?_fromHour+1:_fromHour+2;
//    self.mod.toTime=[calendar dateWithEra:era year:year month:month day:day hour:tohour minute:tohour==23?59:0 second:0 nanosecond:0];
//}
//-(void)setDayOfWeek:(NSInteger)dayOfWeek{
//    _dayOfWeek=dayOfWeek;
//    [self.mod selectDayOfWeek:dayOfWeek];
//}
//
//#pragma mark - UITableviewDelegate
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if(indexPath.section==0){
//        NSInteger row = indexPath.row;
//        if(row==1||row==3){
//            return timeselect[(int)(row*.5)]?dp2po(192):0;
//        }
//    }
//    return tableView.rowHeight;
//}
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
//    if(section==1)return self.mod.repeat?2:1;
//    return [super tableView:tableView numberOfRowsInSection:section];
//}
//
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    if(indexPath.section==0 && (indexPath.row==1||indexPath.row==3)){
//        BCTimePickerCellT *cell=nil;
//        if(indexPath.row==1)
//            cell=[tableView dequeueReusableCellWithIdentifier:pickercelliden1];
//        else
//            cell=[tableView dequeueReusableCellWithIdentifier:pickercelliden2];
//        @weakRef(self)
//        cell.cb = ^(NSDate *date) {
//            NSLog(@"-------------%@_--------------------",date);
//            if(indexPath.row==1){
//                [weak_self.mod validSetFromTime:date];
//            }else{
//                [weak_self.mod validSetToTime:date];
//            }
//            [weak_self  updateData];
//        };
//        
//        cell.timeMode=YES;
//        cell.date=indexPath.row==1?self.mod.fromTime:self.mod.toTime;
//        if(indexPath.row==1){
//            cell.datePicker.maximumDate=self.mod.maxiumStartTime;
//            cell.datePicker.minimumDate=nil;
//        }else{
//            cell.datePicker.maximumDate=nil;
//            cell.datePicker.minimumDate=self.mod.miniumToTime;
//        }
//        return cell;
//    }else if(indexPath.section==1&&indexPath.row==1){
//        return self.repeatCell;
//    }
//    return [super tableView:tableView cellForRowAtIndexPath:indexPath];;
//}
//
//
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    if([self titleBy:section]){
//        return dp2po(36);
//    }
//    return CGFLOAT_MIN;
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return dp2po(10);
//}
//
//
//#pragma mark - UI
//-(void)initUI{
//    if(originMod){
//        self.title=NSLocalizedString(@"Schedule",0);
//    }else{
//        self.title=NSLocalizedString(@"Schedule",0);
//    }
//
//    self.tv.bounces=YES;
//    self.tv.rowHeight=dp2po(46);
//    if(!originMod)
//        self.tv.tableHeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 12)];
//    self.tv.tableFooterView=self.footerView;
//    [self.tv registerClass:BCTimePickerCellT.class forCellReuseIdentifier:pickercelliden1];
//    [self.tv registerClass:BCTimePickerCellT.class forCellReuseIdentifier:pickercelliden2];
//    
//   
//}
//
//
//-(UITableViewCell *)repeatCell{
//    if(!_repeatCell){
//        _repeatCell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
//        NSCalendar *can=[NSCalendar currentCalendar];
//        _repeatCell.selectionStyle=0;
//        NSArray * sary = [can shortWeekdaySymbols];
//        if(sary.count<7)
//            sary=@[@"S",@"M",@"T",@"W",@"T",@"F",@"S"];
//        CGFloat bh=27,bw=dp2po(42);
//        btns=[NSMutableArray array];
//        for(int i=0;i<7;i++){
//            BCStrokeHLBtn *btn = [BCStrokeHLBtn commonStrokeBtnWith:bh title:sary[i] tcolor:iColor(0x88, 0x88, 0x88, .6) font:iFont(15) tar:self action:@selector(onBtnsClicked:)];
//            btn.selecMod=YES;
//            btn.tag=i;
//            [btns  addObject:btn];
//        }
//        
//        layoutViewWithSize(_repeatCell.contentView, btns, 7, YES, CGSizeMake(bw, bh));
//    }
//    return _repeatCell;
//}
//
//-(UIView *)headerView{
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, iScreenW, 65)];
//    UILabel *lab = [IProUtil commonLab:iFont(16) color:iColor(0x66, 0x66, 0x66, 1)];
//    lab.numberOfLines=0;
//    lab.textAlignment=NSTextAlignmentCenter;
//    NSString *str = iFormatStr(@"You can create a schedule by\n \"%@\" mode." ,sceneDesc(SceneAway));
//    NSMutableAttributedString *astr = [[NSMutableAttributedString alloc]initWithString:str];
//    [astr addAttributes:@{NSFontAttributeName:iBFont(16),NSForegroundColorAttributeName:[UIColor blackColor]} range:NSMakeRange([str rangeOfString:@"\""].location+1, sceneDesc(SceneAway).length)];
//    
//    lab.attributedText=astr;
//    [view addSubview:lab];
//    
//    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(@0);
//    }];
//    return view;
//}
//
//-(UIView *)footerView{
//    
//    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, iScreenW, dp2po(180))];
//    
//    self.saveBtn= [BCLoadingBtn btnWith:NSLocalizedString(@"Save",0) tar:self action:@selector(save)];
//    [view addSubview:self.saveBtn];
//    if(originMod){
//        self.deleteBtn=[BCLoadingBtn btnWith:NSLocalizedString(@"Delete",0) tar:self action:@selector(delete)];
//        [self.deleteBtn setTitleColor:[UIColor redColor] forState:0];
//        self.deleteBtn.spinnerColor=iGlobalFocusColor;
//        [UIUtil commonStrokeBtn:self.deleteBtn tar:self action:@selector(delete) shadowOpacity:.1 H:10 strokeColor:iColor(0xb2, 0xb2, 0xb2, 1) strokeHLColor:iCommonSeparatorColor strokeDisColor:iCommonSeparatorColor bgcolor:[UIColor whiteColor] corRad:5];
//        [view addSubview:self.deleteBtn];
//        [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo(@(-dp2po(20)));
//            make.width.equalTo(@(iScreenW-dp2po(40)));
//            make.height.equalTo(@(dp2po(44)));
//            make.centerX.equalTo(@0);
//        }];
//        [self.saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo(self.deleteBtn.mas_top).offset(-20);
//            make.width.height.centerX.equalTo(self.deleteBtn);
//        }];
//    }else{
//        [self.saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(@(dp2po(50)));
//            make.width.equalTo(@(iScreenW-dp2po(40)));
//            make.height.equalTo(@(dp2po(44)));
//            make.centerX.equalTo(@0);
//        }];
//    }
//    return view;
//}
//
//@end
