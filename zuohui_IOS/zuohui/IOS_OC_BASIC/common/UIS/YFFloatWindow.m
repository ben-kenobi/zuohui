//
//  YFFloatWindow.m
//  BatteryCam
//
//  Created by yf on 2017/12/22.
//  Copyright © 2017年 oceanwing. All rights reserved.
//

#import "YFFloatWindow.h"

@implementation YFFloatWindow
-(id)initWithFrame:(CGRect)frame

{
    
    self = [super initWithFrame:frame];
    
    
    
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        self.windowLevel = UIWindowLevelAlert + 1;
        
        //******
        
        [self makeKeyAndVisible];
        
        
        
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _button.backgroundColor = [UIColor grayColor];
        
        _button.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        
        _button.layer.cornerRadius = frame.size.width/2;
        
        [_button addTarget:self action:@selector(choose) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_button];
        
        
        
        //add a gesture
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(changePostion:)];
        
        [_button addGestureRecognizer:pan];
        
    }
    
    return self;
    
}





-(void)choose

{
    
    NSLog(@"float btn be clicked");
    
}


-(void)changePostion:(UIPanGestureRecognizer *)pan

{
    
    CGPoint point = [pan translationInView:self];
    
    
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    
    
    CGRect originalFrame = self.frame;
    
    if (originalFrame.origin.x >= 0 && originalFrame.origin.x+originalFrame.size.width <= width) {
        
        originalFrame.origin.x += point.x;
        
    }
    
    if (originalFrame.origin.y >= 0 && originalFrame.origin.y+originalFrame.size.height <= height) {
        
        originalFrame.origin.y += point.y;
        
    }
    
    self.frame = originalFrame;
    
    [pan setTranslation:CGPointZero inView:self];
    
    
    
    if (pan.state == UIGestureRecognizerStateBegan) {
        
        _button.enabled = NO;
        
    }else if (pan.state == UIGestureRecognizerStateChanged){
        
        
        
    } else {
        
        
        
        CGRect frame = self.frame;
        
        //is out of boundary
        
        BOOL isOver = NO;
        
        
        
        if (frame.origin.x < 0) {
            
            frame.origin.x = 0;
            
            isOver = YES;
            
        } else if (frame.origin.x+frame.size.width > width) {
            
            frame.origin.x = width - frame.size.width;
            
            isOver = YES;
            
        }
        
        
        
        if (frame.origin.y < 0) {
            
            frame.origin.y = 0;
            
            isOver = YES;
            
        } else if (frame.origin.y+frame.size.height > height) {
            
            frame.origin.y = height - frame.size.height;
            
            isOver = YES;
            
        }
        if (isOver) {
            
            [UIView animateWithDuration:0.3 animations:^{
                
                self.frame = frame;
                
            }];
            
        }
        
        _button.enabled = YES;
        
    }
    
}


@end
