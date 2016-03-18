//
//  NSComment.m
//  
//
//  Created by 肖准 on 15/10/4.
//
//

#import "NSComment.h"

@implementation NSComment

-(instancetype)init{
    if(self=[super init]){
        self.url=@"";
        self.auther=@"";
        self.des=@"";
        self.index=0;;
         self.othercomments=[[NSMutableArray<MOOtherComments> alloc]init];
        MOOtherComments* othercomment = [[MOOtherComments alloc]init];
        [self.othercomments addObject:othercomment];
        
    }
    return  self;
}


@end
