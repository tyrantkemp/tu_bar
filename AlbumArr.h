//
//  AlbumArr.h
//  tu_bar
//
//  Created by 肖准 on 15/11/27.
//  Copyright © 2015年 肖准. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Album.h"

@interface AlbumArr : JSONModel
@property(nonatomic,strong)NSMutableArray<Album >*  albarr;
@end
