//
//  MOOtherComments.h
//  tu_bar
//
//  Created by 肖准 on 15/10/21.
//  Copyright © 2015年 肖准. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModelLib.h"
@protocol MOOtherComments
@end
@interface MOOtherComments : JSONModel
@property(nonatomic,copy)NSString* iconurl;
@property(nonatomic,copy)NSString* idname;
@property(nonatomic,copy)NSString* toid;
@property(nonatomic,copy)NSString* des;
@property(nonatomic,copy)NSString* time;
@property(nonatomic,assign)NSInteger isLZ;
@end
