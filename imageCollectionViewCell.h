//
//  imageCollectionViewCell.h
//  tu_bar
//
//  Created by 肖准 on 15/9/29.
//  Copyright (c) 2015年 肖准. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface imageCollectionViewCell : UICollectionViewCell
@property(nonatomic,strong)UIImageView* pic;
@property(nonatomic,copy)NSString* picName;
@property(nonatomic,strong)UIView* bacview;
@property(nonatomic,strong)UILabel* countlb;
@property(nonatomic,strong)UIImageView* icon;

@end
