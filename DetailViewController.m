//
//  DetailViewController.m
//  tu_bar
//
//  Created by 肖准 on 15/9/29.
//  Copyright (c) 2015年 肖准. All rights reserved.
//

#import "DetailViewController.h"
#define VIEW_WIDTH self.view.frame.size.width
static NSString * const cellid=@"TalkTableViewCell";
static NSString* const JSON_PATH=@"tu_2.json";
@interface DetailViewController ()<UITableViewDataSource,UITableViewDelegate,UIGestureRecognizerDelegate,UIScrollViewDelegate,CommentViewDelegate,XZCommentTbableViewDelegate,KeyboardViewDelegate>
@property(nonatomic,strong)KeyboardView* keyboardview;
@property(nonatomic,assign)BOOL isKeyShown;

@property(nonatomic,strong)UIView* upview;
@property(nonatomic,strong)UIImageView* icon;
@property(nonatomic,strong)UILabel* idlabel;
@property(nonatomic,strong)UITextView* desciption;
@property(nonatomic,strong)UILabel* upnumber;
@property(nonatomic,strong)UILabel* downnumber;
@property(nonatomic,strong)UIView* itembar;

@property(nonatomic,strong)NSArray* infodict;
@property(nonatomic,strong)MODcomments* mo;

@property(nonatomic,assign)NSInteger upN;
@property(nonatomic,assign)NSInteger downN;


@property(nonatomic,strong)UITableView* mytableview;
@property(nonatomic,strong)TalkTableViewCell * constcell;

@property(nonatomic,strong)UIView*bgview;
@property(nonatomic,assign)NSInteger selectedIndex;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.selectedIndex=0;
    self.istapped=NO;
    self.isKeyShown=NO;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshview) name:@"comments_back" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self  selector:@selector(commentChanged:) name:@"comment_changed" object:nil];
    
    [self.navigationController.navigationBar setFrame:CGRectMake(0, 20, self.view.frame.size.width, self.navigationController.navigationBar.frame.size.height)];
   
    [self.view addSubview:self.mytableview];
    [self.view addSubview:self.keyboardview];

    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBar.tintColor = [self.navigationController.navigationBar.tintColor
                                                         colorWithAlphaComponent:1];
    
    
    
    UISwipeGestureRecognizer* panges=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(bacleft:)];
    [self.view addGestureRecognizer:panges];
    
    self.mo=self.infodict[0];
    self.upN=self.mo.top;
    self.downN=self.mo.down;
