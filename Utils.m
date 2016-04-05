//
//  Utils.m
//  Medical_Wisdom
//
//  Created by Mac on 14-1-26.
//  Copyright (c) 2014年 NanJingXianLang. All rights reserved.
//

#import "Utils.h"

#import "AppDelegate.h"

@implementation Utils

+(NSCache*)sharedCache{
    static NSCache * cache =nil;
    static dispatch_once_t predict;
    dispatch_once(&predict, ^{
        cache=[[NSCache alloc]init];
    });
    return  cache;
    
}
/*
 AppDelegate
 */
+ (AppDelegate *)applicationDelegate
{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}
#pragma mark - 展示主界面
+(void)showMain{
    
    UIStoryboard *stryBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    leftmenuTableViewController* left=[stryBoard instantiateViewControllerWithIdentifier:@"left"];
    mainViewController* ma=[stryBoard instantiateViewControllerWithIdentifier:@"tab"];
    ICSDrawerController *drawer = [[ICSDrawerController alloc] initWithLeftViewController:left
                                                            centerViewController:ma];

}
+ (UIImageView *)imageViewWithFrame:(CGRect)frame withImage:(UIImage *)image{
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image = image;
    return imageView ;
}

+ (UILabel *)labelWithFrame:(CGRect)frame withTitle:(NSString *)title titleFontSize:(UIFont *)font textColor:(UIColor *)color backgroundColor:(UIColor *)bgColor alignment:(NSTextAlignment)textAlignment{
    
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = title;
    label.font = font;
    label.textColor = color;
    label.backgroundColor = bgColor;
    label.textAlignment = textAlignment;
    return label ;
    
}


//alertView
+(UIAlertView *)alertTitle:(NSString *)title message:(NSString *)msg delegate:(id)aDeleagte cancelBtn:(NSString *)cancelName otherBtnName:(NSString *)otherbuttonName{
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:msg delegate:aDeleagte cancelButtonTitle:cancelName otherButtonTitles:otherbuttonName, nil];
    [alert show];
    return alert ;
}

+(UIButton *)createBtnWithType:(UIButtonType)btnType frame:(CGRect)btnFrame backgroundColor:(UIColor*)bgColor{
    UIButton *btn = [UIButton buttonWithType:btnType];
    btn.frame = btnFrame;
    [btn setBackgroundColor:bgColor];
    return btn;
}

//利用正则表达式验证邮箱的合法性
+(BOOL)isValidateEmail:(NSString *)email {
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
    
}

+(NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}
// 相册是否可用
+(BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypePhotoLibrary];
}


+(void)UserDefaultSetValue:(id)value forKey:(NSString*)key{
    NSUserDefaults* userdefault = [NSUserDefaults standardUserDefaults];
    
    [userdefault setValue:value forKey:key];
    [userdefault synchronize];
}

+(id)UserDefaultGetValueByKey:(NSString*)key{
    NSUserDefaults* userdefault = [NSUserDefaults standardUserDefaults];
    return [userdefault valueForKey:key];
}

+(BOOL)isVerified:(NSString*)username pwd:(NSString*)password{
    
    __block isPass = NO;
    
    AFHTTPSessionManager * managr = [AFHTTPSessionManager manager];
    [managr POST:VERIFY_URL parameters:@{@"password":password,@"username":username} progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
        NSString* result = (NSString*)responseObject;
        if([result isEqualToString:@"true"]){
            return YES;
        }else
            return NO;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"login error:%@",error);
        
        return  NO;
    }];
    
    
  
}
+(ICSDrawerController*)getICSDrawer{
    UIStoryboard *stryBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    leftmenuTableViewController* left=[stryBoard instantiateViewControllerWithIdentifier:@"left"];
    mainViewController* ma=[stryBoard instantiateViewControllerWithIdentifier:@"tab"];
    ICSDrawerController *drawer = [[ICSDrawerController alloc] initWithLeftViewController:left
                                                                     centerViewController:ma];
    
    return drawer;
}
+(void)setAutoLogin:(BOOL)isAutologin{
    [Utils UserDefaultSetValue:[NSNumber numberWithBool:isAutologin] forKey:USER_ISLOGIN];
}
#pragma mark 获得当期时间的字符串格式
+(NSString*)dateString{
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter =[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@" HH:mm:ss"];
    return [dateformatter stringFromDate:senddate];
    
}
+(CGFloat)getRandonFloat{
    return floorf(((double)arc4random() / ARC4RANDOM_MAX) * 100.0f);
}
#pragma mark - 上传图片
+(void)uploadImgToServerWithImageidAndUsername:(UIImage*)image withImageId:(NSString*)imgid{
    NSString* username =[Utils UserDefaultGetValueByKey:USER_NAME];
    
    dispatch_queue_t que=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(que , ^{
        ASIFormDataRequest *formDataRequest=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:UPLOAD_PICS_URL]];
        [formDataRequest  setPostValue:imgid forKey:@"imageid"];
        [formDataRequest setPostValue:username forKey:@"username"];
        NSData *postData=UIImageJPEGRepresentation(image, 1);
        if(postData==nil){
            NSLog(@"pic data为空！");
        }
        [formDataRequest addData:postData forKey:@"file"];
        [formDataRequest startSynchronous];
        NSLog(@"responce is %@",[formDataRequest responseString]);
    });
    
    
}
#pragma mark - 程序初始化时 根据username获取相册信息 
/*
 
 */
