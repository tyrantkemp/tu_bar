//
//  leftmenuTableViewController.h
//  tu_bar
//
//  Created by 肖准 on 15/9/28.
//  Copyright (c) 2015年 肖准. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ICSDrawerController.h"
#import "menuTableViewCell.h"
#import "LoginViewController.h"
#import <RongIMLib/RongIMLib.h>
#import <RongIMKit/RongIMKit.h>
#import "ChatListViewController.h"
@interface leftmenuTableViewController : UITableViewController<ICSDrawerControllerChild,ICSDrawerControllerPresenting>

@end
