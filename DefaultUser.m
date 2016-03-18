//
//  DefaultUser.m
//  tu_bar
//
//  Created by 肖准 on 15/11/2.
//  Copyright © 2015年 肖准. All rights reserved.
//

#import "DefaultUser.h"

@implementation DefaultUser
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if(self=[super init]){
        self.userId=[aDecoder decodeObjectForKey:@"userId"];
        self.userName=[aDecoder decodeObjectForKey:@"userName"];
        self.bacUrl=[aDecoder decodeObjectForKey:@"bacUrl"];
        self.iconUrl=[aDecoder decodeObjectForKey:@"iconUrl"];
    }
    return  self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.userId forKey:@"userId"];
    [aCoder encodeObject:self.userName forKey:@"userName"];
    [aCoder encodeObject:self.bacUrl forKey:@"bacUrl"];
    [aCoder encodeObject:self.iconUrl forKey:@"iconUrl"];
}
@end
