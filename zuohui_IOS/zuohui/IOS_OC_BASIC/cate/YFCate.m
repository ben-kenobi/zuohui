

#import <Foundation/Foundation.h>
#import <sys/utsname.h>
#import "SVProgressHUD.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "UIView+Toast.h"
BOOL emptyStr(NSString *str){
    return !str||!str.length;
}
BOOL nullObj(id obj){
    return obj==nil||[obj isKindOfClass:[NSNull class]];
}
UIWindow *frontestWindow(){
    if(iVersion>=11){
        UIWindow *window = iApp.windows[0];
        if(CGRectEqualToRect(iScreen.bounds , window.bounds)){
            return window;
        }
        return iApp.windows[1];
    }else{
        UIWindow *window = iApp.windows[iApp.windows.count-1];
        if(CGRectEqualToRect(iScreen.bounds , window.bounds)){
            return window;
        }
        return iApp.windows[iApp.windows.count-2];
    }
}

NSLocale * prefLocale(){
    return [NSLocale localeWithLocaleIdentifier:[NSLocale preferredLanguages][0]];
}

BOOL isRightToLeft(){
     return [UIView userInterfaceLayoutDirectionForSemanticContentAttribute:UIView.appearance.semanticContentAttribute]==UIUserInterfaceLayoutDirectionRightToLeft;
}

UIImage * i18nImg(NSString * name){
    UIImage *img = img(name);
    if(isRightToLeft()){
        return img.horizonMirroredImg;
    }
    return img;
}

NSTimer * iTimer(CGFloat inteval,id tar,SEL sel,id userinfo){
    NSTimer *timer=[NSTimer timerWithTimeInterval:inteval target:tar selector:sel userInfo:userinfo repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    return timer;
}

CADisplayLink *iDLink(id tar,SEL sel){
    CADisplayLink *link= [CADisplayLink displayLinkWithTarget:tar selector:sel];
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    return link;
}

void runOnMain(void (^blo)()){
    dispatch_async(dispatch_get_main_queue(), blo);
}
void runOnGlobal(void (^blo)()){
    dispatch_async(dispatch_get_global_queue(0, 0), blo);
}



NSString * iphoneType() {
    
    
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if ([platform isEqualToString:@"iPhone1,1"]) return @"iPhone 2G";
    
    if ([platform isEqualToString:@"iPhone1,2"]) return @"iPhone 3G";
    
    if ([platform isEqualToString:@"iPhone2,1"]) return @"iPhone 3GS";
    
    if ([platform isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    
    if ([platform isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    
    if ([platform isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    
    if ([platform isEqualToString:@"iPhone5,2"]) return @"iPhone 5";
    
    if ([platform isEqualToString:@"iPhone5,3"]) return @"iPhone 5c";
    
    if ([platform isEqualToString:@"iPhone5,4"]) return @"iPhone 5c";
    
    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";
    
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone 7";
    
    if ([platform isEqualToString:@"iPhone9,2"]) return @"iPhone 7 Plus";
    
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G";
    
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G";
    
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G";
    
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G";
    
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G";
    
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G";
    
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2";
    
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G";
    
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3";
    
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3";
    
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3";
    
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4";
    
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air";
    
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air";
    
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air";
    
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G";
    
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G";
    
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G";
    
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    
    return platform;
    
}










@implementation iPop
+(void)showMsg:(NSString*)msg{
    [SVProgressHUD showInfoWithStatus:msg];
    
}
+(void)showSuc:(NSString*)msg{
    [SVProgressHUD showSuccessWithStatus:msg];
    
}
+(void)showError:(NSString*)msg{
    [SVProgressHUD showErrorWithStatus:msg];
    
}
+(void)showProg{
    [SVProgressHUD setDefaultMaskType:(SVProgressHUDMaskTypeBlack)];
    [SVProgressHUD  show];
//    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
}
+(void)dismProg{
    [SVProgressHUD dismiss];
    
}
+(void)toast:(NSString*)msg{
    if(!msg)return;
    runOnMain(^{
        //        iApp.windows[iApp.windows.count-1].makeToast(msg)
        [frontestWindow() makeToast:msg duration:1.5 position:nil title:nil image:nil style:[CSToastManager sharedStyle] completion:nil];
    });
}
@end


@implementation iDialog : NSObject
+(void)dialogWith:(NSString*)title msg:(NSString*)msg actions:(NSArray *)actions vc:(UIViewController*)vc{
    UIAlertController* ac = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert] ;
    for (UIAlertAction* action in actions){
        [ac addAction:action];
    }
    [vc presentViewController:ac animated:true completion:nil];
}

@end

@implementation ALUtil:NSObject
+(void)setImgFromALURL:(NSURL*)alurl cb:(void(^)(UIImage *))cb{
    ALAssetsLibraryAssetForURLResultBlock resultblock=^(ALAsset *asset){
        ALAssetRepresentation* rep = asset.defaultRepresentation;
        __unsafe_unretained CGImageRef iref =  [rep fullResolutionImage];
        UIImage * image = [UIImage imageWithCGImage:iref];
        dispatch_async(dispatch_get_main_queue(), ^{
            cb(image);
        });
    };
    ALAssetsLibraryAccessFailureBlock failureblock = ^(NSError *error){
        printf("\n-----load ALAssets fail------\n");
    };
    ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];
    [assetslibrary assetForURL:alurl resultBlock:resultblock failureBlock:failureblock];
}
@end

