//
//  mainViewController.m
//  tu_bar
//
//  Created by 肖准 on 15/9/28.
//  Copyright (c) 2015年 肖准. All rights reserved.
//

#import "mainViewController.h"

@interface mainViewController ()<UIGestureRecognizerDelegate>
@property(nonatomic,strong)leftmenuTableViewController* left;

@property(nonatomic, strong) UITapGestureRecognizer *tapGestureRecognizer;
@property(nonatomic, strong) UIPanGestureRecognizer *panGestureRecognizer;
@property(nonatomic, assign) CGPoint panGestureStartLocation;
@end

@implementation mainViewController
//-(void)awakeFromNib{
//    self.left=[self.storyboard instantiateViewControllerWithIdentifier:@"left"];
//    ICSDrawerController* ctl=[[ICSDrawerController alloc]initWithLeftViewController:self.left centerViewController:self];
//    NSLog(@"1212");
//    self.view.window.rootViewController=ctl;
//    [self.view.window makeKeyAndVisible];
//    
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"tabbar,%@",NSStringFromClass([self.view.window.rootViewController class]));

    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
