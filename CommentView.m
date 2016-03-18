//
//  CommentView.m
//  tu_bar
//
//  Created by 肖准 on 15/10/21.
//  Copyright © 2015年 肖准. All rights reserved.
//

#import "CommentView.h"
#define WI 240

#define HEI_NAME 30
#define HEI_INTER 4


@implementation CommentView

+(instancetype)initwithOtherComments:(NSArray*)comar{
    return [[self alloc]initWithArr:comar];
}
-(instancetype)initWithArr:(NSArray*)comarr{
    if(self==[super init]){
        self.comarr=[comarr mutableCopy];
        self.is_shrink=comarr.count>4?YES:NO;
        [self layoutSubviews];
    }
    return  self;
    
}
-(void)shrink:(UIButton*)btn{
    self.is_shrink=NO;
    
    
    [self layoutSubviews];
    
    if([self.delegate respondsToSelector:@selector(commentViewHeightChanged:newFrame:)]){
        [self.delegate commentViewHeightChanged:self newFrame:self.frame];
    }
    
}

-(void)layoutSubviews{
    
    NSInteger row=self.comarr.count;
    CGFloat hei= .0;
    NSMutableArray* heiarr=[[NSMutableArray alloc  ]init];
    if(self.is_shrink){
        for(int i =0 ;i<4;++i){
            NSString *str = ((MOOtherComments*)self.comarr[i]).des;
            NSLog(@"%@",str);
            NSDictionary* attr = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
            CGRect rect =CGRectZero;
            
            NSInteger num = (row-i)>3?4:(row-i);
//            
//            if(i==2){
//                str= @"";
//            }
            rect =[str boundingRectWithSize:CGSizeMake(WI-num*HEI_INTER*2, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil];
            NSLog(@"rect:%@",NSStringFromCGRect(rect));
            NSValue* valuerect = [NSValue valueWithCGRect:rect];
            [heiarr addObject:valuerect];
            hei+=rect.size.height+HEI_NAME+HEI_INTER*2;
        }
        
        self.backgroundColor=[UIColor colorWithRed:0.549 green:0.619 blue:0.902 alpha:1.000];
        
        hei+=((row-1)>3?3:(row-1))*HEI_INTER;
        
        self.bounds = CGRectMake(0, 0, WI, hei);
        
        
        for (int i =0; i<4; i++) {
            UIView* view = [[UIView alloc]init];
            CGRect rect = [heiarr[3-i] CGRectValue];
            view.frame=UIEdgeInsetsInsetRect(self.bounds, UIEdgeInsetsMake(HEI_INTER*i, HEI_INTER*i,(rect.size.height+HEI_NAME+HEI_INTER*2)*i, HEI_INTER*i));
            view.backgroundColor=[UIColor colorWithRed:0.961 green:0.965 blue:0.870 alpha:1.000];
            view.layer.borderColor=[UIColor colorWithRed:0.033 green:0.009 blue:0.004 alpha:0.621].CGColor;
            view.layer.borderWidth=.5;
            
            UIView * bac=[[UIView alloc]init];
            bac.frame = CGRectMake(2,view.frame.size.height-HEI_INTER-rect.size.height-HEI_NAME,view.frame.size.width-4,rect.size.height+HEI_NAME);
            bac.backgroundColor=[UIColor clearColor];
            UILabel* name = [[UILabel alloc]init];
            name.text=((MOOtherComments*)self.comarr[3-i]).idname;
            name.font=[UIFont boldSystemFontOfSize:12];
            name.textColor=[UIColor colorWithRed:0.232 green:0.639 blue:0.898 alpha:1.000];
            name.frame=CGRectMake(3, 3, 40, 20);
            UILabel* des= [[UILabel alloc]init];
            NSString *str = ((MOOtherComments*)self.comarr[3-i]).des;
            des.text=str;
            des.numberOfLines=0;
            des.font=[UIFont systemFontOfSize:12];
            des.frame=CGRectMake(3, 25, rect.size.width, rect.size.height);
            if(i==1){
                UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
                [btn setTitle:@"点击下拉" forState:UIControlStateNormal];
                [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(shrink:) forControlEvents:UIControlEventTouchUpInside];
                btn.bounds =CGRectMake(0, 0, 100, 30);
                btn.center = CGPointMake(bac.frame.size.width/2, bac.frame.size.height/2);
                [bac addSubview:btn];
            }else{
                [bac addSubview:name];
                [bac addSubview:des];
            }
            [view addSubview:bac];
            [self addSubview:view];
        }
    }else{
        
        for(int i =0 ;i<row;++i){
            NSString *str = ((MOOtherComments*)self.comarr[i]).des;
            NSLog(@"%@",str);
            NSDictionary* attr = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
            CGRect rect =CGRectZero;
            NSInteger num = (row-i)>3?4:(row-i);
            rect =[str boundingRectWithSize:CGSizeMake(WI-num*HEI_INTER*2, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil];
            
            NSValue* valuerect = [NSValue valueWithCGRect:rect];
            [heiarr addObject:valuerect];
            hei+=rect.size.height+HEI_NAME+HEI_INTER*2;
        }
        
        self.backgroundColor=[UIColor colorWithRed:0.549 green:0.619 blue:0.902 alpha:1.000];
        hei+=((row-1)>3?3:(row-1))*HEI_INTER;
        self.bounds = CGRectMake(0, 0, WI, hei);
        for (int i =0; i<row; i++) {
            UIView* view = [[UIView alloc]init];
            CGRect rect = [heiarr[row-1-i] CGRectValue];
            view.frame=UIEdgeInsetsInsetRect(self.bounds, UIEdgeInsetsMake(HEI_INTER*(i>3?3:i), HEI_INTER*(i>3?3:i),(rect.size.height+HEI_NAME+HEI_INTER*2)*i, HEI_INTER*(i>3?3:i)));
            view.backgroundColor=[UIColor colorWithRed:0.961 green:0.965 blue:0.870 alpha:1.000];
            view.layer.borderColor=[UIColor colorWithRed:0.033 green:0.009 blue:0.004 alpha:0.621].CGColor;
            view.layer.borderWidth=.5;
            UIView * bac=[[UIView alloc]init];
            bac.frame = CGRectMake(2,view.frame.size.height-HEI_INTER-rect.size.height-HEI_NAME,view.frame.size.width-4,rect.size.height+HEI_NAME);
            bac.backgroundColor=[UIColor clearColor];
            UILabel* name = [[UILabel alloc]init];
            name.text=((MOOtherComments*)self.comarr[row-i-1]).idname;
            name.font=[UIFont boldSystemFontOfSize:12];
            name.textColor=[UIColor colorWithRed:0.232 green:0.639 blue:0.898 alpha:1.000];
            name.frame=CGRectMake(3, 3, 40, 20);
            UILabel* des= [[UILabel alloc]init];
            NSString *str = ((MOOtherComments*)self.comarr[row-1-i]).des;
            des.text=str;
            des.numberOfLines=0;
            des.font=[UIFont systemFontOfSize:12];
            des.frame=CGRectMake(3, 25, rect.size.width, rect.size.height);
            [bac addSubview:name];
            [bac addSubview:des];
            [view addSubview:bac];
            [self addSubview:view];
        }
    }
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
