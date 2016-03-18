//
//  ModalViewController.m
//  tu_bar
//
//  Created by 肖准 on 15/11/26.
//  Copyright © 2015年 肖准. All rights reserved.
//

#import "ModalViewController.h"

@interface ModalViewController ()
@property(nonatomic,strong)UIView* uiview;
@end

@implementation ModalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor colorWithWhite:1.000 alpha:0.441];
    [self.view addSubview:self.uiview];
    
    // Do any additional setup after loading the view.
}

-(UIView*)uiview{
    if (_uiview==nil) {
        _uiview = [[UIView alloc]initWithFrame:CGRectZero];
        _uiview.bounds=CGRectMake(0, 0, 200, 300);
        _uiview.center=CGPointMake(self.view.width/2, self.view.height/2);
        _uiview.backgroundColor=[UIColor whiteColor];
        
        
    }
    return _uiview;
    
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
