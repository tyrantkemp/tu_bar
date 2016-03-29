//
//  RegisterViewController.m
//  Login_Register
//
//  Created by Mac on 14-3-26.
//  Copyright (c) 2014年 NanJingXianLang. All rights reserved.
//

#import "RegisterViewController.h"
#import "TopNavBar.h"

@interface RegisterViewController ()<UITableViewDataSource,UITableViewDelegate,TopNavBarDelegate,UITextFieldDelegate,NSXMLParserDelegate>

@property (nonatomic,assign) BOOL          isRead;

@end

@implementation RegisterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
}
- (void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
    
}

/**
 *	@brief	键盘出现
 *
 *	@param 	aNotification 	参数
 */
- (void)keyboardWillShow:(NSNotification *)aNotification

{
    
    [UIView animateWithDuration:0.25 animations:^{
        
        self.view.frame = CGRectMake(0.f, -35.f, self.view.frame.size.width, self.view.frame.size.height);
        
    }completion:nil] ;

}

/**
 *	@brief	键盘消失
 *
 *	@param 	aNotification 	参数
 */
- (void)keyboardWillHide:(NSNotification *)aNotification

{
    [UIView animateWithDuration:0.25 animations:^{
        
        self.view.frame = CGRectMake(0.f, 0.f, self.view.frame.size.width, self.view.frame.size.height);
        
    }completion:nil];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor =[UIColor colorWithRed:0.922 green:0.922 blue:0.945 alpha:1.000];
    //创建导航条
    [self createCustomNavBar];
    
    //创建tableView
    [self createTableView];
}

/**
 *	@brief	创建TableView
 */
- (void)createTableView{

    _registerTableView = [[UITableView alloc] initWithFrame:CGRectMake(0.f, (FSystenVersion >= 7.0)?64.f:44.f-1, self.view.width, (FSystenVersion >=7.0)?(ISIPHONE5?(568.f - 64.f):(480.f - 64.f)):(ISIPHONE5?(548.f - 44.f):(460.f - 44.f))) style:UITableViewStyleGrouped];
   
//    _registerTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44) style:UITableViewStyleGrouped];
    _registerTableView.allowsSelection = NO;
    _registerTableView.delegate = self;
    _registerTableView.dataSource = self;
    [self.view addSubview:_registerTableView];
    
}

/**
 *	@brief	创建自定义导航条
 */
- (void)createCustomNavBar
{
    _topNavBar = [[TopNavBar alloc] initWithFrame:CGRectMake(0.f, 0.f, 320.f, (FSystenVersion >= 7.0)?64.f:44.f)
                                      bgImageName:(FSystenVersion >= 7.0)?@"backgroundNavbar_ios7@2x":@"backgroundNavbar_ios6@2x"
                                       labelTitle:@"注册"
                                         labFrame:CGRectMake(90.f,(FSystenVersion >= 7.0)?27.f:7.f , 140.f, 30.f)
                                         leftBool:YES
                                     leftBtnFrame:CGRectMake(12.f, (FSystenVersion >= 7.0)?27.f:7.f, 30.f, 30.f)
                                 leftBtnImageName:@"button_back_bg@2x.png"
                                        rightBool:NO
                                    rightBtnFrame:CGRectZero
                                rightBtnImageName:nil];
    _topNavBar.delegate = self;
    [self.view addSubview:_topNavBar];
    
}

#pragma mark - TopNavBarDelegate Method
/**
 *	@brief	TopNavBarDelegate Method
 *
 *	@param 	index 	barItemButton 的索引值
 */
