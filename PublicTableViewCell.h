//
//  PublicTableViewCell.h
//  tu_bar
//
//  Created by 肖准 on 15/11/24.
//  Copyright © 2015年 肖准. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MODcomments.h"
@interface PublicTableViewCell : UITableViewCell
@property(nonatomic,strong)UIView* bacview;
@property(nonatomic,strong)UIView* tabview;
@property(nonatomic,strong)UIImageView* imview;
@property(nonatomic,strong)UILabel* top;
@property(nonatomic,strong)UILabel* down;
@property(nonatomic,strong)UILabel* talk;
@property(nonatomic,strong)MODcomments* doc;

-(instancetype)initWithStyleandInfo:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier info:(MODcomments*)doc Image:(UIImage*)img;
@end

