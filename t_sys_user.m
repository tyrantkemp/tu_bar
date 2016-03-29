//
//  t_sys_register_user.m
//  tu_bar
//
//  Created by 肖准 on 16/3/26.
//  Copyright © 2016年 肖准. All rights reserved.
//

#import "t_sys_user.h"

@implementation t_sys_user

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



+(NSDictionary*)defaultPropertyValues{
    return @{@"createtime":[NSDate date],@"delFlag":@0 };
}
@end
