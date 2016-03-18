//
//  XZCommentHeaderview.m
//  tableview_test_1
//
//  Created by 肖准 on 15/10/26.
//  Copyright © 2015年 肖准. All rights reserved.
//

#import "XZCommentHeaderview.h"
@implementation XZCommentHeaderview
-(instancetype)initWithFrameAndModel:(CGRect)frame Model:(NSComment*)model{
    if(self=[super initWithFrame:frame]){
        
        self.selfNSComment=model;
        self.upN=12;
        self.icon=[[UIImageView alloc]initWithImage:[UIImage imageNamed:model.url]];
        self.icon.layer.masksToBounds=YES;
        self.icon.frame=CGRectMake(5, 5, 40, 40);
        self.icon.layer.cornerRadius=self.icon.frame.size.width/2;
       
        self.icon.userInteractionEnabled=YES;
        self.icon.tag=HEADER_ICON;
        [self addSubview:self.icon];

        
        NSString* idnamestr=model.auther;
        self.idname=[[UILabel alloc]initWithFrame:CGRectMake(self.icon.frame.origin.x+self.icon.frame.size.width+5, 5, [idnamestr getStringSize:CGSizeMake(100, MAXFLOAT) font:[UIFont systemFontOfSize:12]].width+20, 30)];
        self.idname.textColor=[UIColor colorWithRed:1.000 green:0.500 blue:0.000 alpha:1.000];
        self.idname.text=idnamestr;
        self.idname.tag=HEADER_NAME;
       
        self.idname.userInteractionEnabled=YES;
        [self addSubview:self.idname];
        
        NSString* index=[NSString stringWithFormat:@"#%d",model.index];
        self.number=[[UILabel alloc]initWithFrame:CGRectMake(self.icon.frame.origin.x+self.icon.frame.size.width+5, 35, 30, 20)];
        self.number.textColor=[UIColor lightGrayColor];
        self.number.text=index;
        self.number.font=[UIFont systemFontOfSize:10];
    
        [self addSubview:self.number];
        
        NSString* des = model.des;

        NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:des];
        NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle1 setLineSpacing:5];
        [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [des length])];
        self.des=[[UILabel alloc]initWithFrame:CGRectMake(self.icon.frame.origin.x+self.icon.frame.size.width+5, 60, 230, [des getStringSize:CGSizeMake(230, MAXFLOAT) font:[UIFont systemFontOfSize:13 weight:11]].height)];
        self.des.text=des;
        self.des.numberOfLines=0;
        self.des.font=[UIFont systemFontOfSize:13 weight:11];
        [self.des setAttributedText:attributedString1];

 
        self.des.userInteractionEnabled=YES;
        self.des.tag=HEADER_DES;
        [self addSubview:self.des];
        
        if(model.othercomments.count!=0){
            UIView *view = [[UIView alloc]initWithFrame:CGRectMake(self.icon.frame.origin.x+self.icon.frame.size.width+5, 65+self.des.frame.size.height+10, frame.size.width-self.icon.frame.origin.x-self.icon.frame.size.width-15, .5)];
            view.backgroundColor=[UIColor grayColor];
            [self addSubview:view];
        }
        
        
        self.up=[UIButton buttonWithType:UIButtonTypeCustom];
        [self.up setImage:[UIImage imageNamed:@"like16.png"] forState:UIControlStateNormal];
        [self.up setImage:[UIImage imageNamed:@"like15.png"] forState:UIControlStateSelected];
        [self.up addTarget:self action:@selector(upbtn:) forControlEvents:UIControlEventTouchUpInside];
        NSLog(@"frame:%@",NSStringFromCGRect(frame));
        self.up.frame=CGRectMake(frame.size.width-80, 10, 40, 40);
        [self addSubview:self.up];
        
        self.upnumber.frame=CGRectMake(frame.size.width-40, 12, 30, 40);
        [self addSubview:self.upnumber];
        
        
    }
    return  self;
}
-(UILabel*)upnumber{
    if(_upnumber==nil){
        _upnumber=[[UILabel alloc]initWithFrame:CGRectZero];
        _upnumber.font=[UIFont systemFontOfSize:10];
        _upnumber.textColor=[UIColor lightGrayColor];
        _upnumber.text=[NSString stringWithFormat:@"%d",self.upN];
    }
    return  _upnumber;
}

//-(void)haedertap:(UITapGestureRecognizer*)tap{
//    
//    [self XZCommentHeaderViewTapped:self tap:tap];
//    
//    
//}
//
//-(void)XZCommentHeaderViewTapped:(XZCommentHeaderview*)view tap:(UITapGestureRecognizer*)tap{
//    if([self.delegate respondsToSelector:@selector(XZCommentHeaderViewTapped:tap:)]){
//        [self.delegate XZCommentHeaderViewTapped:view tap:tap];
//    }
//}
//

-(void)upbtn:(UIButton*)btn{
    NSLog(@"btn pressed");
    if(!btn.selected){
        self.upN+=1;
        self.upnumber.text = [NSString stringWithFormat:@"%d",self.upN];
        [self.upnumber reloadInputViews];
        btn.selected=YES;
    }else{
        btn.selected=NO;
    }
}

@end