//    NSLog(@"mo:%@",self.mo.comments);
    [self.mo.comments enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"%@",(self.mo.comments[0]));
    }];
}
-(void)commentChanged:(NSNotification*)noti{
    NSLog(@"评论发生了变化,保存变化");
    dispatch_queue_t que=dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(que , ^{
        NSDictionary* dict =[self.mo toDictionary];
        NSData* data = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:nil];
        NSString* jsonstr =[[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        [jsonstr writeToFile:JSON_PATH atomically:YES encoding:NSUTF8StringEncoding error:nil];
    });
}
//评论页面返回后，刷新tableview
-(void)refreshview{
    [self.mytableview reloadData];
}
-(void)bacleft:(UISwipeGestureRecognizer*)swipeges{
    if(swipeges.direction==UISwipeGestureRecognizerDirectionRight){
        NSLog(@"向右轻扫");
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(UITableView*)mytableview{
    
    if(_mytableview==nil){
        
        _mytableview =[[UITableView alloc ]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-44)];
        _mytableview.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
        _mytableview.delegate=self;
        _mytableview.dataSource=self;
    }
    
    return _mytableview;
}
-(NSArray*)infodict{
    if(_infodict==nil){
        //NSBundle *mybundle=[NSBundle bundleWithPath:@"xz"]
        NSString* filepath=[[NSBundle mainBundle]pathForResource:@"tu_2" ofType:@"json"];
        
       // NSData* data= [NSData dataWithContentsOfFile:JSON_PATH];
        NSData*data = [NSData dataWithContentsOfFile:filepath];
        
        NSDictionary* json = nil;
        if (data) {
            json = [NSJSONSerialization
                    JSONObjectWithData:data
                    options:kNilOptions
                    error:nil];
        }
        NSMutableArray *temparr=[[NSMutableArray alloc]init];
        MODcomments* co=[[MODcomments alloc]initWithDictionary:json error:nil ];
        [temparr addObject:co];
        _infodict=temparr;
        
    }
    return  _infodict;
    
}

-(UIView*)upview{
    if (_upview==nil) {
        _upview=[[UIView alloc]initWithFrame:CGRectZero];
        _upview.backgroundColor=[UIColor whiteColor];
      
        //添加头像
        [_upview addSubview:self.icon];
        //添加id
        [_upview addSubview:self.idlabel];

        [_upview addSubview:self.desciption];
        
        [_upview addSubview:self.pic];
        
        [_upview addSubview:self.itembar];
        CGFloat height=self.icon.frame.size.height+self.desciption.frame.size.height+self.pic.frame.size.height+30+self.itembar.frame.size.height;
        [_upview setFrame:CGRectMake(0, 0, self.view.frame.size.width, height)];
        
    }
    return  _upview;
}

-(void)icontap:(UITapGestureRecognizer*)ges{
    NSLog(@"detail icon tapeeed");
}
-(UIImageView*)icon{
    if(_icon==nil){
        
        _icon =[[UIImageView alloc]initWithFrame:CGRectMake(8, 8, 40, 40)];
        [_icon setImage:[UIImage imageNamed:@"xiaozhun.jpg"]];
        _icon.layer.masksToBounds=YES;
        _icon.layer.cornerRadius=20;
        
        UITapGestureRecognizer* icontap= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(icontap:)];
        _icon.userInteractionEnabled=YES;
        [_icon addGestureRecognizer:icontap];
    }
    return  _icon;
    
    
}
-(UITextView*)desciption{
    if(_desciption==nil){
        _desciption=[[UITextView alloc]initWithFrame:CGRectMake(8, 48, VIEW_WIDTH-16,0)];
        NSString* str=self.mo.des;
      
        NSMutableAttributedString * attributedString1 = [[NSMutableAttributedString alloc] initWithString:str];
        NSMutableParagraphStyle * paragraphStyle1 = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle1 setLineSpacing:5];
        [attributedString1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle1 range:NSMakeRange(0, [str length])];
        [_desciption setAttributedText:attributedString1];
        CGSize size = [str getStringSize:CGSizeMake(VIEW_WIDTH, MAXFLOAT) font:[UIFont systemFontOfSize:12 weight:.2]];
        [_desciption setFrame:CGRectMake(8, 48, VIEW_WIDTH, size.height+10)];
        
        _desciption.textAlignment=NSTextAlignmentLeft;
        _desciption.text=str;
        _desciption.backgroundColor=[UIColor clearColor];
        _desciption.userInteractionEnabled=NO;
        
    }
    
    return  _desciption;
    
}

