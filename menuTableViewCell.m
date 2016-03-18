//
//  menuTableViewCell.m
//  tu_bar
//
//  Created by 肖准 on 15/9/28.
//  Copyright (c) 2015年 肖准. All rights reserved.
//

#import "menuTableViewCell.h"

@implementation menuTableViewCell

- (void)awakeFromNib {
    // Initialization code
 
    
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.menuicon=[[UIImageView alloc]initWithFrame:CGRectMake(4, 3, 32, 32)];
        self.menuname=[[UILabel alloc]initWithFrame:CGRectMake(40, 3, 100, 32)];
        self.menuname.font=[UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.menuicon];
        self.menuname.textColor=[UIColor colorWithWhite:0.695 alpha:1.000];
        self.backgroundView=nil;
        self.backgroundView=[[UIView alloc]initWithFrame:CGRectMake(18,0,self.frame.size.width,self.frame.size.height)];
        self.backgroundView.backgroundColor=[UIColor clearColor];
        self.backgroundColor=[UIColor clearColor];
        
        
        self.menuname.highlightedTextColor=[UIColor whiteColor];
        
        
        //cell选中时的效果
        self.selectedBackgroundView=[[UIView alloc]initWithFrame:CGRectMake(18, 0, self.frame.size.width-100, self.frame.size.height)];
        self.selectedBackgroundView.backgroundColor=[UIColor darkGrayColor];
        
        [self.contentView addSubview:self.menuname];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
    // Configure the view for the selected state
}

@end
