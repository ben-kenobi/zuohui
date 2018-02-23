//
//  UIView+Ex.h
//Created by apple on 17/07/21.
//

#import <UIKit/UIKit.h>
UIView * layoutView(UIView *sup,NSArray *subs,NSInteger colNum,BOOL full);
UIView * layoutViewWithSize(UIView *sup,NSArray *subs,NSInteger colNum,BOOL full,CGSize size);

@interface UIView (Ex)

@property (nonatomic,assign)CGFloat x;
@property (nonatomic,assign)CGFloat y;
@property (nonatomic,assign)CGFloat w;
@property (nonatomic,assign)CGFloat h;
@property (nonatomic,assign)CGFloat b;
@property (nonatomic,assign)CGFloat r;
@property (nonatomic,assign)CGFloat cx;
@property (nonatomic,assign)CGFloat cy;
@property (nonatomic,assign,readonly)CGPoint innerCenter;
@property (nonatomic,assign,readonly)CGFloat icx;
@property (nonatomic,assign,readonly)CGFloat icy;
@property (nonatomic,assign)CGSize size;
@property (nonatomic,assign)CGPoint origin;

-(void)setB2:(CGFloat )b;
-(void)setR2:(CGFloat )r;
-(void)setX2:(CGFloat )x;
-(void)setY2:(CGFloat )y;


-(void)measurePriority:(float)level hor:(BOOL)hor;
+(instancetype)viewWithColor:(UIColor *)color;

@end


@interface CALayer (Ex)
@property (nonatomic,assign)CGFloat x;
@property (nonatomic,assign)CGFloat y;
@property (nonatomic,assign)CGFloat w;
@property (nonatomic,assign)CGFloat h;
@property (nonatomic,assign)CGFloat b;
@property (nonatomic,assign)CGFloat r;
@property (nonatomic,assign)CGFloat cx;
@property (nonatomic,assign)CGFloat cy;
@property (nonatomic,assign,readonly)CGPoint innerCenter;
@property (nonatomic,assign,readonly)CGFloat icx;
@property (nonatomic,assign,readonly)CGFloat icy;
@property (nonatomic,assign)CGSize size;
@property (nonatomic,assign)CGPoint origin;
@property (nonatomic,assign)CGFloat anchorX;
@property (nonatomic,assign)CGFloat anchorY;

-(void)setB2:(CGFloat )b;
-(void)setR2:(CGFloat )r;
-(void)setX2:(CGFloat )x;
-(void)setY2:(CGFloat )y;
-(void)setAnchor:(CGFloat) x y:(CGFloat)y;



@end
