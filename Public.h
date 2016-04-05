

#ifndef iOS_Public_h
#define iOS_Public_h
#import "ALAssetsLibrary+TCategory.h"

/**   通用工具文件 **/
#import  "UConstants.h"
#import  "AppConstants.h"
#import "UIView+frame.h"
#import "UIImage+vImage.h"
#import "UIImage+autofit.h"
#import "UIImage+Resize.h"
#import "ProgressHUD.h"

#import "Utils.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

#import "RegisterUser.h"


//第三方工具文件
#import <AFNetworking.h>
#import <UIKit+AFNetworking.h>
#import <Realm/Realm.h>
#import <Realm+JSON/RLMObject+JSON.h>

//debug开关
#define ISDEBUG 1
/**   App常量 **/
#define HEADER_DES 899
#define HEADER_ICON 898
#define HEADER_NAME 897
#define CELL_DES 999
#define CELL_ICON 998
#define ARC4RANDOM_MAX      0x100000000

//默认相册的封面
#define DEFAULT_IMG_ID  @"xxxxxxxxxxx"

//消息中心
#define ADD_PIC_NOTI @"addpicnoti"
#define USER_BACIMG @"userimgurl"
#define USER_ISLOGIN @"userislogin"
#define USER_NAME @"username"
#define USER_PWD @"userpwd"
#define USER_MAIL @"usermail"
#define USER_ALBUMS @"useralblums"
#define USER_PTLIST @"user_private_talk_list"
#define LEFTVIEWCLOSE @"LEFTVIEWCLOSE"

//荣云配置
#define TOKEN @"0EVu1/epVCt51fcQ0Y8CCy+g8ZFerpUMvABkLnxAtiMnExoGoj6AtKz1lVb35tP79t1C7rGfOq/fpcKMX9rbgQ=="
#define URL_MAIN @"http://tyrantkemp.imwork.net:21848/imgServ/app/"
#define USER_INFO @"userinfo"
#define REGISTER_URL @"http://tyrantkemp.imwork.net:21848/imgServ/app/register"
#define VERIFY_URL  @"http://tyrantkemp.imwork.net:21848/imgServ/app/verify"
#define UPLOAD_PICS_URL @"http://tyrantkemp.imwork.net:21848/imgServ/app/uploadfile"
#define URL_GETALBUMINFO @"http://tyrantkemp.imwork.net:21848/imgServ/app/getalbuminfo"
#define URL_GETIMG [URL_MAIN stringByAppendingString:@"getImg/"]
#define URL_UPLOADALBUMINFO @"http://tyrantkemp.imwork.net:21848/imgServ/app/savealbuminfo"
#endif
