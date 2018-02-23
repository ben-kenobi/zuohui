//
//  YFClearableTF.h
//  BatteryCam
//
//  Created by yf on 2017/8/18.
//  Copyright © 2017年 oceanwing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFClearableTF : UITextField
@property (nonatomic,strong)void (^onTxtChangeCB)(YFClearableTF *);
@property (nonatomic,strong)void (^onEditingChangeCB)(YFClearableTF *);
@property (nonatomic,assign)BOOL adjustFocusColor;
@property (nonatomic,strong)UIView *bottomLine;
@property (nonatomic,strong)UIView *topline;
@property (nonatomic,assign)BOOL needNotiNoneUserChange;

@end
