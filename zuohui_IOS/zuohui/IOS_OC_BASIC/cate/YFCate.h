

#import "UIView+Ex.h"
#import "UIColor+Ex.h"
#import "UIImage+Ex.h"
#import "NSString+Ex.h"
#import "NSArray+Ex.h"
#import "IUtil.h"
#import "UIViewController+Ex.h"
#import "Masonry.h"
#import "NSDate+Ex.h"
#import "NSObject+Ex.h"
#import "FileUtil.h"
#import "NetUtil.h"
#import "UIImageView+WEB.h"
#import "UIImageView+WebCache.h"
#import "UIButton+Ex.h"
#import "UIBarButtonItem+Ex.h"


typedef void (^defBlock)(void);

BOOL emptyStr(NSString *str);
BOOL nullObj(id obj);

NSLocale * prefLocale(void);

UIWindow *frontestWindow(void);

NSTimer * iTimer(CGFloat inteval,id tar,SEL sel,id userinfo);

CADisplayLink *iDLink(id tar,SEL sel);
void runOnMain(void (^blo)(void));
void runOnGlobal(void (^blo)(void));

NSString * iphoneType(void) ;

BOOL isRightToLeft(void);
UIImage * i18nImg(NSString *name);




@interface iPop : NSObject

+(void)showMsg:(NSString*)msg;
+(void)showSuc:(NSString*)msg;
+(void)showError:(NSString*)msg;
+(void)showProg;
+(void)dismProg;
+(void)toast:(NSString*)msg;
@end

@interface iDialog : NSObject
+(void)dialogWith:(NSString*)title msg:(NSString*)msg actions:(NSArray *)actions vc:(UIViewController*)vc;
@end

@interface ALUtil:NSObject
+(void)setImgFromALURL:(NSURL*)alurl cb:(void(^)(UIImage *))cb;
@end

