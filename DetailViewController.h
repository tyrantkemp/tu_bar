//
//  DetailViewController.h
//  tu_bar
//
//  Created by 肖准 on 15/9/29.
//  Copyright (c) 2015年 肖准. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyboardView.h"
#import "UIImage+Resize.h"
#import "UIImage+autofit.h"
#import "TalkTableViewCell.h"
#import "MODcomments.h"
#import "CommentView.h"
#import "NSString+size.h"
#import "XZComAllCell.h"
#import "XZCommentCell.h"
#import "XZCommentTbableView.h"
#import "CommentDetailCTL.h"
#import "PersonDetailCtl.h"
#import "XZCommentHeaderview.h"

@interface DetailViewController : UIViewController
@property(nonatomic,strong)UIImageView* pic;
@property(nonatomic,assign)BOOL istapped;
@end
