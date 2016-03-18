//
//  CommentDetailCTL.m
//  tu_bar
//
//  Created by 肖准 on 15/10/27.
//  Copyright © 2015年 肖准. All rights reserved.
//

#import "CommentDetailCTL.h"
#define PLACE_HOLDER @"请输入···"
@interface CommentDetailCTL()<KeyboardViewDelegate,XZCommentTbableViewDelegate>{
    NSString* _lz;
}
@property(nonatomic,strong)XZCommentTbableView* xzcommenttableview;

@property(nonatomic,strong)KeyboardView* keyboardview;
@property(nonatomic,strong)NSComment* comment;
@property(nonatomic,strong)NSString* toname;
@property(nonatomic,assign)BOOL isKeyShown;
@end
@implementation CommentDetailCTL

-(instancetype)initWithNScomment:(NSComment*)com{
    if(self=[super init]){
        self.comment=com;
    }
    return self;
}
-(void)viewDidLoad{
    [super viewDidLoad];
    NSLog(@"CommentDetailCTL");
    self.view.backgroundColor=[UIColor whiteColor];
    
    self.xzcommenttableview=[XZCommentTbableView gettableView:self.view.width Data:self.comment];
    self.xzcommenttableview.frame=CGRectMake(0, 0, self.view.width, self.view.height-44);
    self.xzcommenttableview.tableview.frame=_xzcommenttableview.frame;
    self.xzcommenttableview.delegate=self;
    _lz=self.xzcommenttableview.headerview.selfNSComment.auther;
    
    [self.view addSubview:self.xzcommenttableview];
    [self.view addSubview:self.keyboardview];
    self.toname=@"";
    self.isKeyShown=NO;
    
//    NSLog(@"index:%d",[self.view.subviews indexOfObject:self.xzcommenttableview]);
//    NSLog(@"key index:%d",[self.view.subviews indexOfObject:self.keyboardview]);

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sayback:) name:@"sayback" object:nil];
    
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
    
}
//-(XZCommentTbableView*)xzcommenttableview{
//    if(_xzcommenttableview==nil){
//        
//        _xzcommenttableview=[XZCommentTbableView gettableView:self.view.width Data:self.comment];
//        _xzcommenttableview.frame=CGRectMake(0, 0, self.view.width, self.view.height-44);
//        _xzcommenttableview.tableview.frame=_xzcommenttableview.frame;
//        _xzcommenttableview.delegate=self;
//    }
//    return  _xzcommenttableview;
//}

-(void)sayback:(NSNotification*)noti{
    NSLog(@"%@",noti.object);
    NSString* name = noti.object;
    self.toname=name;
    self.keyboardview.textField.placeholder=[NSString stringWithFormat:@"回复%@:",name];
    
    [self.keyboardview.textField becomeFirstResponder];
//    [self.keyboardview.textField reloadInputViews];
}
-(void)back:(id)sender{
    NSLog(@"bacccccccck");

    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"comments_back" object:nil];
}

#pragma  keyboard
-(KeyboardView*)keyboardview{
    if(_keyboardview==nil){
        _keyboardview=[[KeyboardView alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height-44, self.view.frame.size.width, 44)];
        _keyboardview.delegate=self;
    }
    return  _keyboardview;
}
//键盘改动的时候其他view随着变化
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
    
}

-(void)keyboardShow:(NSNotification *)note
{
    NSLog(@"show");
    CGRect keyBoardRect=[note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat deltaY=keyBoardRect.size.height;
    
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        
        self.keyboardview.transform=CGAffineTransformMakeTranslation(0, -deltaY);
//        [self.xzcommenttableview.tableview setHeight:(h-deltaY)];
//        [self.xzcommenttableview setHeight:(h-deltaY)];
    }];
    self.isKeyShown=YES;
}
-(void)keyboardHide:(NSNotification *)note
{
    NSLog(@"hide");
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        self.keyboardview.transform = CGAffineTransformIdentity;
        
//        [self.xzcommenttableview.tableview setHeight:(self.view.height-108)];
//        [self.xzcommenttableview setHeight:(self.view.height-64)];
//        
        
    }];
    self.isKeyShown=NO;

}

