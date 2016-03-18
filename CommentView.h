//
//  CommentView.h
//  tu_bar
//  回复中插入别人的评论
//  Created by 肖准 on 15/10/21.
//  Copyright © 2015年 肖准. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "MODcomments.h"
@class CommentView;
@protocol CommentViewDelegate<NSObject>
-(void)commentViewHeightChanged:(CommentView*)view newFrame:(CGRect)frame;
@end

@interface CommentView : UIView
@property(nonatomic,strong)id<CommentViewDelegate> delegate;
@property(nonatomic,strong)NSMutableArray* boundsarr;
@property(nonatomic,strong)NSMutableArray* comarr;
@property(nonatomic,assign)BOOL is_shrink;
+(instancetype)initwithOtherComments:(NSArray*)comar;

@end
