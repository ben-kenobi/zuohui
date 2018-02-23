

//
//  ZHMainVC.m
//  zuohui
//
//  Created by yf on 2018/2/22.
//  Copyright © 2018年 oceanwing. All rights reserved.
//

#import "ZHMainVC.h"
#import "BiddingVM.h"
#import "ZHCell.h"
#import "ZHUtil.h"
#import "ZHSettingVC.h"

static NSString *celliden = @"celliden";



@interface ZHMainVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tv;
@property (nonatomic,strong)BiddingVM *vm;
@end

@implementation ZHMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self loadData];
    
    [iNotiCenter addObserver:self selector:@selector(loadData) name:ON_BIDDING_SETTING_CHANGE object:nil];
    [iNotiCenter addObserver:self selector:@selector(onKeyboardChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [iNotiCenter addObserver:self selector:@selector(updateLeftBarBtn) name:ON_BIDDING_CHANGE_NOTI object:nil];

}
-(void)loadData{
    self.vm = [BiddingVM vmWith:ZHUtil.base total:ZHUtil.totalNum min:ZHUtil.minBid times:ZHUtil.timesPerMonth];
    [self.tv reloadData];
    [self updateLeftBarBtn];
}
-(void)dealloc{
    [iNotiCenter removeObserver:self];
}

#pragma mark - actions
-(void)setupData{
    ZHSettingVC *vc = [[ZHSettingVC alloc]init];
    [UIViewController pushVC:vc];
}
-(void)clearData{
    UIAlertController *vc = [UIAlertController alertControllerWithTitle:iStr(@"警告") message:iStr(@"确定删除所有标额数据") preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:iStr(@"取消") style:UIAlertActionStyleDefault handler:nil];
    [vc addAction:cancel];
    @weakRef(self)
    UIAlertAction* ok = [UIAlertAction actionWithTitle:iStr(@"删除") style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [weak_self.vm clearData];
    }];
    [vc addAction:ok];
    [UIViewController.curVC presentViewController:vc animated:YES completion:0];
}
-(void)updateLeftBarBtn{
    self.navigationItem.leftBarButtonItem.enabled=self.vm.hasBidRecord;
}

-(void)onKeyboardChange:(NSNotification *)noti{

    CGFloat dura=[noti.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    CGRect endframe=[noti.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat h = endframe.size.height;
    CGFloat y = endframe.origin.y;
    BOOL hide = y>=iScreenH;
    [self.tv mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.equalTo(@0);
        make.bottom.equalTo(@(hide?0:-h));
    }];
    [UIView animateWithDuration:dura animations:^{
        [self.view layoutIfNeeded];
    }];
}

#pragma mark - UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.vm.row;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZHCell *cell = [tableView dequeueReusableCellWithIdentifier:celliden];
    cell.mod=[self.vm modBy:indexPath];
    return cell;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return dp2po(60);
}


-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.tvHeader;
}

#pragma mark - UI
-(void)initUI{
    self.title=iStr(@"会计");
    self.view.backgroundColor=iGlobalBG;
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:iStr(@"设置") style:UIBarButtonItemStylePlain target:self action:@selector(setupData)];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:iStr(@"清除") style:UIBarButtonItemStylePlain target:self action:@selector(clearData)];
    self.navigationItem.leftBarButtonItem.enabled=NO;
    
    self.tv = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tv.backgroundColor=iGlobalBG;
    self.tv.bounces=YES;
    self.tv.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    self.tv.separatorColor=iCommonSeparatorColor;
    self.tv.tableFooterView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, dp2po(10))];
    self.tv.tableHeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, dp2po(0))];
    self.tv.sectionHeaderHeight=dp2po(50);
    self.tv.sectionFooterHeight=0;
    self.tv.dataSource=self;
    self.tv.delegate=self;
    [self.tv registerClass:ZHCell.class forCellReuseIdentifier:celliden];
    // layout ---
    [self.view addSubview:self.tv];
    [self.tv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.top.equalTo(@0);
        make.bottom.equalTo(@0);
    }];
}

-(UIView *)tvHeader{
    UIView *v = [[UIView alloc]init];
    UILabel *lab = [IProUtil commonLab:iBFont(dp2po(15)) color:iColor(0x5a, 0x5a, 0x6a, 1)];
    lab.text=iFormatStr(@"总名额:%ld  月供:%ld  期望标:%ld 月标:%.1f次",ZHUtil.totalNum,ZHUtil.base,ZHUtil.minBid,ZHUtil.timesPerMonth);
    [v addSubview:lab];
    [lab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
    }];
    v.backgroundColor=iGlobalBG;
    return v;
}
    
@end
