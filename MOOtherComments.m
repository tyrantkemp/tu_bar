//
//  MOOtherComments.m
//  tu_bar
//
//  Created by 肖准 on 15/10/21.
//  Copyright © 2015年 肖准. All rights reserved.
//

#import "MOOtherComments.h"

@implementation MOOtherComments
-(instancetype)init{
    if(self=[super init]){
        self.iconurl=@"";
        self.idname=@"";
        self.toid=@"";
        self.des=@"";
        self.time=@"";
        self.isLZ=0;
    }
    return  self;
}
@end
