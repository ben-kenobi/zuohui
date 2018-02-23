

#import <UIKit/UIKit.h>

@interface YFBasicVC : UIViewController
{
    __weak UINavigationController *_nav;
}
@property (nonatomic,assign)BOOL ignoreAddToCurVC;

-(void)setNavigationController:(UINavigationController *)nav;
@end
