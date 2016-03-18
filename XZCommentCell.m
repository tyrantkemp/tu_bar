//
//  XZCommentCell.m
//  tableview_test_1
//
//  Created by 肖准 on 15/10/26.
//  Copyright © 2015年 肖准. All rights reserved.
//

#import "XZCommentCell.h"

@implementation XZCommentCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.des=[[UILabel alloc]initWithFrame:CGRectMake(50, 0, self.frame.size.width-60, self.frame.size.height)];
        self.des.backgroundColor=[UIColor clearColor];
        self.des.lineBreakMode=NSLineBreakByWordWrapping;
        self.des.numberOfLines=0;
        
        [self.contentView addSubview:self.des];
        
    }
    return  self;
}


@end
