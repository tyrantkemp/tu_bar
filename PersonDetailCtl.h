//
//  PersonDetailCtl.h
//  tu_bar
//
//  Created by 肖准 on 15/11/2.
//  Copyright © 2015年 肖准. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+vImage.h"
@interface PersonDetailCtl : UIViewController
@property(nonatomic,strong)NSString* namestr;
-(instancetype)initWithName:(NSString*)name;
@end
