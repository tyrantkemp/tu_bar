//
//  Imgid.h
//  tu_bar
//
//  Created by 肖准 on 15/12/8.
//  Copyright © 2015年 肖准. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Imgid
@end
@interface Imgid : JSONModel
@property(nonatomic,strong)NSString* imgid;
@end
