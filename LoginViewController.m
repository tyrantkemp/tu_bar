//
//  LoginViewController.m
//  tu_bar
//
//  Created by 肖准 on 15/11/11.
//  Copyright © 2015年 肖准. All rights reserved.
//

#import "LoginViewController.h"
static const int TXHEIGHT= 100;
#define framesize self.view.frame.size
@interface LoginViewController ()<UITextFieldDelegate>


@property(strong,nonatomic )CALayer* txlayer;
@property(strong,nonatomic )CALayer* sdlayer;
@property(strong,nonatomic) UIButton *btnlogin;
@property(nonatomic,strong) UITextField* TFuser;
@property(nonatomic,strong) UILabel* LBuser;
@property(nonatomic,strong) UITextField* TFpwd;
@property(nonatomic,strong) UILabel* LBpwd;
@property(nonatomic,strong) UIButton* regedit;


@property(nonatomic,assign)BOOL autologin;
@property (nonatomic, assign) BOOL chang;
//@property(nonatomic,strong)FMDatabase* db;

@end

@implementation LoginViewController
-(void)regiditbtn:(UIButton*)sender{
    
    RegisterViewController* ctl=[[RegisterViewController alloc]init];
    
    [self presentViewController:ctl animated:YES completion:^{
        
    }];
 
    
}


