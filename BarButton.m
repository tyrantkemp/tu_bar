//
//  BarButton.m
//  tu_bar
//
//  Created by 肖准 on 15/10/13.
//  Copyright © 2015年 肖准. All rights reserved.
//

#import "BarButton.h"

@implementation BarButton
-(instancetype)initWithFrameAndTile:(CGRect)frame title:(NSString*)title{
    if(self==[super initWithFrame:frame]){

        NSLog(@"barbtn:%@",NSStringFromCGRect(frame));
        self.backgroundColor=[UIColor clearColor];
        self.lab=[[UILabel alloc]init];
        self.lab.bounds=CGRectMake(0, 0, 40, 25);
        self.lab.center=CGPointMake(self.frame.size.width/2, self.center.y-10);
        self.lab.font=[UIFont systemFontOfSize:12];
        self.lab.textColor=[UIColor whiteColor];
        self.lab.textAlignment=NSTextAlignmentCenter;
        self.lab.text=@"0";
        
        self.title=[[UILabel alloc]init];
        self.title.bounds=CGRectMake(0, 0, 40, 25);
        self.title.center=CGPointMake(self.frame.size.width/2, self.center.y+10);
        self.title.font=[UIFont systemFontOfSize:12];
        self.title.textColor=[UIColor whiteColor];
        self.title.textAlignment=NSTextAlignmentCenter;
        self.title.text=title;
        [self addSubview:self.lab];
        [self addSubview:self.title];
    }
    return  self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
