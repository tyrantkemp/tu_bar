//
//  t_img_comment_sub.h
//  tu_bar
//  每个图片下的子评论
//  Created by 肖准 on 16/3/26.
//  Copyright © 2016年 肖准. All rights reserved.
//

#import <Realm/Realm.h>

@interface t_img_comment_sub : RLMObject
@property long userId;
@property NSString* des ;
@property NSDate* date;
@property RLMArray<t_img_comment_sub>* subComments;  //可能会有对子评论的评论
@property 
@end

// This protocol enables typed collections. i.e.:
// RLMArray<t_img_comment_sub>
RLM_ARRAY_TYPE(t_img_comment_sub)
