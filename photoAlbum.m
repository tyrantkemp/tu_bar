//
//  photoAlbum.m
//  tu_bar
//
//  Created by 肖准 on 16/3/18.
//  Copyright © 2016年 肖准. All rights reserved.
//

#import "photoAlbum.h"

@implementation photoAlbum

// Specify default values for properties

+ (NSDictionary *)defaultPropertyValues
{
    return @{@"albumName":@"",@"holderImg":@"",@"imgIds":@""};
}

// Specify properties to ignore (Realm won't persist these)

//+ (NSArray *)ignoredProperties
//{
//    return @[];
//}

@end
