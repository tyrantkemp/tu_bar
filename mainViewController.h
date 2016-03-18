//
//  mainViewController.h
//  tu_bar
//
//  Created by 肖准 on 15/9/28.
//  Copyright (c) 2015年 肖准. All rights reserved.
//

#import <UIKit/UIKit.h>
#import  "leftmenuTableViewController.h"
#import "ICSDrawerController.h"
@interface mainViewController : UITabBarController<ICSDrawerControllerPresenting,ICSDrawerControllerChild>

@end
