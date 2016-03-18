//
//  PersonDetailCtl.m
//  tu_bar
//
//  Created by 肖准 on 15/11/2.
//  Copyright © 2015年 肖准. All rights reserved.
//

#import "PersonDetailCtl.h"
@interface PersonDetailCtl()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView* tableview;
@property(nonatomic,strong)UIView* buttonview;
@property(nonatomic,strong)UIButton* backbtn;
@property(nonatomic,strong)UIView* bacview;
@property(nonatomic,strong)UIImageView* bacimage;
@property(nonatomic,strong)UIImageView* icon;

@end

@implementation PersonDetailCtl
-(instancetype)initWithName:(NSString*)name{
    if(self=[super init]){
        
        self.namestr=name;
        
    }
    return  self;
}
-(void)viewWillAppear:(BOOL)animated{

//    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
//
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"bigShadow.png"] forBarMetrics:UIBarMetricsCompact];
//    [self.navigationController.navigationBar setTitleTextAttributes:@{
//                                  NSForegroundColorAttributeName :[UIColor whiteColor]
//                                  }];
//    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init]
//                                      forBarPosition:UIBarPositionAny
//                                          barMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    [self.navigationController setNavigationBarHidden:YES];
}
-(void)viewWillDisappear:(BOOL)animated{
    [[self navigationController] setNavigationBarHidden:NO];

}
-(void)viewDidLoad{
    
    self.navigationItem.title=self.namestr;


  
    
   // [self.view addSubview:self.bacview];
    [self.view addSubview:self.tableview];

    [self.view addSubview:self.buttonview];
     [self.view addSubview:self.backbtn];
}
-(UIButton*)backbtn{
    if(_backbtn==nil){
        _backbtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_backbtn setTitle:@"< 返回" forState:UIControlStateNormal];
        [_backbtn setBackgroundColor:[UIColor clearColor]];
        [_backbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_backbtn addTarget:self action:@selector(backbtn:) forControlEvents:UIControlEventTouchUpInside];
        [_backbtn setFrame:CGRectMake(10, 20, 60, 30)];
        
        
    }
    return _backbtn;
}
-(void)backbtn:(UIButton*)btn{
    [self.navigationController popViewControllerAnimated:YES];
}
-(UIView*)bacview{
    if(_bacview==nil){
        _bacview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 200)];
        _bacview.contentMode=UIViewContentModeScaleAspectFit;
        _bacview.backgroundColor=[UIColor yellowColor];
        UIImage* bacim=[UIImage imageNamed:@"xiaozhun.jpg"];
        UIImage* blurimge = [bacim blurryImage:bacim withBlurLevel:.9];
        self.bacimage=[[UIImageView alloc]initWithImage:blurimge];
        self.bacimage.contentMode=UIViewContentModeScaleToFill;
        self.bacimage.frame=CGRectMake(0, 0, _bacview.width, _bacview.height);
        [_bacview addSubview:self.bacimage];
        
        self.icon=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"xiaozhun.jpg"]];
        self.icon.bounds=CGRectMake(0, 0, 80, 80);
        self.icon.center=CGPointMake(self.view.width/2, _bacview.height/2-10);
        self.icon.layer.borderWidth=1.0;
        self.icon.layer.borderColor=[UIColor lightGrayColor].CGColor;
        [_bacview addSubview:self.icon];
        
        UILabel* name=[[UILabel alloc]init];
        name.text=self.namestr;
        name.textAlignment=NSTextAlignmentCenter;
        name.textColor=[UIColor whiteColor];
        name.bounds=CGRectMake(0, 0, 100, 30);
        name.center=CGPointMake(self.view.width/2, self.icon.y+self.icon.height+15);
        [_bacview addSubview:name];
        
        
        
        
    }
    return _bacview;
}
-(UITableView*)tableview{
    if(_tableview==nil){
        
        _tableview=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableview.frame=CGRectMake(0, -20, self.view.width, self.view.height-44);
        _tableview.backgroundColor=[UIColor clearColor];
        _tableview.dataSource=self;
        _tableview.delegate=self;
        _tableview.tableHeaderView=self.bacview;
//        _tableview.separatorStyle=UITableViewCellSeparatorStyleNone;
//        UIView* bacview =[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 200)];
//        bacview.contentMode=UIViewContentModeScaleAspectFit;
//        _tableview.contentInset=UIEdgeInsetsMake(200, 0, 0, 0);
//        _tableview.tableHeaderView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 150)];
//        _tableview.tableHeaderView.backgroundColor=[UIColor yellowColor];
    }
    return  _tableview;
    
}
-(UIView*)buttonview{
    if(_buttonview==nil){
        
        _buttonview=[[UIView alloc]initWithFrame:CGRectMake(0, self.view.height-44, self.view.width, 44)];
        _buttonview.backgroundColor=[UIColor clearColor];
        UIButton* addFbtn = [UIButton buttonWithType:UIButtonTypeCustom];
 
        addFbtn.backgroundColor=[UIColor blueColor];
        
        [addFbtn setTitle:@"加为朋友" forState:UIControlStateNormal];
        [addFbtn addTarget:self action:@selector(addfriend:) forControlEvents:UIControlEventTouchUpInside];
        addFbtn.frame=CGRectMake(10, 0, self.view.width-20, 38);
        [_buttonview addSubview:addFbtn];
        
    }
    return  _buttonview;
}
-(void)addfriend:(UIButton*)sender{
    NSLog(@"添加朋友");
}
#pragma scrollview 
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat y=scrollView.contentOffset.y;
    if(y<0){
       // [self.tableview setHeight:self.tableview.height+ y];
        //[self.tableview setY:0];
     //   [self.bacview setHeight:200-y];
        //[self.bacimage setY:-y];
        
    }else{

//        [self.bacview setHeight:200-y];
//        [self.bacimage setHeight:200-y];
     //   [self.tableview setY:200-y];
     //   [self.bacimage setY:-y];
    }
}

