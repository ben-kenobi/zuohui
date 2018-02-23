//
//  YFClearableTF.m
//  BatteryCam
//
//  Created by yf on 2017/8/18.
//  Copyright © 2017年 oceanwing. All rights reserved.
//

#import "YFClearableTF.h"

@interface YFClearableTF()<UITextFieldDelegate>
@property (nonatomic,weak)id<UITextFieldDelegate> subDelegate;

@end


@implementation YFClearableTF

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([@"enabled" isEqualToString:keyPath]){
        UIView *ph = [self valueForKey:@"_placeholderLabel"];
        ph.hidden=!self.enabled;
    }else if([@"text" isEqualToString:keyPath]){
        if(self.needNotiNoneUserChange)
            [self onTextChanged:nil];
    }
}
-(void)onTextChanged:(NSNotification *)noti{
    if(self.onTxtChangeCB)
        self.onTxtChangeCB(self);
}
-(void)onEditingChange{
    if(self.onEditingChangeCB)
        self.onEditingChangeCB(self);
}
-(void)dealloc{
    [iNotiCenter removeObserver:self];
    [self removeObserver:self forKeyPath:@"enabled"];
    [self removeObserver:self forKeyPath:@"text"];
}


#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    [self.subDelegate textFieldDidBeginEditing:textField];
    if(self.adjustFocusColor){
        self.bottomLine.backgroundColor=iGlobalFocusColor;
        _topline.backgroundColor=self.bottomLine.backgroundColor;
        [self onEditingChange];
    }

}
// became first responder

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self.subDelegate textFieldDidEndEditing:textField];
    self.bottomLine.backgroundColor=iColor(0xdd, 0xdd, 0xdd, 1);
    _topline.backgroundColor=self.bottomLine.backgroundColor;
    [self onEditingChange];

}
// may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called
- (void)textFieldDidEndEditing:(UITextField *)textField reason:(UITextFieldDidEndEditingReason)reason {
    [self.subDelegate textFieldDidEndEditing:textField reason:reason];
    self.bottomLine.backgroundColor=iColor(0xdd, 0xdd, 0xdd, 1);
    _topline.backgroundColor=self.bottomLine.backgroundColor;
    [self onEditingChange];

    
}
// if implemented, called in place of textFieldDidEndEditing:


#pragma mark - UI
-(instancetype)init{
    if(self = [super init]){
        [self initUI];
    }
    return self;
}

-(void)initUI{
    self.leftView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 15, 0)];
    self.leftViewMode=UITextFieldViewModeAlways;
    
    self.clearButtonMode=UITextFieldViewModeWhileEditing;
    
    [iNotiCenter addObserver:self selector:@selector(onTextChanged:) name:UITextFieldTextDidChangeNotification object:self];
    [self addObserver:self forKeyPath:@"enabled" options:NSKeyValueObservingOptionOld context:nil];
    [self addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionOld context:nil];
    
    self.delegate=self;

    self.bottomLine=[[UIView alloc]init];
    [self addSubview:self.bottomLine];
    self.bottomLine.backgroundColor=iColor(0xdd, 0xdd, 0xdd, 1);
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.height.equalTo(@(dp2po(1)));
    }];
    self.adjustFocusColor=YES;
}


@end