- (void)itemButtonClicked:(int)index
{
    switch (index) {
        case 0:
        {
            //[Utils alertTitle:@"提示" message:@"您点击了返回按钮" delegate:nil cancelBtn:@"取消" otherBtnName:nil];
            [self.view endEditing:YES];
            [self dismissViewControllerAnimated:YES completion:^{
                    }];
        
        }
            break;
        case 1:
        {
            
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 2) {
        return 2;
    }else{
        
        return 1;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *cellIdentifier = @"cellIdentifier";
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier] ;

    if (indexPath.section == 0){
        cell.imageView.image = PNGIMAGE(@"register_email@2x");
        UITextField *textField= [[UITextField alloc] initWithFrame:CGRectMake(50.f, 12.f, 220.f, 21.f)];
        textField.tag = Tag_EmailTextField;
        textField.returnKeyType = UIReturnKeyDone;
        textField.delegate = self;
        textField.placeholder = @"邮箱,必填";
        textField.keyboardType = UIKeyboardTypeEmailAddress;
        [cell addSubview:textField];
        
    }else if (indexPath.section == 1){
        
        cell.imageView.image = PNGIMAGE(@"register_user@2x");
        UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(50.f, 12.f, 220.f, 21.f)];
        textField.tag = Tag_AccountTextField;
        textField.returnKeyType = UIReturnKeyDone;
        textField.delegate = self;
        textField.placeholder = @"用户名,必填";
        [cell addSubview:textField];
        
    }else if (indexPath.section == 2){
        
        if (indexPath.row == 0) {
            
            cell.imageView.image = PNGIMAGE(@"register_password@2x");
            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(50.f, 12.f, 220.f, 21.f)];
            textField.tag = Tag_TempPasswordTextField;
            textField.returnKeyType = UIReturnKeyDone;
            textField.secureTextEntry = YES;
            textField.delegate = self;
            textField.placeholder = @"密码,必填";
            [cell addSubview:textField];
            
        }else if (indexPath.row == 1){
            
            cell.imageView.image = PNGIMAGE(@"register_password@2x");
            UITextField *textField = [[UITextField alloc] initWithFrame:CGRectMake(50.f, 12.f, 220.f, 21.f)];
            textField.tag = Tag_ConfirmPasswordTextField;
            textField.returnKeyType = UIReturnKeyDone;
            textField.secureTextEntry = YES;
            textField.delegate = self;
            textField.placeholder = @"确认密码,必填";
            [cell addSubview:textField];
        }
    }
        else if(indexPath.section==3){
        UIButton *registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        registerBtn.frame = CGRectMake((FSystenVersion >= 7.0)?0.f:10.f, 0.f, (FSystenVersion>=7.0)?320.f:300.f, 44.f);
        [registerBtn addTarget:self action:@selector(registerBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [registerBtn setBackgroundImage:[UIImage imageNamed:@"register_btn@2x"] forState:UIControlStateNormal];
        [registerBtn setTitle:@"提交" forState:UIControlStateNormal];
        [registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        registerBtn.titleLabel.font = [UIFont systemFontOfSize:18.f];
        [registerBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
        
        [cell addSubview:registerBtn];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0) {
        
        return nil;
    }else if (section == 1){
        
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, 320.f, 21.f)];
        footerView.backgroundColor = [UIColor clearColor];
        UILabel *label = [Utils labelWithFrame:CGRectMake(10.f, 0.f, 300.f, 21.f) withTitle:@"注册后不可更改，3~20位字符，可包含英文、数字和“_”" titleFontSize:[UIFont systemFontOfSize:10.f] textColor:[UIColor blackColor] backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
        [footerView addSubview:label];
        
        return footerView ;
    }else if (section == 2){
        
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, 320.f, 21.f)];
        footerView.backgroundColor = [UIColor clearColor];
        UILabel *label = [Utils labelWithFrame:CGRectMake(10.f, 0.f, 300.f, 21.f) withTitle:@"6位字符以上，可包含数字、字母（区分大小写）" titleFontSize:[UIFont systemFontOfSize:10.f] textColor:[UIColor blackColor] backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
        [footerView addSubview:label];
        return footerView ;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    return 5.0;
}


-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 5.f;
    }else if(section == 4){
        
        return 30.f;
        
    }else{
        return 21.f;
    }
}

-(UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc] initWithFrame:CGRectZero] ;
}


#pragma mark - UIButtonClicked Method
- (void)buttonClicked:(id)sender{
    
    UIButton *btn = (UIButton *)sender;
    switch (btn.tag) {
        case Tag_isReadButton:
        {
            //是否阅读协议
            if (_isRead) {
                
                [btn setImage:[UIImage imageNamed:@"isRead_waiting_selectButton@2x"] forState:UIControlStateNormal];
                _isRead = NO;
            }else{
                
                [btn setImage:[UIImage imageNamed:@"isRead_selectedButton@2x"] forState:UIControlStateNormal];
                
                _isRead = YES;
            }
        }
            break;
        case Tag_servicesButton:
        {
            //服务协议
            [Utils alertTitle:@"提示" message:@"您点击了服务协议" delegate:nil cancelBtn:@"取消" otherBtnName:nil];
        }
            break;
        case Tag_privacyButton:
        {
            //隐私协议
            [Utils alertTitle:@"提示" message:@"您点击了隐私协议" delegate:nil cancelBtn:@"取消" otherBtnName:nil];
        }
            break;
            
        default:
            break;
    }
    
}
#pragma mark - sourceBtnClicked Method
- (void)sourceBtnClicked:(id)sender{
    
    [Utils alertTitle:@"提示" message:@"来源接口方法入口" delegate:nil cancelBtn:@"确定" otherBtnName:nil];
}

