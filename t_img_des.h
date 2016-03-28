//
//  t_sys_comment.h
//  tu_bar
//  图片评论
//  Created by 肖准 on 16/3/26.
//  Copyright © 2016年 肖准. All rights reserved.
//

#import <Realm/Realm.h>

@interface t_img_des : RLMObject
@property long imgId;
@property long authId;
@property NSInteger top; //点赞数
@property NSInteger down; //差评数
@property NSInteger commentNumber; //图片评论数
@property NSString * description; //图片评论

@end

// This protocol enables typed collections. i.e.:
// RLMArray<t_sys_comment>
RLM_ARRAY_TYPE(t_img_des)
