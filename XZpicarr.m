//
//  XZpicarr.m
//  tu_bar
//
//  Created by 肖准 on 15/10/14.
//  Copyright © 2015年 肖准. All rights reserved.
//

#import "XZpicarr.h"
#define FILE_P @"/Users/tyrantxz/Desktop/db/picarr.json"
@implementation XZpicarr

//将数据写入json文件
-(BOOL)saveData{
    
    NSError* err=nil;
    NSError* dataerr=nil;
    NSLog(@"pic.arr:%@",self.arr);
    for(int i=0 ;i<self.arr.count;++i){
        NSData* assetdata=[NSKeyedArchiver archivedDataWithRootObject:self.arr[i][@"picset"][0]];
        self.arr[i][@"picset"]=assetdata;
    }
    NSLog(@"pic.arr:%@",self.arr);

    NSData *data=[NSJSONSerialization dataWithJSONObject:self.arr options:NSJSONWritingPrettyPrinted error:nil];
    if(dataerr){
        NSLog(@"数据转化错误：%@",[dataerr localizedDescription]);
        return false;
    }else{
        
        NSString* datastr=[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        [datastr writeToFile:FILE_P atomically:YES encoding:NSUTF8StringEncoding error:&err];
        if(err==nil){
            return  true;
        }else{
            NSLog(@"写入json错误：%@",[err localizedDescription]);
            return false;
        }
    }
    
    
  
    
    
}

-(BOOL)getData{
    NSError* err=nil;
    NSFileManager *ma=[NSFileManager defaultManager];
    if([ma fileExistsAtPath:FILE_P]){
    NSData* data = [NSData dataWithContentsOfFile:FILE_P];
    self.arr=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
    if(err){
        NSLog(@"json读取错误:%@",[err localizedDescription]);
        return  false;
    }else {
        return  true;
    }
    }else{
        NSLog(@"没有文件:%@",FILE_P);
        return  false;
    }
}
@end
