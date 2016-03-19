//
//  photoAlbum.h
//  tu_bar
//
//  Created by 肖准 on 16/3/18.
//  Copyright © 2016年 肖准. All rights reserved.
//

#import <Realm/Realm.h>

@interface photoAlbum : RLMObject
@property NSString * albumName;
@property NSString* holderImg;
@property NSString* imgIds;
@end
// This protocol enables typed collections. i.e.:
// RLMArray<photoAlbum>
RLM_ARRAY_TYPE(photoAlbum)
