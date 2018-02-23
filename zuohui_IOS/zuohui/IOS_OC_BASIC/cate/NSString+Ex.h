//
//  NSString+Ex.h
//Created by apple on 17/07/21.
//

#import <Foundation/Foundation.h>

@interface NSString (Ex)

-(instancetype)strByAppendToCachePath;
-(instancetype)strByAppendToDocPath;
-(instancetype)strByAppendToTempPath;
-(BOOL)ignorecaseEqualTo:(NSString *) str;
-(unsigned int)toHexValue;
-(NSInteger)toHexLongValue;
-(UInt8)toHexByte;
-(CGSize)sizeBy:(UIFont *)font;
-(CGSize)sizeBy:(CGSize)size font:(UIFont *)font;
@end
