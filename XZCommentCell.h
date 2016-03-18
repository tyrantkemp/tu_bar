//
//  XZCommentCell.h
//  tableview_test_1
//
//  Created by 肖准 on 15/10/26.
//  Copyright © 2015年 肖准. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MOOtherComments.h"
@interface XZCommentCell : UITableViewCell
@property(nonatomic,strong)UIImageView* icon;
@property(nonatomic,strong)UILabel* des;
@property(nonatomic,strong)NSString* namestr;
@property(nonatomic,strong)MOOtherComments* selfMootherComment;
@end
