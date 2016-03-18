//
//  DefaultUser.h
//  tu_bar
//
//  Created by 肖准 on 15/11/2.
//  Copyright © 2015年 肖准. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"
@interface DefaultUser : JSONModel<NSCoding>
@property(nonatomic,strong)NSString* userId;
@property(nonatomic,strong)NSString* userName;
@property(nonatomic,strong)NSString* iconUrl;
@property(nonatomic,strong)NSString* bacUrl;
@end
