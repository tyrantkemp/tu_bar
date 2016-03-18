//
//  XZCommentTbableView.m
//  tableview_test_1
//
//  Created by 肖准 on 15/10/26.
//  Copyright © 2015年 肖准. All rights reserved.
//

#import "XZCommentTbableView.h"
#define FONT [UIFont systemFontOfSize:12 weight:.1]

@implementation XZCommentTbableView

+(instancetype)gettableView:(CGFloat)width Data:(NSComment*)data{
    return  [[self alloc]initWithArrAndWidth:width Data:data];
}
-(instancetype)initWithArrAndWidth:(CGFloat)width Data:(NSComment*)data{

    if(self=[super init]){
        self.comment=data;
        self.comarr=[data.othercomments mutableCopy];
        self.width=width;
       
        
        self.heightarr=[[NSMutableArray alloc]init];
        self.xzheight=.0;
        for (int i=0; i<self.comarr.count; ++i) {
            NSIndexPath* indexpath = [NSIndexPath indexPathForRow:i inSection:0];
            CGFloat h=[self tableView:self.tableview heightForRowAtIndexPath:indexpath];
            self.xzheight+=h;
            NSNumber* number = [NSNumber numberWithFloat:h];
            [self.heightarr addObject:number];
        }
        self.bounds=CGRectMake(0, 0, self.width, self.xzheight);
        self.tableview.frame=CGRectMake(0, 0, self.width, self.xzheight+self.headerview.frame.size.height);
        [self addSubview:self.tableview];
        
    }
    NSLog(@"height:%@",self.heightarr);
    return self;
}

-(UITableView*)tableview{
    if(_tableview==nil){
        _tableview =[[UITableView alloc]init];
        _tableview.dataSource=self;
        _tableview.delegate=self;
        _tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tableview.tableHeaderView=self.headerview;

    }
    return  _tableview;
    
}
-(UIView*)headerview{
    if(_headerview==nil){
        NSComment* comment = self.comment;
        CGSize size =[comment.des getStringSize:CGSizeMake(230, MAXFLOAT) font:[UIFont systemFontOfSize:12]];
        _headerview=[[XZCommentHeaderview alloc]initWithFrameAndModel:CGRectMake(0, 0, self.width, size.height+90) Model:comment];
        _headerview.backgroundColor=[UIColor clearColor];
        UITapGestureRecognizer* icontap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        [_headerview.icon addGestureRecognizer:icontap];
        
        UITapGestureRecognizer* nametap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        [_headerview.idname addGestureRecognizer:nametap];
        
        
        UITapGestureRecognizer* destap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        [_headerview.des addGestureRecognizer:destap];
    }
    return  _headerview;

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"count:%d",self.comarr.count);
    return  self.comarr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(self.heightarr.count==self.comarr.count){
        NSNumber* number = self.heightarr[indexPath.row];
        CGFloat h =[number floatValue];
        return  h;
    }
    NSString* str =nil;
    MOOtherComments* co = self.comarr[indexPath.row];
    if ([co.toid isEqualToString:@""]) {
        str=[NSString stringWithFormat:@"%@ : %@",co.idname,co.des];
    }else{
        str= [NSString stringWithFormat:@"%@:回复 %@ : %@",co.idname,co.toid,co.des];
    }
    CGSize size = [str getStringSize:CGSizeMake(self.width-60, MAXFLOAT) font:FONT];
    return  size.height+1+13;
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    XZCommentCell* cell=[tableView dequeueReusableCellWithIdentifier:@"XZCommentCell"];
    if(cell==nil){
        cell=[[XZCommentCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"XZCommentCell"];
        
        
        MOOtherComments* co=self.comarr[indexPath.row];
        NSString* str=nil;
        if ([co.toid isEqualToString:@""]) {
            str=[NSString stringWithFormat:@"%@ : %@",co.idname,co.des];
        }else{
            str= [NSString stringWithFormat:@"%@:回复 %@ : %@",co.idname,co.toid,co.des];
        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.userInteractionEnabled=YES;
        cell.des.text=str;
        cell.des.font=FONT;
        NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:str];
        NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle1 setLineSpacing:5];
        [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [str length])];
        [cell.des setAttributedText:attributedString1];
        [cell.des sizeToFit];
        cell.des.tag=CELL_DES;
        cell.des.userInteractionEnabled=YES;
        UITapGestureRecognizer* destap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        [cell.des addGestureRecognizer:destap];
        
        
        
        cell.selfMootherComment=co;
        cell.icon=[[UIImageView alloc]initWithImage:[UIImage imageNamed:co.iconurl]];
        cell.icon.frame=CGRectMake(20, 0, 25, 25);
        cell.icon.userInteractionEnabled=YES;
        cell.icon.tag=CELL_ICON;
        UITapGestureRecognizer* ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        [cell.icon addGestureRecognizer:ges];
        [cell.contentView addSubview:cell.icon];
        
        
        
        
        
        
        
        
    }
    
    return  cell;
}

-(void)tap:(UITapGestureRecognizer*)ges{
    NSLog(@"评论中的头像被点击,%d",ges.view.tag);
    [self XZCommentTbableViewCellIconTapped:self cell:ges.view tap:ges];
    
    
}
-(void)XZCommentTbableViewCellIconTapped:(XZCommentTbableView*)view cell:(UIView*)cell tap:(UITapGestureRecognizer*)tap{
    if([self.delegate respondsToSelector:@selector(XZCommentTbableViewCellIconTapped:cell:tap:)]){
        [self.delegate XZCommentTbableViewCellIconTapped:view cell:cell tap:tap ];
    }
    
}

-(CGFloat)getHeight{
    NSLog(@"当前评论总高度：%f",self.xzheight);
    return self.xzheight+self.headerview.frame.size.height;
}



@end

