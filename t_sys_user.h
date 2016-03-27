//
//  t_sys_register_user.h
//  tu_bar
//  用户信息
//  Created by 肖准 on 16/3/26.
//  Copyright © 2016年 肖准. All rights reserved.
//

#import <Realm/Realm.h>


@interface t_sys_user : RLMObject
@property long userId;
@property NSString* mail;
@property NSString* username;
@property NSString* password;
@property NSData *  createtime;

@property NSString* iconImgId;  //头像图片id
@property NSString* bacgroundImgId;  //背景图片id

@property NSString* myAlbum; //我的相册，服务器端用albumId,以“；”分隔存储
@property BOOL delFlag;   //是否删除 1：删除 0：未删除

@end

// This protocol enables typed collections. i.e.:
// RLMArray<t_sys_register_user>
RLM_ARRAY_TYPE(t_sys_user)