+(t_sys_album*)getAlbumInfoFromServerByUserName:(NSString*)username{

    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];

    [manager POST:URL_GETALBUMINFO parameters:@{@"username":username} progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        RLMRealm * realm = [RLMRealm defaultRealm];

        NSArray* albumarr = responseObject[@"albumarr"];
        
        NSPredicate* predicate = [NSPredicate predicateWithFormat:@"username = %@",username];
        t_sys_user * user = [t_sys_user objectsWhere:predicate];
        
        //服务器和本地都不存在相册信息
        if( (albumarr==nil || [albumarr count]==0) && (user.myAlbumIds==nil || user.myAlbumIds.length==0)){
            //创建默认相册信息
            t_sys_album * alb = [[t_sys_album alloc]init];
            alb.albumName = @"默认相册";
            alb.holderImgId = DEFAULT_IMG_ID;
            user.myAlbumIds=[user append:alb.albumId];
            //保存至本地数据库
            [realm transactionWithBlock:^{
                [t_sys_album createOrUpdateInRealm:realm withValue:alb];
                [t_sys_user createOrUpdateInRealm:realm withValue:user];
            }];
            
        }else if(){ //服务器存在，本地不存在 ，同步到本地
            
            
            
        }else if(){ //本地存在，服务器不存在，同步到服务器
            
            
        }else{ // 本地存在，服务器也存在，进行差异同步
            dispatch_async(dispatch_get_main_queue(), ^{
                RLMRealm * realm = [RLMRealm defaultRealm];
                [realm beginWriteTransaction];
                NSArray* arr = [t_sys_album createOrUpdateInRealm:realm withJSONArray:albumarr];
                [realm commitWriteTransaction];
                NSLog(@"下载的相册信息：%@",arr);
                
            });
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}
#pragma mark 上传更新相册信息
+(void)uploadAlbumInfo:(AlbumArr*)arr user:(NSString*)username{
    NSLog(@"上传更新相册信息 用户：%@",username);
    NSString* jsonstr = [arr toJSONString];
    ASIFormDataRequest* req = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:URL_UPLOADALBUMINFO]];
    [req setPostValue:jsonstr forKey:@"albuminfo"];
    [req setPostValue:username forKey:@"username"];
    [req startAsynchronous];
}
#pragma mark 从jsonstr转化得到albumarr对象
+(AlbumArr*)getAlbumarrFromString:(NSString*)jsonstr{
    NSAssert(jsonstr!=nil,@"jsonstr不能为空");
    NSError* err = nil;
    AlbumArr* arr = [[AlbumArr alloc]initWithString:jsonstr usingEncoding:NSUTF8StringEncoding error:&err];
    if(err) {
        NSLog(@"从string到albumarr出现错误:%@",[err localizedDescription]);
        return  nil;
    }else {
        return  arr;
    }
}
#pragma  mark 保存修改的相册信息并上传至服务器
+(void)saveAlbumarr:(AlbumArr*)arr{
    NSString* jsonstr = [arr toJSONString];
    [Utils UserDefaultSetValue:jsonstr forKey:USER_ALBUMS];
    [Utils uploadAlbumInfo:arr user:[Utils UserDefaultGetValueByKey:USER_NAME]];
    
}
#pragma mark 相册名是否重复
+(BOOL)albumNameIsRepeat:(NSString*)albumname{
    
    NSMutableArray* namearr = [[NSMutableArray alloc]init];
    AlbumArr* ar  = [[AlbumArr alloc]initWithString:[Utils UserDefaultGetValueByKey:USER_ALBUMS] error:nil];
    
    __block BOOL isrepeat = NO;
    [ar.albarr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        Album* alb = (Album*)obj;
        if([alb.albumname isEqualToString:albumname]){
            isrepeat=YES;
        }
    }];
    
    return  isrepeat;
    
    
}
#pragma mark 将指定imgid保存至指定相册中
+(void)saveImgIdtoAlbum:(NSString*)imgid albumname:(NSString*)albumname{
    
    AlbumArr* albumArr=[Utils getAlbumarrFromString:[Utils UserDefaultGetValueByKey:USER_ALBUMS]];
    NSMutableArray* arr =  albumArr.albarr;
    
    
    NSMutableString* imgidstr = [[NSMutableString alloc]init];
    for (int i= 0; i<arr.count; ++i) {
        Album * al = (Album*)arr[i];
        if([al.albumname isEqualToString:albumname]){
            NSString* tmep  = al.imgids;
            
            [al.imgids isEqualToString:@""]?([imgidstr appendString:imgid]):([imgidstr appendString:[NSString stringWithFormat:@"%@&%@",al.imgids,imgid]]);
            NSLog(@"imgidstr:%@",imgidstr);
            al.imgids = imgidstr;
            arr[i] = al;
        }
    }
    //    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    //        Album * alb  = (Album*)obj;
    //        if([alb.albumname isEqualToString:albumname]){
    //            [((Album*)arr[idx]).imgids addObject:im];
    //
    //        }
    //
    //    }];
    albumArr.albarr = arr;
    [Utils saveAlbumarr:albumArr];
    
    
}
#pragma mark - 写入本地图片信息 img.plist
+(void)writeToimgPlist:(NSString*)imgid imgLocalUrl:(NSString*)localurl imgUrl:(NSString*)url{
    
    
    NSAssert(imgid!=nil, @"imgid不能为空!");
    
    //格式化
    NSString *tmplocalurl = [[NSString alloc] initWithFormat:@"%@",localurl==nil?@"":localurl];
    NSString* tempurl = [[NSString alloc]initWithFormat:@"%@",url==nil?@"":url];
    
    // NSLog(@"localurl:%@",tmplocalurl);
    //获取路径对象
    NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    //获取完整路径
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSLog(@"%@",documentsDirectory);
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"img.plist"];
    
    NSMutableDictionary *dictplist = nil;
    NSFileManager* fm = [NSFileManager defaultManager];
    if(![fm fileExistsAtPath:plistPath]){
        dictplist = [[NSMutableDictionary alloc ] init];
        
    }else{
        dictplist = [[NSMutableDictionary alloc]initWithContentsOfFile:plistPath];
    }
    
    //定义第一个插件的属性
    NSMutableDictionary *plugin1 = [[NSMutableDictionary alloc]init];
    [plugin1 setValue:tmplocalurl forKey:@"localurl"];
    [plugin1 setValue:tempurl forKey:@"url"];
    
    NSDate* now= [NSDate date];
    NSDateFormatter* matter = [[NSDateFormatter alloc]init];
    [matter setDateFormat:@"YYYY年MM月dd号&HH:mm:ss"];
    NSString* nowstr = [matter stringFromDate:now];
    
    //只使用首次分布的时间
    if(![dictplist objectForKey:imgid]){
        [plugin1 setValue:nowstr forKey:@"time"];
    }
    
    [dictplist setObject:plugin1 forKey:imgid];
    //写入文件
    if(![dictplist writeToFile:plistPath atomically:YES]){
        NSLog(@"写入失败");
    }else {
        NSLog(@"写入成功");
    }
    
}
+(NSMutableDictionary*)getImgInfofromPlist{
    //获取路径对象
    NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    //获取完整路径
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSLog(@"%@",documentsDirectory);
    NSString *plistPath = [documentsDirectory stringByAppendingPathComponent:@"img.plist"];
    
    NSMutableDictionary *dictplist = nil;
    NSFileManager* fm = [NSFileManager defaultManager];
    if(![fm fileExistsAtPath:plistPath]){
        return nil;
    }else{
        dictplist = [[NSMutableDictionary alloc]initWithContentsOfFile:plistPath];
    }
    return  dictplist;
    
}
#pragma mark 根据imgid获得uiimage
+(UIImage*)getImageByimageId:(NSString*)imgid{
    
    NSMutableDictionary* dict = [Utils getImgInfofromPlist];
    NSDictionary* sundic= [dict objectForKey:imgid];
    NSURL* url =[NSURL URLWithString:[sundic objectForKey:@"localurl"]];
    ALAssetsLibrary  *lib = [[ALAssetsLibrary alloc] init];
    __block UIImage *img =nil;
    //先创建一个semaphore
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    dispatch_queue_t queue = dispatch_queue_create("get_album", NULL);
    dispatch_async(queue, ^(void) {
        [lib assetForURL:url resultBlock:^(ALAsset *asset)
         {
             // 使用asset来获取本地图片
             ALAssetRepresentation *assetRep = [asset defaultRepresentation];
             CGImageRef imgRef = [assetRep fullResolutionImage];
             img = [UIImage imageWithCGImage:imgRef
                                       scale:assetRep.scale
                                 orientation:(UIImageOrientation)assetRep.orientation];
             //             if (nil == img) {// 使用默认图片
             //                 if (nil == defaultImageName) {
             //                     return;
             //                 }
             //
             //                 [aPerson updateAvaterImageOfPerson: aPerson assetUrlString: aPerson.nameOfdefaultImg defaultImageName:nil];
             //
             //             }
             
             NSLog(@"读取完成:%@",img);
             //发出已完成的信号
             dispatch_semaphore_signal(semaphore);
             
         }
            failureBlock:^(NSError *error)
         {
             // 访问库文件被拒绝,则直接使用默认图片
             //             if (nil == aPerson.avatarImage) {// 使用默认图片
             //                 if (nil == defaultImageName) {
             //                     return;
             //                 }
             //
             //                 [aPerson updateAvaterImageOfPerson: aPerson assetUrlString: aPerson.nameOfdefaultImg defaultImageName:nil];
             
             NSLog(@"读取失败");
             //发出已完成的信号
             dispatch_semaphore_signal(semaphore);
             
         }];
        
    });
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
    
    return img;
    
    
}
#pragma mark - 生成图片id
+(NSString*)getImgid:(NSString*)imgurl{
    NSAssert(imgurl!=nil, @"imgurl不能为空");
    NSString* url=[NSString stringWithFormat:@"%@",imgurl];
    NSString* username = [Utils UserDefaultGetValueByKey:USER_NAME];
    NSString* imgid =[NSString stringWithFormat:@"%@%@%f",username,url,[Utils getRandonFloat]];
    
    return [Utils md5:imgid];
    
}

