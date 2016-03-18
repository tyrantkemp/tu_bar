//
//  TalkTableViewCell.h
//  tu_bar
//
//  Created by 肖准 on 15/9/29.
//  Copyright (c) 2015年 肖准. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TalkTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *icon;
@property (strong, nonatomic) IBOutlet UILabel *idname;
@property (strong, nonatomic) IBOutlet UILabel *order;
@property (strong, nonatomic) IBOutlet UILabel *des;

@end
