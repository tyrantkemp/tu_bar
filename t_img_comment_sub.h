//
//  t_img_comment_sub.h
//  tu_bar
//
//  Created by 肖准 on 16/3/26.
//  Copyright © 2016年 肖准. All rights reserved.
//

#import <Realm/Realm.h>

@interface t_img_comment_sub : RLMObject
<# Add properties here to define the model #>
@end

// This protocol enables typed collections. i.e.:
// RLMArray<t_img_comment_sub>
RLM_ARRAY_TYPE(t_img_comment_sub)