-(UIImageView*)pic{
    if(_pic==nil){
      //  NSBundle* mubd=[[NSBundle mainBundle]pathForResource:@"huajie1" ofType:@"png"];
        UIImage * im= [UIImage imageNamed:@"huajie1.png"];
        UIImage* newim=[im getNewImageByNewSzie:CGSizeMake(VIEW_WIDTH-16, VIEW_WIDTH-16)];
        _pic=[[UIImageView alloc]initWithFrame:CGRectMake(8, self.icon.frame.origin.y+self.icon.frame.size.height+self.desciption.frame.size.height+10, VIEW_WIDTH-16, newim.size.height)];
        _pic.userInteractionEnabled=YES;
        UITapGestureRecognizer * imagetap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imagetap:)];
        [_pic addGestureRecognizer:imagetap];
        _pic.image=newim;
    }
    return  _pic;
}
-(void)downloadbtn:(UIButton*)btn{
    NSLog(@"图片开始下载...");
}
-(UIView*)bgview{
    
    if(_bgview==nil){
        _bgview=[[UIView alloc]initWithFrame:CGRectMake(self.mytableview.frame.origin.x, self.mytableview.frame.origin.y, self.mytableview.contentSize.width, self.mytableview.contentSize.height)];

        //_bgview=[[UIView alloc]initWithFrame:self.view.frame];
        
        _bgview.backgroundColor=[UIColor whiteColor];
        UIButton* downloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [downloadBtn setBackgroundImage:[UIImage imageNamed:@"download_icon.png"] forState:UIControlStateNormal];
        downloadBtn.frame=CGRectMake(self.view.width-70, self.view.height-100, 50, 50);
        [downloadBtn addTarget:self action:@selector(downloadbtn:) forControlEvents:UIControlEventTouchUpInside];
        [_bgview addSubview:downloadBtn];
        // _bgview.alpha=0.3;
    }
    return  _bgview;
}
-(void)imagetap:(UITapGestureRecognizer*)ges{
    //当前view置顶
    
    if(self.isKeyShown){
        [self.view endEditing:YES ];
        return ;
    }
    
    
    [self.view bringSubviewToFront:ges.view];
    if(self.istapped){
        [self.navigationController setNavigationBarHidden:NO animated:NO];

        [UIView animateWithDuration:.2 animations:^{
            if([ges.view superview]){
                [[ges.view superview] removeFromSuperview];
                [self.upview addSubview:ges.view];
            }
            ges.view.transform=CGAffineTransformIdentity;
        }];
        self.istapped=NO;
    }else{
        self.istapped=YES;
        [self.navigationController setNavigationBarHidden:YES animated:NO];
        
        
        CGPoint translationoff=CGPointMake(self.mytableview.center.x-ges.view.center.x, self.mytableview.center.y-ges.view.center.y);
        [self.view addSubview:self.bgview];
        [self.bgview addSubview:ges.view];
        
        
        CGFloat factor=(self.view.frame.size.width/ges.view.frame.size.width)*1.04;
        [UIView animateWithDuration:0.2 animations:^{
            ges.view.transform=CGAffineTransformMakeTranslation(translationoff.x, translationoff.y);
           // ges.view.center=self.bgview.center;
            ges.view.transform=CGAffineTransformScale(ges.view.transform,factor,factor);
            //ges.view.transform=CGAffineTransformScale(ges.view.transform,1.0/factor, 1.0/factor);
        }];
    }
    
}
-(UILabel*)upnumber{
    if(_upnumber==nil){
    
        _upnumber=[[UILabel alloc]init];
       _upnumber.text=[NSString stringWithFormat:@"%d",self.upN];
        _upnumber.font=[UIFont systemFontOfSize:12];
        _upnumber.bounds=CGRectMake(0, 0, 30, 20);
        _upnumber.center=CGPointMake(self.itembar.frame.size.width/3-20, self.itembar.frame.size.height/2);

        
    }
    return _upnumber;
}
-(UILabel*)downnumber{
    if(_downnumber==nil){
        _downnumber=[[UILabel alloc]init];
        _downnumber.text=[NSString stringWithFormat:@"%d",self.downN];
        _downnumber.font=[UIFont systemFontOfSize:12];
        _downnumber.bounds=CGRectMake(0, 0, 30, 20);
        _downnumber.center=CGPointMake(self.itembar.frame.size.width/3*2-20, self.itembar.frame.size.height/2);
        
    }
    return  _downnumber;
}

