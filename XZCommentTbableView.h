//
//  XZCommentTbableView.h
//  tableview_test_1
//
//  Created by 肖准 on 15/10/26.
//  Copyright © 2015年 肖准. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "MOOtherComments.h"
#import "NSString+size.h"
#import "XZCommentCell.h"
#import "XZCommentHeaderview.h"
@class XZCommentTbableView;
@class XZCommentCell;
@protocol XZCommentTbableViewDelegate<NSObject>
-(void)XZCommentTbableViewCellIconTapped:(XZCommentTbableView*)view cell:(UIView*)cell tap:(UITapGestureRecognizer*)tap;
@end

@interface XZCommentTbableView : UIView<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
@property(nonatomic,strong)id<XZCommentTbableViewDelegate>delegate;
@property(nonatomic,strong)NSMutableArray<MOOtherComments>* comarr;
@property(nonatomic,strong)NSComment* comment;
@property(nonatomic,assign)CGFloat width;
@property(nonatomic,strong)UITableView* tableview;
@property(nonatomic,strong)NSMutableArray* heightarr;
@property(nonatomic,assign)CGFloat xzheight;
@property(nonatomic,strong)XZCommentHeaderview* headerview;
+(instancetype)gettableView:(CGFloat)width Data:(NSComment*)data;
-(CGFloat)getHeight;
@end
