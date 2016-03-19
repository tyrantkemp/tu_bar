//
//  photoAlbumArr.h
//  tu_bar
//
//  Created by 肖准 on 16/3/18.
//  Copyright © 2016年 肖准. All rights reserved.
//

#import <Realm/Realm.h>
#import "photoAlbum.h"
@interface photoAlbumArr : RLMObject
@property RLMArray<photoAlbum> albumArrs;
@end

// This protocol enables typed collections. i.e.:
// RLMArray<photoAlbumArr>
