//
//  LoginCoverViewCtl.m
//  tu_bar
//
//  Created by 肖准 on 15/11/13.
//  Copyright © 2015年 肖准. All rights reserved.
//

#import "LoginCoverViewCtl.h"

@implementation LoginCoverViewCtl
-(void)viewDidLoad{
    [super viewDidLoad];
    UIImageView* bacview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"pic_bizhi14.jpg"]];
    bacview.frame=self.view.frame;
    [self.view addSubview:bacview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