-(UIView*)itembar{
    
    if(_itembar==nil){
        _itembar=[[UIView alloc]initWithFrame:CGRectMake(0, self.pic.frame.origin.y+self.pic.frame.size.height+5, self.view.frame.size.width, 40)];
        _itembar.backgroundColor=[UIColor colorWithRed:0.922 green:0.883 blue:0.646 alpha:0.000];
        _itembar.userInteractionEnabled=YES;
        UIButton* up=[UIButton buttonWithType:UIButtonTypeCustom];
        [up setBackgroundImage:[UIImage imageNamed:@"heart_em.png"] forState:UIControlStateNormal];
        [up setBackgroundImage:[UIImage imageNamed:@"heart_full.png"] forState:UIControlStateSelected];
        up.bounds=CGRectMake(0, 0, 30, 30);
        up.center=CGPointMake(self.view.frame.size.width/3, _itembar.frame.size.height/2);
    
        [up addTarget:self action:@selector(upbtn:) forControlEvents:UIControlEventTouchUpInside];
        
      
        [_itembar addSubview:up];
        [_itembar addSubview:self.upnumber];
        
        
        UIButton* down=[UIButton buttonWithType:UIButtonTypeCustom];
        [down setBackgroundImage:[UIImage imageNamed:@"shit.png"] forState:UIControlStateNormal ];
        [down setBackgroundImage:[UIImage imageNamed:@"shit_full.png"] forState:UIControlStateSelected];

        down.bounds=CGRectMake(0, 0, 30, 30);
        down.center=CGPointMake(self.view.frame.size.width/3*2, _itembar.frame.size.height/2);
        [down addTarget:self action:@selector(downbtn:) forControlEvents:UIControlEventTouchUpInside];
   
        [_itembar addSubview:down];
        [_itembar addSubview:self.downnumber];

        
    }
    return  _itembar;
}
-(void)upbtn:(UIButton*)sender{

    if(!sender.selected){
        UILabel* plus=[[UILabel alloc]init];
        plus.text=@"+1";
        plus.bounds=CGRectMake(0, 0, 30, 20);
        plus.center=CGPointMake(self.view.frame.size.width/3+35, self.itembar.frame.size.height/2+10);
        plus.textColor=[UIColor redColor];
        plus.font=[UIFont systemFontOfSize:11];
        [self.itembar addSubview:plus];
        plus.alpha=0;
        self.upN+=1;
        self.mo.top+=1;
        [[NSNotificationCenter defaultCenter]postNotificationName:@"comment_changed" object:nil];
        self.upnumber.text=[NSString stringWithFormat:@"%d",self.upN];
        [self.upnumber reloadInputViews];
        [UIView animateWithDuration:1.0 animations:^{
            plus.center=CGPointMake(self.view.frame.size.width/3+35, self.itembar.frame.size.height/2);
            plus.alpha=1;

        } completion:^(BOOL finished) {
            
        }];//        plus.hidden=false;
        [UIView animateWithDuration:1.0 animations:^{
            plus.center=CGPointMake(self.view.frame.size.width/3+35, self.itembar.frame.size.height/2-10);
            plus.alpha=0;
            
        } completion:^(BOOL finished) {
            [plus removeFromSuperview];
        }];//        plus.hidden=false;
        
        sender.selected=YES;
    }else{
        
        
        sender.selected=false;
    }
}
-(void)downbtn:(UIButton*)sender{
    
    if(!sender.selected){
        UILabel* plus=[[UILabel alloc]init];
        plus.text=@"+1";
        plus.bounds=CGRectMake(0, 0, 30, 20);
        plus.center=CGPointMake(self.view.frame.size.width/3*2+35, self.itembar.frame.size.height/2+10);
        plus.font=[UIFont systemFontOfSize:11];
        [self.itembar addSubview:plus];
        plus.alpha=0;
        self.downN+=1;
        self.mo.down+=1;
        [[NSNotificationCenter defaultCenter]postNotificationName:@"comment_changed" object:nil];

        self.downnumber.text=[NSString stringWithFormat:@"%d",self.downN];

        [self.downnumber reloadInputViews];
        [UIView animateWithDuration:1.0 animations:^{
            plus.center=CGPointMake(self.view.frame.size.width/3*2+35, self.itembar.frame.size.height/2);
            plus.alpha=1;
            
        } completion:^(BOOL finished) {
            
        }];//        plus.hidden=false;
        [UIView animateWithDuration:1.0 animations:^{
            plus.center=CGPointMake(self.view.frame.size.width/3*2+35, self.itembar.frame.size.height/2-10);
            plus.alpha=0;
            
        } completion:^(BOOL finished) {
            [plus removeFromSuperview];

        }];//        plus.hidden=false;
        
        sender.selected=YES;
    }else{
        
        
        sender.selected=false;
    }
}