#pragma mark - 在手机相册中创建相册
+(void)createAlbumInPhoneAlbumwithName:(NSString*)name
{
    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
    NSMutableArray *groups=[[NSMutableArray alloc]init];
    ALAssetsLibraryGroupsEnumerationResultsBlock listGroupBlock = ^(ALAssetsGroup *group, BOOL *stop)
    {
        if (group)
        {
            [groups addObject:group];
        }
        
        else
        {
            BOOL haveHDRGroup = NO;
            
            for (ALAssetsGroup *gp in groups)
            {
                NSString *name =[gp valueForProperty:ALAssetsGroupPropertyName];
                
                if ([name isEqualToString:name])
                {
                    haveHDRGroup = YES;
                }
            }
            
            if (!haveHDRGroup)
            {
                //do add a group named "XXXX"
                [assetsLibrary addAssetsGroupAlbumWithName:name
                                               resultBlock:^(ALAssetsGroup *group)
                 {
                     [groups addObject:group];
                     
                 }
                                              failureBlock:nil];
                haveHDRGroup = YES;
            }
        }
        
    };
    //创建相簿
    [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAlbum usingBlock:listGroupBlock failureBlock:nil];
}

//
+(void)saveImgtoAlbum:(UIImage*)img com:(void (^)(NSURL* url))complete{
    
    [Utils saveToAlbumWithMetadata:nil imageData:UIImagePNGRepresentation(img) customAlbumName:@"图吧相册" completionBlock:^(NSURL* url)
     {
         NSLog(@"本地存储成功 :%@",url);
         if (complete) {
             NSLog(@"完成%@");
             complete(url);
         }
     }
                      failureBlock:^(NSError *error)
     {
         //处理添加失败的方法显示alert让它回到主线程执行
         dispatch_async(dispatch_get_main_queue(), ^{
             //添加失败一般是由用户不允许应用访问相册造成的，这边可以取出这种情况加以判断一下
             if([error.localizedDescription rangeOfString:@"User denied access"].location != NSNotFound ||[error.localizedDescription rangeOfString:@"用户拒绝访问"].location!=NSNotFound){
                 
                 UIAlertView *alert=[[UIAlertView alloc]initWithTitle:error.localizedDescription message:error.localizedFailureReason delegate:nil cancelButtonTitle:NSLocalizedString(@"ok", nil) otherButtonTitles: nil];
                 [alert show];
             }
         });
     }];
    
    
    
}