#pragma mark - RegisterBtnClicked Method
- (void)registerBtnClicked:(id)sender{
    
    
    if ([self checkValidityTextField]) {
        
        
        self.registerTableView.userInteractionEnabled=NO;
        
        t_sys_user *user= [[t_sys_user alloc] init ];
        
        NSString* password=[(UITextField *)[self.view viewWithTag:Tag_TempPasswordTextField] text];
        NSString* encrpepwd=[password md5Encrypt];
        NSLog(@"md5加密后:%@",[Utils md5:encrpepwd]);
        
        user.username =[(UITextField *)[self.view viewWithTag:Tag_AccountTextField] text];
        user.mail=[(UITextField *)[self.view viewWithTag:Tag_EmailTextField] text];
        
        
        
        
        
        
        
        user.password=[Utils md5:encrpepwd];
        
        
        
        AFHTTPSessionManager * manager  = [AFHTTPSessionManager manager];
        [manager POST:REGISTER_URL parameters:[user JSONDictionary] constructingBodyWithBlock:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSDictionary* dict = responseObject[@"register"];
            NSString* status = [dict objectForKey:@"status"];
            NSString* errMsg = [dict objectForKey:@"errorMsg"];
            
            if(status && [status isEqualToString:@"200"]){
                [ProgressHUD showSuccess:@"注册成功"];
                
                UIStoryboard *stryBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
                leftmenuTableViewController* left=[stryBoard instantiateViewControllerWithIdentifier:@"left"];
                mainViewController* ma=[stryBoard instantiateViewControllerWithIdentifier:@"tab"];
                ICSDrawerController *drawer = [[ICSDrawerController alloc] initWithLeftViewController:left
                                                                                 centerViewController:ma];
                
                [Utils UserDefaultSetValue:user.username forKey:USER_NAME];
                [Utils UserDefaultSetValue:user.mail forKey:USER_MAIL];
                [Utils UserDefaultSetValue:user.password forKey:USER_PWD];
            }else  if([status isEqualToString:@"301"]){
                [ProgressHUD showError:@"用户名重复"];
                [(UITextField *)[self.view viewWithTag:Tag_AccountTextField]setText:@""];
                [(UITextField *)[self.view viewWithTag:Tag_AccountTextField]becomeFirstResponder];
                self.registerTableView.userInteractionEnabled=YES;
            }else if([status isEqualToString:@"300"]){
                [ProgressHUD showError:[ NSString stringWithFormat:@"服务器错误:%@",errMsg]];
            }
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"注册失败:%@",error);
        }];
        
        
        
    }
}
-(void)progressstop{
    [self dismissViewControllerAnimated:YES completion:nil];

}
-(void)urlRequestFailed:(ASIHTTPRequest *)request
{
    NSError *error =[request error];
    NSLog(@"%@",error);
    NSLog(@"连接失败！");
    UIAlertView * alt=[[UIAlertView alloc] initWithTitle:@"提示" message:@"连接服务器失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alt show];
    self.registerTableView.userInteractionEnabled=YES;

}

//请求成功
-(void)urlRequestSucceeded:(ASIHTTPRequest *)request
{
    NSData *data=[request responseData];
    NSXMLParser *parser=[[NSXMLParser alloc] initWithData:data];
    NSLog(@"data length = %d",[data length]);
    NSLog(@"xml data = %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    [parser setDelegate:self];
    [parser parse];//进入解析
}

/**
 *	@brief	验证文本框是否为空
 */
#pragma mark checkValidityTextField Null
- (BOOL)checkValidityTextField
{
    
    if ([(UITextField *)[self.view viewWithTag:Tag_EmailTextField] text] == nil || [[(UITextField *)[self.view viewWithTag:Tag_EmailTextField] text] isEqualToString:@""]) {
        
        [Utils alertTitle:@"提示" message:@"邮箱不能为空" delegate:self cancelBtn:@"取消" otherBtnName:nil];
        
        return NO;
    }
    if ([(UITextField *)[self.view viewWithTag:Tag_AccountTextField] text] == nil || [[(UITextField *)[self.view viewWithTag:Tag_AccountTextField] text] isEqualToString:@""]) {
        
        [Utils alertTitle:@"提示" message:@"用户名不能为空" delegate:self cancelBtn:@"取消" otherBtnName:nil];
        
        return NO;
    }
    if ([(UITextField *)[self.view viewWithTag:Tag_TempPasswordTextField] text] == nil || [[(UITextField *)[self.view viewWithTag:Tag_TempPasswordTextField] text] isEqualToString:@""]) {
        
        [Utils alertTitle:@"提示" message:@"用户密码不能为空" delegate:self cancelBtn:@"取消" otherBtnName:nil];
        
        return NO;
    }
    if ([(UITextField *)[self.view viewWithTag:Tag_ConfirmPasswordTextField] text] == nil || [[(UITextField *)[self.view viewWithTag:Tag_ConfirmPasswordTextField] text] isEqualToString:@""]) {
        
        [Utils alertTitle:@"提示" message:@"用户确认密码不能为空" delegate:self cancelBtn:@"取消" otherBtnName:nil];
        
        return NO;
    }
    
    return YES;
    
}

#pragma mark - UITextFieldDelegate Method

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if (textField.tag == Tag_RecommadTextField) {
        
        [UIView animateWithDuration:0.25 animations:^{
            
            self.view.frame = CGRectMake(0.f, -35.f, self.view.frame.size.width, self.view.frame.size.height);
            
        }completion:nil] ;
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    switch (textField.tag) {
            
        case Tag_EmailTextField:
        {
            if ([textField text] != nil && [[textField text] length]!= 0) {
                
                if (![Utils isValidateEmail:textField.text]) {
                    
                    [Utils alertTitle:@"提示" message:@"邮箱格式不正确" delegate:nil cancelBtn:@"取消" otherBtnName:nil];
                }
            }
        }
            break;
        case Tag_TempPasswordTextField:
        {
            if ([textField text] != nil && [[textField text] length]!= 0) {
                
                if ([[textField text] length] < 6) {
                    
                    [Utils alertTitle:@"提示" message:@"用户密码小于6位！" delegate:nil cancelBtn:@"取消" otherBtnName:nil];
                }
            }
        }
            break;
        case Tag_ConfirmPasswordTextField:
        {
            if ([[(UITextField *)[self.view viewWithTag:Tag_TempPasswordTextField] text] length] !=0 && ([textField text]!= nil && [[textField text] length]!= 0)) {
                
                if (![[(UITextField *)[self.view viewWithTag:Tag_TempPasswordTextField] text] isEqualToString:[textField text]]) {
                    [Utils alertTitle:@"提示" message:@"两次输入的密码不一致" delegate:nil cancelBtn:@"取消" otherBtnName:nil];
                }
            }
        }
            break;
        case Tag_RecommadTextField:
        {
            [UIView animateWithDuration:0.25 animations:^{
                
                self.view.frame = CGRectMake(0.f, (FSystenVersion >= 7.0)?0.f:20.f, self.view.frame.size.width, self.view.frame.size.height);
                
            }completion:nil];
        }
            break;
            
        default:
            break;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark - touchMethod
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [super touchesBegan:touches withEvent:event];
    
    [self allEditActionsResignFirstResponder];
}

#pragma mark - PrivateMethod
- (void)allEditActionsResignFirstResponder{
    //邮箱
    [[self.view viewWithTag:Tag_EmailTextField] resignFirstResponder];
    //用户名
    [[self.view viewWithTag:Tag_AccountTextField] resignFirstResponder];
    //temp密码
    [[self.view viewWithTag:Tag_TempPasswordTextField] resignFirstResponder];
    //确认密码
    [[self.view viewWithTag:Tag_ConfirmPasswordTextField] resignFirstResponder];
    //推荐人
   // [[self.view viewWithTag:Tag_RecommadTextField] resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
