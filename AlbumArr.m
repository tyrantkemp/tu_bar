//
//  AlbumArr.m
//  tu_bar
//
//  Created by 肖准 on 15/11/27.
//  Copyright © 2015年 肖准. All rights reserved.
//

#import "AlbumArr.h"

@implementation AlbumArr
-(instancetype)init{
    if(self=[super init]){
        self.albarr=[[NSMutableArray<Album*>alloc]init];
    }
    return  self;
}
@end
