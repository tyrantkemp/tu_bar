//
//  AppDelegate.m
//  tu_bar
//
//  Created by 肖准 on 15/9/28.
//  Copyright (c) 2015年 肖准. All rights reserved.
//

#import "AppDelegate.h"
#import "ICSDrawerController.h"
#import "mainViewController.h"
#import "leftmenuTableViewController.h"
#define RONGCLOUD_IM_APPKEY @"y745wfm84a62v" //请换成您的appkey
static BOOL RYLogin = false;
@interface AppDelegate ()

@end

@implementation AppDelegate
-(void)login{
    ICSDrawerController* drawer =[Utils getICSDrawer];
    self.window.rootViewController=drawer;

}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//    self.window.backgroundColor = [UIColor blackColor];

//    self.window.rootViewController = drawer;
//    [self.window makeKeyAndVisible];
//    NSDictionary * userdict = [Utils UserDefaultGetValueByKey:USER_INFO];
//    RegisterUser * user = [[RegisterUser alloc]initWithDictionary:userdict error:nil];
//
    
   
    
    [[RCIM sharedRCIM] initWithAppKey:RONGCLOUD_IM_APPKEY];
    [self RYLogin];
    
    /**
     * 推送处理1
     */
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        //注册推送, iOS 8
        UIUserNotificationSettings *settings = [UIUserNotificationSettings
                                                settingsForTypes:(UIUserNotificationTypeBadge |
                                                                  UIUserNotificationTypeSound |
                                                                  UIUserNotificationTypeAlert)
                                                categories:nil];
        [application registerUserNotificationSettings:settings];
    } else {
        UIRemoteNotificationType myTypes = UIRemoteNotificationTypeBadge |
        UIRemoteNotificationTypeAlert |
        UIRemoteNotificationTypeSound;
        [application registerForRemoteNotificationTypes:myTypes];
    }
    
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(didReceiveMessageNotification:)
     name:RCKitDispatchMessageNotification
     object:nil];
    
    
    [[RCIM sharedRCIM] setConnectionStatusDelegate:self];
    
    //`````````````````````````````````````````//
    
    BOOL isAutoLogin = [[Utils UserDefaultGetValueByKey:USER_ISLOGIN] boolValue];
    NSString* username= [Utils UserDefaultGetValueByKey:USER_NAME];
    NSString* pwd= [Utils UserDefaultGetValueByKey:USER_PWD];
    NSLog(@"user=%@,pwd=%@",username,pwd);
    LoginViewController* login =[[LoginViewController alloc]init];
    if(ISDEBUG==1){
        [Utils getAllAlbums];
         NSString* albumjsonstr = [Utils getAlbumInfoFromServerByUserName:username];
       // [Utils UserDefaultSetValue:albumjsonstr forKey:USER_ALBUMS];
        self.window.rootViewController=login;
        return  YES;
    }
    if(isAutoLogin){
        NSLog(@"自动登陆");
        //载入加载视图，同步提交服务器验证用户名和密码
        LoginViewController* ctl=[[LoginViewController alloc]init];
        self.window.rootViewController=ctl;
       

        if([Utils isVerified:username pwd:pwd] && RYLogin){
//            self.window.rootViewController=login;
//            [login presentViewController:drawer animated:NO completion:nil];
            NSLog(@"登陆成功");
            //创建默认相册
            [Utils getAllAlbums];

            NSString* albumjsonstr = [Utils getAlbumInfoFromServerByUserName:username];
           // [Utils UserDefaultSetValue:albumjsonstr forKey:USER_ALBUMS];

          //  [login loginsucess];
            [self performSelector:@selector(login) withObject:nil afterDelay:1.5];
        }else {
            NSLog(@"用户名或密码错误");
            [ProgressHUD showError:@"用户名或密码错误"];
            self.window.rootViewController=login;
        }
        
    }else{
        NSLog(@"非自动登陆");
    }
    return YES;
}



/**
 *此方法中要提供给融云用户的信息，建议缓存到本地，然后改方法每次从您的缓存返回
 */