-(UILabel*)idlabel{
    if(_idlabel==nil){
        _idlabel= [[UILabel alloc] initWithFrame:CGRectMake(0, 10, 20, 30)];
        _idlabel.font = [UIFont boldSystemFontOfSize:20.0f];  //UILabel的字体大小
        _idlabel.numberOfLines = 1;  //必须定义这个属性，否则UILabel不会换行
        _idlabel.textColor = [UIColor colorWithRed:1.000 green:0.500 blue:0.000 alpha:1.000];
        _idlabel.textAlignment = NSTextAlignmentLeft;  //文本对齐方式
        NSString *str = @"tyrantkemp";
        _idlabel.font=[UIFont systemFontOfSize:13];
        
        CGSize size = [str sizeWithFont:_idlabel.font constrainedToSize:CGSizeMake(MAXFLOAT, _idlabel.frame.size.height)];
        //根据计算结果重新设置UILabel的尺寸
        [_idlabel setFrame:CGRectMake(55, 18, size.width, 20)];
        _idlabel.text = str;
        
    }
    return  _idlabel;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"numberOfRowsInSection");
    if (section==0) {
        return  1;
    }else
        return  self.mo.comments.count;
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section==0){
        if (indexPath.row==0) {
            return  self.upview.frame.size.height;
            
        }
    }else if(indexPath.section==1){
        NSLog(@"heightForRowAtIndexPath");
        NSComment * co=self.mo.comments[indexPath.row];
        XZCommentTbableView* view=[XZCommentTbableView gettableView:self.view.frame.size.width Data:co];
        return  [view getHeight]+1;
    
    }
    
    return 150;
    
    
    
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if(section==0){
    UIView * line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, VIEW_WIDTH, 2)];
    line.backgroundColor=[UIColor colorWithWhite:0.800 alpha:1.000];
        return  line;
    }
    return  nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return  2.0;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    if(indexPath.section==0){
        UITableViewCell* cell=[[UITableViewCell alloc]initWithFrame:CGRectZero];
        [cell.contentView addSubview:self.upview];
        cell.selectionStyle=UITableViewCellSeparatorStyleNone;
        return  cell;
        
    }else{

        XZComAllCell* cell=[tableView dequeueReusableCellWithIdentifier:@"XZComAllCell"];
        if(cell==nil){
            cell=[[XZComAllCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"XZComAllCell"];
           
        }
        //防止图层叠加
        [cell.contentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj removeFromSuperview];
        }];
        
        NSLog(@"cellForRowAtIndexPath");
        NSComment * co=self.mo.comments[indexPath.row];
        cell.contentView.userInteractionEnabled=YES;
        cell.userInteractionEnabled=YES;
        cell.cellview.userInteractionEnabled=YES;
        cell.cellview=[XZCommentTbableView gettableView:self.view.frame.size.width Data:co];
        cell.cellview.delegate=self;
        cell.cellview.frame=CGRectMake(0, 0, self.view.frame.size.width, [cell.cellview getHeight]+1);
        cell.cellview.tableview.scrollEnabled=NO;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        [cell.contentView addSubview:cell.cellview];
        return cell;
    
    }
    
    
    
}
#pragma XZCommentTbableView delegate
-(void)XZCommentTbableViewCellIconTapped:(XZCommentTbableView *)view cell:(XZCommentCell *)cell tap:(UITapGestureRecognizer *)tap{
    

    if(self.isKeyShown){
        [self.view endEditing:YES ];
        return ;
    }
    
    
    self.selectedIndex=view.comment.index;
//    NSLog(@"%@",NSStringFromClass([[[view superview] superview] class]));
//    if([[[view superview] superview ] isKindOfClass:[XZComAllCell class]] ){
       //第一个层级
        if(cell.tag==CELL_DES||cell.tag==HEADER_DES){  //des
//            view.tableview.scrollEnabled=YES;
//            NSComment* newcom=[[NSComment alloc]init];
//            newcom=[view.comment copy];
            CommentDetailCTL* ctl=[[CommentDetailCTL alloc]initWithNScomment:view.comment];
//            ctl.xzcommenttableview=view;

            //图层位置调整
//            [view setFrame:ctl.view.frame];
//            [view setHeight:view.height-44];
//            [view.tableview setFrame:ctl.view.frame];
//            [view.tableview setHeight:view.tableview.height-108];
//            [view.tableview setY:view.tableview.y+64];

//            ctl.view.backgroundColor=[UIColor whiteColor];
//            [ctl.view addSubview:ctl.xzcommenttableview];
            [self.view endEditing:YES];
            [self.navigationController pushViewController:ctl animated:YES];
        }else if(cell.tag==CELL_ICON||cell.tag==HEADER_ICON||cell.tag==HEADER_NAME){
        
            NSString* name =@"";
            switch (cell.tag) {
                case CELL_ICON:
                    name=((XZCommentCell*)[[cell superview] superview]).selfMootherComment.idname;
                    break;
                case HEADER_ICON:
                    name = ((XZCommentHeaderview*)[cell superview]).selfNSComment.auther;
                    break;
                case HEADER_NAME:
                    name = ((XZCommentHeaderview*)[cell superview]).selfNSComment.auther;
                    break;
                default:
                    break;
            }
            PersonDetailCtl* ctl=[[PersonDetailCtl alloc]initWithName:(NSString*)name];
            [ctl.navigationController setNavigationBarHidden:YES];
            ctl.view.backgroundColor=[UIColor whiteColor];
            [self.view endEditing:YES];
            [self.navigationController pushViewController:ctl animated:YES];
        }
//    }else{
//        //后面的层级
//            if(cell.tag==CELL_DES){
//                XZCommentCell* tempcell=  (XZCommentCell*)([[cell superview] superview]);
//                [[NSNotificationCenter defaultCenter]postNotificationName:@"sayback" object:tempcell.selfMootherComment.idname];
//                
//            }else if (cell.tag==HEADER_DES){
//                XZCommentHeaderview* header = (XZCommentHeaderview*)[cell superview];
//                [[NSNotificationCenter defaultCenter]postNotificationName:@"sayback" object:header.selfNSComment.auther];
//
//        }else if(cell.tag==CELL_ICON||cell.tag==HEADER_ICON||cell.tag==HEADER_NAME){ //icon
//            UIViewController* ctl=[[UIViewController alloc]init];
//            ctl.view.backgroundColor=[UIColor whiteColor];
//            [self.view endEditing:YES];
//            [self.navigationController pushViewController:ctl animated:YES];
//        }
 //   }
    
  
   
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    if([touch view].tag<1000){
        [self.view endEditing:YES];
    }
}

