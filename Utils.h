

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import "ICSDrawerController.h"
#import "leftmenuTableViewController.h"
#import "mainViewController.h"
#import "UIImageView+WebCache.h"
#import "ASIHTTPRequestDelegate.h"
#import "photoAlbum.h"
#import "photoAlbumArr.h"

//#import "PTInfo.h"
//#import "PTInfoList.h"
/***************************************************************************
 *
 * 工具类
 *
 ***************************************************************************/

@class AppDelegate;
@class UserInfo;

@interface Utils : NSObject
@property(nonatomic,strong)NSCache* cache;      //缓存
+(NSCache*)sharedCache;

/*
 AppDelegate
 */

+(AppDelegate *)applicationDelegate;

+ (UIImageView *)imageViewWithFrame:(CGRect)frame withImage:(UIImage *)image;

+ (UILabel *)labelWithFrame:(CGRect)frame withTitle:(NSString *)title titleFontSize:(UIFont *)font textColor:(UIColor *)color backgroundColor:(UIColor *)bgColor alignment:(NSTextAlignment)textAlignment;

#pragma mark - UserDefault 公共操作
+(void)UserDefaultSetValue:(id)value forKey:(NSString*)key;
+(id)UserDefaultGetValueByKey:(NSString*)key;

#pragma mark - alertView提示框
+(UIAlertView *)alertTitle:(NSString *)title message:(NSString *)msg delegate:(id)aDeleagte cancelBtn:(NSString *)cancelName otherBtnName:(NSString *)otherbuttonName;
#pragma mark - btnCreate
+(UIButton *)createBtnWithType:(UIButtonType)btnType frame:(CGRect)btnFrame backgroundColor:(UIColor*)bgColor;

#pragma mark - 邮箱地址是否合法
+(BOOL)isValidateEmail:(NSString *)email;
#pragma mark -  返回加密后的md5字符串
+(NSString *)md5:(NSString *)str;

#pragma mark - 相册是否可用
+ (BOOL) isPhotoLibraryAvailable;
#pragma mark - 生成图片id
+(NSString*)getImgid:(NSString*)imgurl;

+(BOOL)isVerified:(NSString*)username pwd:(NSString*)password;


+(ICSDrawerController*)getICSDrawer;
+(void)setAutoLogin:(BOOL)isAutologin;

+(NSString*)dateString;

#pragma mark - 图片上传
+(void)uploadImgToServerWithImageidAndUsername:(UIImage*)image withImageId:(NSString*)imgid;


#pragma mark - 写入本地图片信息 img.plist
+(void)writeToimgPlist:(NSString*)imgid imgLocalUrl:(NSString*)localurl imgUrl:(NSString*)url;
+(NSMutableDictionary*)getImgInfofromPlist;
#pragma mark 根据imgid获得uiimage
+(UIImage*)getImageByimageId:(NSString*)imgid;
#pragma mark - 在手机相册中创建相册
+(void)createAlbumInPhoneAlbumwithName:(NSString*)name;
+(void)saveImgtoAlbum:(UIImage*)img com:(void (^)(NSURL* url))complete;
+ (void)saveToAlbumWithMetadata:(NSDictionary *)metadata
                      imageData:(NSData *)imageData
                customAlbumName:(NSString *)customAlbumName
                completionBlock:(void (^)(NSURL* url))completionBlock
                   failureBlock:(void (^)(NSError *error))failureBlock;

#pragma mark - 获取/创建(默认)个人相册集合
+(photoAlbumArr*)getDefaultAlbumArrs;

#pragma mark - 获取服务器当前用户的相册信息
+(NSString*)getAlbumInfoFromServerByUserName:(NSString*)username;

#pragma mark 上传更新相册信息
+(void)uploadAlbumInfo:(AlbumArr*)arr user:(NSString*)username;
#pragma mark 从jsonstr转化得到albumarr对象
+(AlbumArr*)getAlbumarrFromString:(NSString*)jsonstr;
#pragma  mark 保存修改的相册信息并上传至服务器
+(void)saveAlbumarr:(AlbumArr*)arr;

#pragma mark 相册名是否重复
+(BOOL)albumNameIsRepeat:(NSString*)albumname;


#pragma mark 将指定imgid保存至指定相册中
+(void)saveImgIdtoAlbum:(NSString*)imgid albumname:(NSString*)albumname;

#pragma mark 覆盖隐藏tableview多余横线
+(void)setExtraCellLineHidden:(UITableView*)tableview;

@end