- (void)login:(UIButton *)sender {
    
    //{"login":{"id":"0001","status":"OK","errorMsg":""}}

    //此处用户名密码都为空时可登陆，方便测试
    NSLog(@"login");
    NSString* password=self.TFpwd.text;
    NSString* username = self.TFuser.text;
    
    AFHTTPSessionManager * managr = [AFHTTPSessionManager manager];
    [managr POST:VERIFY_URL parameters:@{@"password":password,@"username":username} progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary* dict = responseObject[@"login"];
        NSString* status = [dict objectForKey:@"status"];
        NSString* erorMsg = [dict objectForKey:@"errorMsg"];
        
        if([status isEqualToString:@"200"]){
            
            //登陆成功，则修改默认用户名密码
            [Utils UserDefaultSetValue:self.TFuser.text forKey:USER_NAME];
            [Utils UserDefaultSetValue:self.TFpwd.text forKey:USER_PWD];
            [Utils setAutoLogin:YES];
            
            //进入主界面
            UIStoryboard *stryBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
            leftmenuTableViewController* left=[stryBoard instantiateViewControllerWithIdentifier:@"left"];
            mainViewController* ma=[stryBoard instantiateViewControllerWithIdentifier:@"tab"];
            ICSDrawerController *drawer = [[ICSDrawerController alloc] initWithLeftViewController:left
                                                                             centerViewController:ma];
            [self presentViewController:drawer animated:YES completion:^{
                [Utils setAutoLogin:YES];
                [self.TFuser setText:@""];
                [self.TFpwd setText:@""];
            } ];
            
            
        }else if([status isEqualToString:@"300"]){
            
            [ProgressHUD showError:@"用户名或密码错误"];
            
            
        }else {
            [ProgressHUD showError:@"服务器出错"];

        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"login error:%@",error);
        
    }];
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    


    
        NSLog(@"非自动登陆");
        //图标右上角红标提醒数量
        float version = [[[UIDevice currentDevice] systemVersion] floatValue];
        if (version >= 8.0) {
            NSLog(@"version:%f",version);
            UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
            [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        }
        UIApplication* app = [UIApplication sharedApplication];
        app.applicationIconBadgeNumber=123;
        //互联网指示器
        app.networkActivityIndicatorVisible=YES;
        
        
        self.view.backgroundColor=[UIColor whiteColor];
        
        [self.view.layer addSublayer:self.txlayer];
        [self.view.layer addSublayer:self.sdlayer];
        [self.view addSubview:self.btnlogin];
        [self.view addSubview:self.regedit];
        
        
        
        CGFloat centerx = framesize.width/2;
        XZInputText *inputText = [[XZInputText alloc] init];
        CGFloat userY = CGRectGetMaxY(_txlayer.bounds)+TXHEIGHT+30;
        UITextField *userText = [inputText setupWithIcon:nil textY:userY centerX:centerx point:nil];
        userText.delegate = self;
        self.TFuser = userText;
        [userText setReturnKeyType:UIReturnKeyNext];
        [userText addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
        [self.view addSubview:userText];
        
        UILabel *userTextName = [self setupTextName:@"user" frame:self.TFuser.frame];
        self.LBuser = userTextName;
        [self.view addSubview:self.LBuser];
        
        
        //  CGFloat centerx = framesize.width/2;
        // XZInputText *inputText = [[XZInputText alloc] init];
        CGFloat pwdY = CGRectGetMaxY(_txlayer.bounds)+TXHEIGHT+78;
        UITextField *pwdText = [inputText setupWithIcon:nil textY:pwdY centerX:centerx point:nil];
        pwdText.delegate = self;
        pwdText.secureTextEntry=YES;
        self.TFpwd = pwdText;
        [pwdText setReturnKeyType:UIReturnKeyNext];
        [pwdText addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
        [self.view addSubview:pwdText];
        
        UILabel *pwdTextName = [self setupTextName:@"Password" frame:self.TFpwd.frame];
        self.LBpwd = pwdTextName;
        [self.view addSubview:self.LBpwd];

    
    
    
}

-(CALayer*)txlayer{
    if(_txlayer==nil){
        _txlayer=[[CALayer alloc]init];
        _txlayer.bounds=CGRectMake(0, 0, TXHEIGHT, TXHEIGHT);
        _txlayer.position=CGPointMake(framesize.width/2, framesize.height/4);
        _txlayer.cornerRadius=TXHEIGHT/2;
        _txlayer.masksToBounds=YES;
        _txlayer.backgroundColor=[UIColor colorWithRed:0.922 green:0.922 blue:0.945 alpha:1.000].CGColor;
        _txlayer.borderWidth=2;
        _txlayer.borderColor=[UIColor whiteColor].CGColor;
        UIImage * touxiang = [UIImage imageNamed:@"my.png"];
        [_txlayer setContents:(id)touxiang.CGImage];
    }
    return  _txlayer;
    
}

-(CALayer*)sdlayer{
    
    if(_sdlayer==nil){
        _sdlayer=[[CALayer alloc]init];
        _sdlayer.borderWidth=2;
        _sdlayer.borderColor=[UIColor whiteColor].CGColor;
        _sdlayer.shadowOffset=CGSizeMake(2, 2);
        _sdlayer.shadowOpacity=1;
        _sdlayer.shadowColor=[UIColor colorWithRed:0.922 green:0.922 blue:0.945 alpha:1.000].CGColor;
        _sdlayer.cornerRadius=TXHEIGHT/2;
        _sdlayer.bounds=CGRectMake(0, 0, TXHEIGHT, TXHEIGHT);
        _sdlayer.position=CGPointMake(framesize.width/2, framesize.height/4);
    }
    return _sdlayer;
    
    
}
-(UIButton*)btnlogin{
    if(_btnlogin==nil){
        _btnlogin=[UIButton buttonWithType:UIButtonTypeCustom];
        _btnlogin.backgroundColor=[UIColor colorWithRed:0.055 green:0.322 blue:0.624 alpha:1.000];
        [_btnlogin setTitle:@"登  陆" forState:UIControlStateNormal];
        [_btnlogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnlogin setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        _btnlogin.bounds=CGRectMake(0, 0, framesize.width/8*5, 40);
        _btnlogin.center=CGPointMake(framesize.width/2, framesize.height/4*3);
        [_btnlogin addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return  _btnlogin;
}
-(UIButton*)regedit{
    if(_regedit==nil){
        _regedit=[UIButton buttonWithType:UIButtonTypeCustom];
        _regedit.backgroundColor=[UIColor clearColor];
        [_regedit setTitle:@"注 册" forState:UIControlStateNormal];
        [_regedit setTitleColor:[UIColor colorWithRed:0.039 green:0.303 blue:0.983 alpha:1.000] forState:UIControlStateNormal];
        [_regedit setTitleColor:[UIColor colorWithRed:0.101 green:0.762 blue:0.986 alpha:1.000] forState:UIControlStateHighlighted];
        _regedit.bounds=CGRectMake(0, 0, 50, 40);
        _regedit.center=CGPointMake(framesize.width/2, self.btnlogin.centerY+60);
        [_regedit addTarget:self action:@selector(regiditbtn:) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return  _regedit;
}
- (UILabel *)setupTextName:(NSString *)textName frame:(CGRect)frame
{
    UILabel *textNameLabel = [[UILabel alloc] init];
    textNameLabel.text = textName;
    textNameLabel.font = [UIFont systemFontOfSize:16];
    textNameLabel.textColor = [UIColor grayColor];
    textNameLabel.frame = frame;
    return textNameLabel;
}
- (void)textFieldDidChange
{
    if (self.TFuser.text.length != 0 && self.TFpwd.text.length != 0) {
        self.btnlogin.enabled = YES;
    } else {
        self.btnlogin.enabled = NO;
    }
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField == self.TFuser) {
        [self diminishTextName:self.LBuser];
        [self restoreTextName:self.LBpwd  textField:self.TFpwd];
    } else if (textField == self.TFpwd) {
        [self diminishTextName:self.LBpwd];
        [self restoreTextName:self.LBuser textField:self.TFuser];
    }
    return YES;
}
- (void)diminishTextName:(UILabel *)label
{
    [UIView animateWithDuration:0.5 animations:^{
        label.transform = CGAffineTransformMakeTranslation(0, -16);
        label.font = [UIFont systemFontOfSize:9];
    }];
}
- (void)restoreTextName:(UILabel *)label textField:(UITextField *)textFieled
{
    [self textFieldTextChange:textFieled];
    if (self.chang) {
        [UIView animateWithDuration:0.5 animations:^{
            label.transform = CGAffineTransformIdentity;
            label.font = [UIFont systemFontOfSize:16];
        }];
    }
}
- (void)textFieldTextChange:(UITextField *)textField
{
    if (textField.text.length != 0) {
        self.chang = NO;
    } else {
        self.chang = YES;
    }
}
#pragma mark - touchesBegan
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
    [self restoreTextName:self.LBuser textField:self.TFuser];
    [self restoreTextName:self.LBpwd textField:self.TFpwd];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.TFuser) {
        return [self.TFpwd becomeFirstResponder];
    } else {
        [self restoreTextName:self.LBpwd textField:self.TFpwd];
        return [self.TFpwd resignFirstResponder];
    }
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