-(void)tableViewScrollCurrentIndexPath
{
    
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:self.mytableview.indexPathForSelectedRow.row-1 inSection:1];
        [self.mytableview scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        CGPoint offset = self.mytableview.contentOffset;
        offset.y=50;
        self.mytableview.contentOffset=offset;
    
}


//开始拖拉时
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


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
    }];
    self.isKeyShown=YES;
}
-(void)keyboardHide:(NSNotification *)note
{
    NSLog(@"hide");
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        self.keyboardview.transform = CGAffineTransformIdentity;
    }];
    self.isKeyShown=NO;
    
}

-(void)KeyboardView:(KeyboardView *)keyboard textfiedbegin:(UITextField *)textfield{
    
}
//点击返回键
-(void)KeyboardView:(KeyboardView *)keyboard textfiedreturn:(UITextField *)textfield{
    NSString* temp  = textfield.text;
    if([temp length]!=0){
        NSComment* newcom = [[NSComment alloc]init];
        newcom.url=@"xiaozhun.jpg";
        newcom.auther=@"tyrant";
        newcom.index=self.mo.comments.count+1;
        newcom.des=self.keyboardview.textField.text;
        newcom.othercomments=[[NSMutableArray<MOOtherComments> alloc]initWithCapacity:0];
        self.keyboardview.textField.text=@"";
        [self.mo.comments addObject:newcom];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"comment_changed" object:nil];
        [self.mytableview reloadData];
    }
    [self.view endEditing:YES];
}

@end

