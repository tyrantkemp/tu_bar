//
//  KeyboardView.m
//  XZLogin
//
//  Created by 肖准 on 15/9/14.
//  Copyright (c) 2015年 肖准. All rights reserved.
//

#import "KeyboardView.h"
@interface KeyboardView()<UITextFieldDelegate>
@property(nonatomic,strong )UIImageView* backImageView;
@property(nonatomic,strong)UIButton* voiceBtn;
@property(nonatomic,strong)UIButton* iamgeBtn;
@property(nonatomic,strong)UIButton* addBtn;
@property(nonatomic,strong)UIButton* speakBtn;
@end

@implementation KeyboardView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



-(id)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if(self){
        [self initialData];
        
    }
    return self;
}

-(UIButton*)buttonWith:(NSString*)normal hightlight:(NSString*)highlight action:(SEL)aciton{
    UIButton* btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:normal] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highlight] forState:UIControlStateSelected];
    [btn addTarget:self action:aciton forControlEvents:UIControlEventTouchUpInside];
    return  btn;
}

-(void)initialData{
    self.backImageView = [[UIImageView alloc]initWithFrame:self.bounds];
    UIImage *image = [UIImage imageNamed:@"toolbar_bottom_bar.png"];
    image=[image stretchableImageWithLeftCapWidth:image.size.width*0.5 topCapHeight:image.size.height*0.5];
    self.backImageView.image =image;
    [self addSubview:self.backImageView];
   
//    self.voiceBtn =[self buttonWith:@"chat_bottom_voice_nor.png" hightlight:@"chat_bottom_voice_press.png"   action:@selector(voidpress:)];
//    [self.voiceBtn setFrame:CGRectMake(0, 0, 33, 33)];
//    [self.voiceBtn setCenter:CGPointMake(30, self.frame.size.height*0.5)];
//    [self addSubview: self.voiceBtn];
    
    self.textField=[[UITextField alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width-50, self.frame.size.height*0.8)];
    self.textField.returnKeyType=UIReturnKeySend;
    self.textField.center=CGPointMake(145, self.frame.size.height*0.5);
    self.textField.font= [UIFont fontWithName:@"HelveticaNeue" size:14];
    self.textField.placeholder=@"请输入···";
    self.textField.background= [UIImage imageNamed:@"chat_bottom_textfield.png"];
    self.textField.delegate=self;
    [self addSubview:self.textField];
    
    self.iamgeBtn=[self buttonWith:@"chat_bottom_smile_nor.png" hightlight:@"chat_bottom_smile_press.png" action:@selector(imagepress:)];
    [self.iamgeBtn setFrame:CGRectMake(0, 0, 33, 33)];
    [self.iamgeBtn setCenter:CGPointMake(self.frame.size.width-22, self.frame.size.height*0.5)];
    [self addSubview:self.iamgeBtn];
    
//    self.addBtn=[self buttonWith:@"chat_bottom_up_nor.png" hightlight:@"chat_bottom_up_press.png" action:@selector(addbtnpress:)];
//    [self.addBtn setFrame:CGRectMake(0, 0, 33, 33)];
//    [self.addBtn setCenter:CGPointMake(300, self.frame.size.height*.5)];
//    [self addSubview:self.addBtn];
    
//    self.speakBtn=[self buttonWith:nil hightlight:nil action:@selector(speakBtnpress:)];
//    [self.speakBtn setTitle:@"按住说话" forState:UIControlStateNormal];
//    [self.speakBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//    [self.speakBtn setTitleColor:[UIColor redColor] forState:(UIControlState)UIControlEventTouchDown];
//    [self.speakBtn addTarget:self action:@selector(speakBtnpressedown:) forControlEvents:UIControlEventTouchDown];
//    [self.speakBtn setFrame:self.textField.frame];
//    [self.speakBtn setBackgroundColor:[UIColor whiteColor]];
//    self.speakBtn.hidden = YES;
//    [self addSubview:self.speakBtn];
    
}
-(void)imagepress:(UIButton*)imagebtn{
    NSLog(@"点击了图像");
}
-(void)addbtnpress:(UIButton*)addbtn{
    NSLog(@"点击了添加图像");
}

//单点击
-(void)speakBtnpress:(UIButton*)speakbtn{
}

//长按
-(void)speakBtnpressedown:(UIButton*)speakbtn{

}
-(void)voidpress:(UIButton*)voice{
    NSString* normal,*highlight;
    if(self.speakBtn.hidden==YES){
        self.speakBtn.hidden=NO;
        self.textField.hidden=YES;
        
        normal=@"chat_bottom_keyboard_nor.png";
        highlight=@"chat_bottom_keyboard_press.png";
    }else{
        self.speakBtn.hidden=YES;
        self.textField.hidden=NO;
        
        normal=@"chat_bottom_voice_nor.png";
        highlight=@"chat_bottom_voice_press.png";
    }
    
    [voice setImage:[UIImage imageNamed:normal] forState:UIControlStateNormal];
    [voice setImage:[UIImage imageNamed:highlight] forState:UIControlStateHighlighted];
    
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if([self.delegate respondsToSelector:@selector(KeyboardView:textfiedbegin:)]){
        [ self.delegate KeyboardView:self textfiedbegin:textField];
    }
        return  YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if([self.delegate respondsToSelector:@selector(KeyboardView:textfiedreturn:)]){
        [self.delegate KeyboardView:self textfiedreturn:textField];
    }
    return  YES;
}

@end
