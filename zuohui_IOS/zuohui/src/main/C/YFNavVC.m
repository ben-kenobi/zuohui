
#import "YFNavVC.h"

@implementation YFNavVC


-(void)viewDidLoad{
    [super viewDidLoad];
    self.navigationBar.backIndicatorImage=img(@"navigation_back_icon");
    self.navigationBar.backIndicatorTransitionMaskImage=img(@"navigation_back_icon");
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    UIBarButtonItem *item =
    [[UIBarButtonItem alloc] initWithTitle:@"" style:0 target:0 action:0];;
    [item setTitleTextAttributes:@{NSFontAttributeName:iFont(15)} forState:UIControlStateNormal];
    viewController.navigationItem.backBarButtonItem=item;
    
    
    if(self.childViewControllers.count>0)
        viewController.hidesBottomBarWhenPushed=YES;
    [super pushViewController:viewController animated:animated];
    
    //只有调用根控制器的方法才能改变statusbar的状态
    [iAppDele.window.rootViewController setNeedsStatusBarAppearanceUpdate];
}
-(UIViewController *)popViewControllerAnimated:(BOOL)animated{
    UIViewController *vc=[super popViewControllerAnimated:animated];
    [iAppDele.window.rootViewController setNeedsStatusBarAppearanceUpdate];
    return vc;
}

-(UIViewController *)childViewControllerForStatusBarStyle{
    return self.viewControllers.lastObject;
}
-(UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

#pragma mark - Ratation and Orientation

-(BOOL)shouldAutorotate {
    return NO;
}

-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}

-(UIInterfaceOrientationMask)supportedInterfaceOrientations {
    
    UIInterfaceOrientationMask mask = UIInterfaceOrientationMaskPortrait;
    //    if([self.topViewController isKindOfClass:[LivePlayViewController class]]){
    //        return UIInterfaceOrientationMaskPortrait | UIInterfaceOrientationMaskLandscapeRight | UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskPortraitUpsideDown;
    //    }
    //    else{
    //        return UIInterfaceOrientationMaskPortrait;
    //    }
    
    return mask;
}

@end
