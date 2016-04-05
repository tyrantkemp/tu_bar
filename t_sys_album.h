//
//  t_sys_album.h
//  tu_bar
//  相册信息
//  Created by 肖准 on 16/3/26.
//  Copyright © 2016年 肖准. All rights reserved.
//

#import <Realm/Realm.h>

@interface t_sys_album : RLMObject
@property NSString* albumId;
@property NSString * albumName;
@property NSString*  holderImgId;

@property RLMArray<t_sys_img> * imgIds;
@end

// This protocol enables typed collections. i.e.:
// RLMArray<t_sys_album>
RLM_ARRAY_TYPE(t_sys_album)
