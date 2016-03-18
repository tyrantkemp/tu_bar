//
//  RegisterViewController.h
//  Login_Register
//
//  Created by Mac on 14-3-26.
//  Copyright (c) 2014年 NanJingXianLang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegisterUser.h"
#import "leftmenuTableViewController.h"
#import "mainViewController.h"
#import "TopNavBar.h"
#import "NSString+xzmd5.h"

@interface RegisterViewController : UIViewController


@property (nonatomic,strong) UITableView *registerTableView;

@property (nonatomic,strong) TopNavBar    *topNavBar;

@end
