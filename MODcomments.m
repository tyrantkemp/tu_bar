//
//  MODcomments.m
//  
//
//  Created by 肖准 on 15/10/4.
//
//

#import "MODcomments.h"
@implementation MODcomments
-(instancetype)init{
    if(self=[super init]){
        
        self.imgId=@"";
        self.nameId=@"";
        self.url=@"";
        self.des=@"";
        self.auther=@"";
        self.top=0;
        self.down=0 ;
        self.comments = [[NSMutableArray<NSComment> alloc]init];
    
        NSComment* com = [[NSComment alloc]init];
        [self.comments addObject:com];
        
    }
    return  self;
}
@end