#pragma tableview delegate and datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  4;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section==0){
        return 1;
    }
    else if(section==1){
        return  2;
    }else if(section==2){
        return 2;
    }else
    return  2;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section==2){
        return  60;
    }else
        return 44;
    
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section=indexPath.section;
    NSInteger row=indexPath.row;
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"person_cell"];
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"person_cell"];

    
    }
    if(section==0){
        if(row==0){
            UILabel* title= [[UILabel alloc]initWithFrame:CGRectMake(4, 2, 50, cell.contentView.height-4)];
            title.text=@"个性签名";
            title.textColor=[UIColor darkGrayColor];
            title.font=[UIFont systemFontOfSize:12 weight:1];
            [cell.contentView addSubview:title];
            
            UILabel* sign = [[UILabel alloc]initWithFrame:CGRectMake(60, 2, cell.contentView.width-65, cell.contentView.height-4)];
            sign.text=@"这家伙很懒，什么都没说···";
            sign.font=[UIFont systemFontOfSize:14];
            sign.textColor=[UIColor grayColor];
            [cell.contentView addSubview:sign];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
        }
    }else if(section==1){
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;

        if(row==0){
            UILabel* title= [[UILabel alloc]initWithFrame:CGRectMake(4, 2, 50, cell.contentView.height-4)];
            title.text=@"我的粉丝";
            title.textColor=[UIColor darkGrayColor];
            title.font=[UIFont systemFontOfSize:12 weight:1];
            [cell.contentView addSubview:title];
            
            UILabel* sign = [[UILabel alloc]initWithFrame:CGRectMake(60, 2, cell.contentView.width-65, cell.contentView.height-4)];
            sign.text=@"32";
            sign.font=[UIFont systemFontOfSize:14 weight:1.4];
            sign.textColor=[UIColor grayColor];
            [cell.contentView addSubview:sign];
            
        }else{
            
            UILabel* title= [[UILabel alloc]initWithFrame:CGRectMake(4, 2, 50, cell.contentView.height-4)];
            title.text=@"我的关注";
            title.textColor=[UIColor darkGrayColor];
            title.font=[UIFont systemFontOfSize:12 weight:1];
            [cell.contentView addSubview:title];
            
            UILabel* sign = [[UILabel alloc]initWithFrame:CGRectMake(60, 2, cell.contentView.width-65, cell.contentView.height-4)];
            sign.text=@"5";
            sign.font=[UIFont systemFontOfSize:14 weight:1.4];
            sign.textColor=[UIColor grayColor];
            [cell.contentView addSubview:sign];
            
        }
    }else if(section==2){
        UIImageView* albumIcon =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"huajie.png"]];
        albumIcon.frame=CGRectMake(8, 5, 50, 50);
        [cell.contentView addSubview:albumIcon];
        
        
        
        if(row==0){
            
        }else if(row==1)
        {
            
        }
    }
    
    return  cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return  0.1;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if(section==3)
        return nil;
    UIView* headearview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 20)];
    headearview.backgroundColor=[UIColor colorWithWhite:0.667 alpha:0.489];
    return  headearview;
}



@end
