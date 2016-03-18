//
//  AlbumCell.h
//  tu_bar
//
//  Created by 肖准 on 15/11/28.
//  Copyright © 2015年 肖准. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Album.h"
#import "QCheckBox.h"
@interface AlbumCell : UITableViewCell
@property(nonatomic,strong)UIImageView* icon;
@property(nonatomic,strong)UILabel* albumname;
@property(nonatomic,strong)UILabel* albunmnumber;
@property(nonatomic,strong)QCheckBox* checkbox;
-(instancetype)initWithStyleAndAlbumInfo:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier album:(Album*)al;
@end
