//
//  XZCommentHeaderview.h
//  tableview_test_1
//
//  Created by 肖准 on 15/10/26.
//  Copyright © 2015年 肖准. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSComment.h"
#import "NSString+size.h"

@interface XZCommentHeaderview : UIView
@property(strong,nonatomic)UIImageView* icon;
@property(nonatomic,strong)UILabel* idname;
@property(nonatomic,strong)UILabel* number;
@property(nonatomic,strong)UIButton* up;
@property(nonatomic,strong)UILabel* des;
@property(nonatomic,strong)UILabel* upnumber;
@property(nonatomic,assign)NSInteger upN;
@property(nonatomic,strong)NSComment* selfNSComment;
-(instancetype)initWithFrameAndModel:(CGRect)frame Model:(NSComment*)model;
@end
