//
//  t_sys_img.m
//  tu_bar
//
//  Created by 肖准 on 16/3/30.
//  Copyright © 2016年 肖准. All rights reserved.
//

#import "t_sys_img.h"

@implementation t_sys_img

// Specify default values for properties

//+ (NSDictionary *)defaultPropertyValues
//{
//    return @{};
//}

// Specify properties to ignore (Realm won't persist these)

//+ (NSArray *)ignoredProperties
//{
//    return @[];
//}

+(NSString*)primaryKey{
    return @"imgId";
}
@end
