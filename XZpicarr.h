//
//  XZpicarr.h
//  tu_bar
//
//  Created by 肖准 on 15/10/14.
//  Copyright © 2015年 肖准. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XZpicarr : NSObject

@property (nonatomic,strong)   NSMutableArray* arr;

-(BOOL)saveData;
-(BOOL)getData;
@end