+(void)saveToAlbumWithMetadata:(NSDictionary *)metadata
                     imageData:(NSData *)imageData
               customAlbumName:(NSString *)customAlbumName
               completionBlock:(void (^)(NSURL* url))completionBlock
                  failureBlock:(void (^)(NSError *error))failureBlock
{
    
    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
    void (^AddAsset)(ALAssetsLibrary *, NSURL *) = ^(ALAssetsLibrary *assetsLibrary, NSURL *assetURL) {
        [assetsLibrary assetForURL:assetURL resultBlock:^(ALAsset *asset) {
            [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                
                if ([[group valueForProperty:ALAssetsGroupPropertyName] isEqualToString:customAlbumName]) {
                    [group addAsset:asset];
                    if (completionBlock) {
                        completionBlock(assetURL);
                    }
                }
            } failureBlock:^(NSError *error) {
                if (failureBlock) {
                    failureBlock(error);
                }
            }];
        } failureBlock:^(NSError *error) {
            if (failureBlock) {
                failureBlock(error);
            }
        }];
    };
    [assetsLibrary writeImageDataToSavedPhotosAlbum:imageData metadata:metadata completionBlock:^(NSURL *assetURL, NSError *error) {
        if (customAlbumName) {
            [assetsLibrary addAssetsGroupAlbumWithName:customAlbumName resultBlock:^(ALAssetsGroup *group) {
                if (group) {
                    [assetsLibrary assetForURL:assetURL resultBlock:^(ALAsset *asset) {
                        [group addAsset:asset];
                        if (completionBlock) {
                            completionBlock(assetURL);
                        }
                    } failureBlock:^(NSError *error) {
                        if (failureBlock) {
                            failureBlock(error);
                        }
                    }];
                } else {
                    AddAsset(assetsLibrary, assetURL);
                }
            } failureBlock:^(NSError *error) {
                AddAsset(assetsLibrary, assetURL);
            }];
        } else {
            if (completionBlock) {
                completionBlock(assetURL);
            }
        }
    }];
}


