
#import "YFBasicVC.h"
#import "objc/runtime.h"


@implementation YFBasicVC

-(void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIUtil commonNav:self shadow:YES line:NO translucent:NO];
    if(!self.ignoreAddToCurVC)
        [UIViewController setVC:self];
    
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self.view endEditing:YES];
    //----- Firebase
//    [FIRAnalytics setScreenName:self.title screenClass:[self.classForCoder description]];
}



-(void)setNavigationController:(UINavigationController *)nav{
    _nav=nav;
}
-(UINavigationController *)navigationController{
    if(_nav)return _nav;
    return [super navigationController];
}


@end
