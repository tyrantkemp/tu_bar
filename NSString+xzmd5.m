//
//  NSString+xzmd5.m
//  tu_bar
//
//  Created by 肖准 on 15/11/14.
//  Copyright © 2015年 肖准. All rights reserved.
//

#import "NSString+xzmd5.h"

@implementation NSString (xzmd5)
-(NSString *)md5Encrypt {
    const char *original_str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++)
        [hash appendFormat:@"%02X",result[i]];
    return [hash lowercaseString];
}
@end
