//
//  idGenerator.m
//  tu_bar
//
//  Created by 肖准 on 16/3/30.
//  Copyright © 2016年 肖准. All rights reserved.
//


 
#import "IdGenerator.h"
 
static long long time_stamp = 0;
static long long time_stamp_now = 0;
static NSMutableArray *temp = NULL;
static NSNumber *random_n = NULL;
static NSLock *theLock = NULL;
 
@implementation IdGenerator
 
/*
  *  获取下一个Ids
  */
+ (long long)getId{
         
        if(theLock == NULL)
                theLock = [[NSLock alloc]init];
         
        if(temp == NULL)
                temp = [[NSMutableArray alloc]init];
         
        @synchronized(theLock){
                time_stamp_now = [[NSDate date] timeIntervalSince1970];
                if(time_stamp_now != time_stamp){
                        //清空缓存，更新时间戳
                        [temp removeAllObjects];
                        time_stamp = time_stamp_now;
                    }
                 
                //判断缓存中是否存在当前随机数
                while ([temp containsObject:(random_n = [NSNumber numberWithLong:arc4random() % 8999 + 1000])])
                        ;
                 
                if ([temp containsObject:random_n]) {
                        return -1;
                    }
                 
                [temp addObject:[NSNumber numberWithLong:[random_n longValue]]];
            }
         
        return (time_stamp * 10000) + [random_n longValue];
}
 
@end