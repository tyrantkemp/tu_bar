//
//  Album.m
//  tu_bar
//
//  Created by 肖准 on 15/11/27.
//  Copyright © 2015年 肖准. All rights reserved.
//

#import "Album.h"

@implementation Album
-(instancetype)init{
    if(self=[super init]){
        self.albumname=@"";
        self.holderimgid=@"";
        self.imgids=@"";
        
    }
    return  self;
}
-(instancetype)initWithParams:(NSString*)albumname holderimgid:(NSString*)holderimgid imgids:(NSString*)imgids{
   self= [self init];
    self.albumname=albumname;
    self.holderimgid=(holderimgid==nil)?@"44A3762B66A4B5F1BB51533A00B96114":holderimgid;
    self.imgids=(imgids==nil)?@"":imgids;
    return  self;
}
@end