#pragma mark - 获取/创建(默认)个人相册集合
+(photoAlbumArr*)getDefaultAlbumArrs
{
    photoAlbumArr * arr = [photoAlbumArr objectsWhere:@"userid = 'default'"];
    if(arr==nil){
        arr = [[photoAlbumArr alloc]init];
        photoAlbum * album = [photoAlbum objectsWhere:@"albumname ='默认相册'"];
        if(album==nil){
            album = [[Album alloc]init];
            album.holderImg = @"44A3762B66A4B5F1BB51533A00B96114";
            album.albumName=@"默认相册";
            RLMRealm *realm = [RLMRealm defaultRealm];
            [[realm transactionWithBlock:^{
                [realm addObject:album];
            }];
             
             }
             arr.ueserId = "default";
             [arr.albumArrs addObject:album];
             RLMRealm *realm = [RLMRealm defaultRealm];
             [realm transactionWithBlock:^{
                [realm addObject:arr];
            }];
             }
             
             return arr;
             
             }



#pragma mark 覆盖隐藏tableview多余横线
+(void)setExtraCellLineHidden:(UITableView*)tableview
            {
    UIView * view = [[UIView alloc]init];
    [view setBackgroundColor:[UIColor clearColor]];
    [tableview setTableFooterView:view];
    //[tableview setTableHeaderView:view];
}

@end
