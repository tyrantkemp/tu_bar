//
//  t_sys_album.h
//  tu_bar
//  相册信息
//  Created by 肖准 on 16/3/26.
//  Copyright © 2016年 肖准. All rights reserved.
//

#import <Realm/Realm.h>

@interface t_sys_album : RLMObject
@property long albumId;
@property NSString * albumName;
@property NSString*  holderImgId;
@property NSString * imgIds;  //在服务器数据库中以“；”分隔符存在
@end

// This protocol enables typed collections. i.e.:
// RLMArray<t_sys_album>
RLM_ARRAY_TYPE(t_sys_album)
