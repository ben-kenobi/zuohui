//
//  BCStyleSheetMod.h
//  BatteryCam
//
//  Created by yf on 2017/8/16.
//  Copyright © 2017年 oceanwing. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BCStyleSheetMod;

@protocol BCStyleSheetListDelegate <NSObject>

-(NSInteger)count;
-(BCStyleSheetMod *)get:(NSInteger)idx;

@end

@interface BCStyleSheetMod : NSObject
@property (nonatomic,copy)NSString *title;
@property (nonatomic,strong)UIImage *icon;
@property (nonatomic,strong)void (^cb)();


@end
