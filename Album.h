//
//  Album.h
//  tu_bar
//
//  Created by 肖准 on 15/11/27.
//  Copyright © 2015年 肖准. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Imgid.h"
@protocol Album
@end
@interface Album : JSONModel

@property(nonatomic,copy)NSString* albumname;
@property(nonatomic,copy)NSString* holderimgid;
@property(nonatomic,copy)NSString* imgids;
-(instancetype)initWithParams:(NSString*)albumname holderimgid:(NSString*)holderimgid imgids:(NSString*)imgids;
@end