-(void)KeyboardView:(KeyboardView *)keyboard textfiedbegin:(UITextField *)textfield{

}
//点击返回键
-(void)KeyboardView:(KeyboardView *)keyboard textfiedreturn:(UITextField *)textfield{
    NSString* temp  = textfield.text;
    if([temp length]!=0){
        MOOtherComments* newco=[[MOOtherComments alloc]init];
        newco.iconurl=@"xiaozhun.jpg";
        NSString* tempholder = [textfield.placeholder isEqualToString:PLACE_HOLDER]?@"楼主":textfield.placeholder;
        newco.des=[NSString stringWithFormat:@"%@%@",tempholder,textfield.text];
        newco.idname=@"tyrant";
        newco.toid=self.toname;
        newco.time=[NSDate date];
        newco.isLZ=0;
        [self.comment.othercomments addObject:newco];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"comment_changed" object:nil];

        [self.xzcommenttableview removeFromSuperview];
        self.xzcommenttableview=nil;
        self.xzcommenttableview=[XZCommentTbableView gettableView:self.view.width Data:self.comment];
        self.xzcommenttableview.frame=CGRectMake(0, 0, self.view.width, self.view.height-44);
        self.xzcommenttableview.tableview.frame=CGRectMake(0, 64, self.view.width, self.view.height-108);
        self.xzcommenttableview.delegate=self;
        [self.view addSubview:self.xzcommenttableview];
        [self.keyboardview removeFromSuperview];
        [self.view addSubview:self.keyboardview];


        [self.view endEditing:YES];
        textfield.text=@"";
        
    }
    [self.view endEditing:YES];
}
#pragma xzcommenttableview
-(void)XZCommentTbableViewCellIconTapped:(XZCommentTbableView *)view cell:(UIView *)cell tap:(UITapGestureRecognizer *)tap{
 

    if(self.isKeyShown){
        [self.view endEditing:YES ];
        return ;
    }
    
       if(cell.tag==CELL_DES){
            XZCommentCell* tempcell=  (XZCommentCell*)([[cell superview] superview]);
            NSString* name = tempcell.selfMootherComment.idname;

           if([name isEqualToString:_lz]){
               name=@"楼主";
           }
           
            self.keyboardview.textField.placeholder=[NSString stringWithFormat:@"回复%@:",name];
            [self.keyboardview.textField becomeFirstResponder];

        }else if (cell.tag==HEADER_DES){
//            XZCommentHeaderview* header = (XZCommentHeaderview*)[cell superview];
//            NSString* name = header.selfNSComment.auther;
            NSLog(@"第二页 header_des");
            self.keyboardview.textField.placeholder=@"回复楼主:";
            [self.keyboardview.textField becomeFirstResponder];

        }else if(cell.tag==CELL_ICON||cell.tag==HEADER_ICON||cell.tag==HEADER_NAME){ //icon
            UIViewController* ctl=[[UIViewController alloc]init];
            ctl.view.backgroundColor=[UIColor whiteColor];
            [self.view endEditing:YES];
            [self.navigationController pushViewController:ctl animated:YES];
        }
    
    
}
////点击回复
//-(void)anstap:(UITapGestureRecognizer*)tap{
//    NSLog(@"state:%d",tap.state);
//    UILabel* tapview=(UILabel*)tap.view;
//    tapview.backgroundColor=[UIColor grayColor];
//    if(tap.state==UIGestureRecognizerStateEnded){
//        NSLog(@"点击手势结束");
//        tapview.backgroundColor=[UIColor clearColor];
//        
//        
//    }
//    self.keyboardview.textField.text=[NSString stringWithFormat:@"回复 %d楼:",tap.view.tag-1000];
//    [self.keyboardview becomeFirstResponder];
//    
//}
//开始拖拉时
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
}


@end
