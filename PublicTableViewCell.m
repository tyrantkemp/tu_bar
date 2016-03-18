//
//  PublicTableViewCell.m
//  tu_bar
//
//  Created by 肖准 on 15/11/24.
//  Copyright © 2015年 肖准. All rights reserved.
//

#import "PublicTableViewCell.h"

@implementation PublicTableViewCell

-(instancetype)initWithStyleandInfo:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier info:(MODcomments*)doc Image:(UIImage*)img{
    if(self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        NSLog(@"%@",doc);
        self.bacview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, 150)];
        self.imview=[[UIImageView alloc]initWithImage:img];
        self.imview.frame=CGRectMake(0, 0, self.bacview.width, self.bacview.height);
        [self.bacview addSubview:self.imview];
        
        self.tabview=[[UIView alloc]initWithFrame:CGRectMake(0, 120, self.width, 30)];
        self.tabview.backgroundColor=[UIColor colorWithRed:0.907 green:0.972 blue:0.971 alpha:0.508];
        UIImageView* topicon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"heart_full.png"]];
        
        topicon.frame=CGRectMake(10, 5, 20, 20);
        self.top = [[UILabel alloc]initWithFrame:CGRectMake(35, 5, 50, 20)];
        self.top.font=[UIFont systemFontOfSize:11];
        self.top.text=[NSString stringWithFormat:@"%d",doc.top];
        [self.tabview addSubview:topicon];
        [self.tabview addSubview:self.top];
        
        
         UIImageView* downicon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shit_full.png"]];
        downicon.frame= CGRectMake(self.top.origin.x+self.top.width+10, 5, 20, 20);
        self.down = [[UILabel alloc]initWithFrame:CGRectMake(downicon.origin.x+downicon.width+5, 5, 50, 20)];
        self.down.font=[UIFont systemFontOfSize:11];
        self.down.text=[NSString stringWithFormat:@"%d",doc.down];
        [self.tabview addSubview:downicon];
        [self.tabview addSubview:self.down];
        
        
        UIImageView* talkicon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"chat.png"]];
        talkicon.frame= CGRectMake(self.down.origin.x+self.down.width+10, 5, 20, 20);
        self.talk = [[UILabel alloc]initWithFrame:CGRectMake(talkicon.origin.x+talkicon.width+5, 5, 50, 20)];
        self.talk.font=[UIFont systemFontOfSize:11];
        
        NSInteger num1= doc.comments.count;
    
        NSInteger numtotal= num1;
        for (int i =0; i<num1; ++i) {
            NSComment* co=(NSComment*)(doc.comments[i]);
            numtotal+=co.othercomments.count;
        }
        
        
        self.talk.text=[NSString stringWithFormat:@"%d",num1];
        [self.tabview addSubview:talkicon];
        [self.tabview addSubview:self.talk];
    
        
        
        [self.contentView addSubview:self.bacview];
        [self.contentView addSubview:self.tabview];
        
        
        
        
        
    }
    return self;
}





- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
