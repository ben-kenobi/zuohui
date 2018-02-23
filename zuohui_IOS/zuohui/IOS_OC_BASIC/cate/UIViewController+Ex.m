//
//  UIViewController+Ex.m
//Created by apple on 17/07/21.
//

#import "UIViewController+Ex.h"
#import "objc/runtime.h"


@implementation UIViewController (Ex)
+(void)pushVC:(UIViewController *)vc{
//   id obj= [objc_getAssociatedObject(iApp, iVCKey) navigationController];
    dispatch_async(dispatch_get_main_queue(), ^{
        UIViewController * obj=objc_getAssociatedObject(iApp, iVCKey);
        if([obj  isKindOfClass:[UINavigationController class]]){
            [(UINavigationController *)obj pushViewController:vc animated:YES];
        }else{
            [ [obj navigationController] pushViewController:vc animated:YES];
        }
    });
   
}
+(void)setVC:(UIViewController *)vc{
    objc_setAssociatedObject(iApp, iVCKey, vc, OBJC_ASSOCIATION_ASSIGN);
}
+(void)popVC{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIViewController *obj=objc_getAssociatedObject(iApp, iVCKey);
        if([obj  isKindOfClass:[UINavigationController class]]){
            [(UINavigationController *)obj popViewControllerAnimated:YES];
        }else{
            [ [obj navigationController] popViewControllerAnimated:YES];
        }

    });
}

+(instancetype)curVC{
   return  objc_getAssociatedObject(iApp, iVCKey);
}


-(void)alert:(NSString *)title msg:(NSString *)msg{
    UIAlertController *vc = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    [vc addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:0]];
    [self presentViewController:vc animated:YES completion:nil];
}

@end