- (void)getUserInfoWithUserId:(NSString *)userId completion:(void(^)(RCUserInfo* userInfo))completion
{
    //此处为了演示写了一个用户信息
    if ([@"1" isEqual:userId]) {
        RCUserInfo *user = [[RCUserInfo alloc]init];
        user.userId = @"1";
        user.name = @"测试1";
        user.portraitUri = @"https://ss0.baidu.com/73t1bjeh1BF3odCf/it/u=1756054607,4047938258&fm=96&s=94D712D20AA1875519EB37BE0300C008";
        
        return completion(user);
    }else if([@"test" isEqual:userId]) {
        RCUserInfo *user = [[RCUserInfo alloc]init];
        user.userId = @"test";
        user.name = @"test";
        user.portraitUri = @"https://ss0.baidu.com/73t1bjeh1BF3odCf/it/u=1756054607,4047938258&fm=96&s=94D712D20AA1875519EB37BE0300C008";
        return completion(user);
    }else if([ @"11111" isEqual:userId]){
        RCUserInfo * user= [[RCUserInfo alloc]init];
        user.userId=@"tyrant";
        user.name=@"xiaozhun";
        user.portraitUri=@"http://image.baidu.com/search/detail?ct=503316480&z=0&ipn=d&word=%E6%96%BD%E7%93%A6%E8%BE%9B%E6%A0%BC&step_word=&pn=10&spn=0&di=53881854840&pi=&rn=1&tn=baiduimagedetail&is=&istype=0&ie=utf-8&oe=utf-8&in=&cl=2&lm=-1&st=undefined&cs=1069339392%2C2715896577&os=3048015349%2C3525542714&simid=3390081563%2C415201391&adpicid=0&ln=1000&fr=&fmq=1455018072412_R&ic=undefined&s=undefined&se=&sme=&tab=0&width=&height=&face=undefined&ist=&jit=&cg=&bdtype=0&objurl=http%3A%2F%2Fimg3.100bt.com%2Fupload%2Fttq%2F20121209%2F1355032216236.jpg&fromurl=ippr_z2C%24qAzdH3FAzdH3Fqq_z%26e3B8aakp_z%26e3Bv54AzdH3Fp5rtv-8aa8mla9-8_z%26e3Bip4s&gsm=0";
        return completion(user);
    }
}
/**
 *  将得到的devicetoken 传给融云用于离线状态接收push ，您的app后台要上传推送证书
 *
 *  @param application <#application description#>
 *  @param deviceToken <#deviceToken description#>
 */
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *token =
    [[[[deviceToken description] stringByReplacingOccurrencesOfString:@"<"
                                                           withString:@""]
      stringByReplacingOccurrencesOfString:@">"
      withString:@""]
     stringByReplacingOccurrencesOfString:@" "
     withString:@""];
    
    [[RCIMClient sharedRCIMClient] setDeviceToken:token];
}


/**
 *  网络状态变化。
 *
 *  @param status 网络状态。
 */
- (void)onRCIMConnectionStatusChanged:(RCConnectionStatus)status {
    if (status == ConnectionStatus_KICKED_OFFLINE_BY_OTHER_CLIENT) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"提示"
                              message:@"您"
                              @"的帐号在别的设备上登录，您被迫下线！"
                              delegate:nil
                              cancelButtonTitle:@"知道了"
                              otherButtonTitles:nil, nil];
          [alert show];
        
        
//        ViewController *loginVC = [[ViewController alloc] init];
//        UINavigationController *_navi =
//        [[UINavigationController alloc] initWithRootViewController:loginVC];
//        self.window.rootViewController = _navi;
    }
}


-(void)RYLogin{
    //登录融云服务器,开始阶段可以先从融云API调试网站获取，之后token需要通过服务器到融云服务器取。
    // NSString*token=@"R4pndcrU9jVwWVoOVJp+3Zi7G+RcWalRc6uMVq+pl0hSCAdaD+m/W2jKz8ORuB0WS3DG+yT0dHBOSwIhNY7mTg==";
    [[RCIM sharedRCIM] connectWithToken:TOKEN success:^(NSString *userId) {
        //设置用户信息提供者,页面展现的用户头像及昵称都会从此代理取
        [[RCIM sharedRCIM] setUserInfoDataSource:self];
        NSLog(@"Login successfully with userId: %@.", userId);
        RYLogin = true;
    } error:^(RCConnectErrorCode status) {
        NSLog(@"login error status: %ld.", (long)status);
    } tokenIncorrect:^{
        NSLog(@"token 无效 ，请确保生成token 使用的appkey 和初始化时的appkey 一致");
    }];
}


- (void)didReceiveMessageNotification:(NSNotification *)notification {
    [UIApplication sharedApplication].applicationIconBadgeNumber =
    [UIApplication sharedApplication].applicationIconBadgeNumber + 1;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
