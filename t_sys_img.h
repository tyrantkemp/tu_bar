//
//  t_sys_img.h
//  tu_bar
//
//  Created by 肖准 on 16/3/30.
//  Copyright © 2016年 肖准. All rights reserved.
//

#import <Realm/Realm.h>

@interface t_sys_img : RLMObject
@property NSString * imgId;
@end

// This protocol enables typed collections. i.e.:
// RLMArray<t_sys_img>
RLM_ARRAY_TYPE(t_sys_img)
