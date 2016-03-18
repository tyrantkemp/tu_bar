//
//  ThirdViewController.m
//  tu_bar
//
//  Created by 肖准 on 15/9/28.
//  Copyright (c) 2015年 肖准. All rights reserved.
//

#import "ThirdViewController.h"
#define VIEW_W self.view.frame.size.width
#define VIEW_H self.view.frame.size.hight
#define DELETE_TAG 1

@interface ThirdViewController ()<UINavigationControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIActionSheetDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate,UIGestureRecognizerDelegate>

@property(nonatomic,strong)XZpicarr* picarr;
@property(nonatomic,strong)UIButton * newpic;
@property(nonatomic,assign)CGFloat staticy;
@property(nonatomic,assign)CGPoint viewcenter;
@property(nonatomic,strong)UIView* barview;
@property(nonatomic,strong)NSMutableArray* btnarr;
@property(nonatomic,assign)NSInteger toubedelete;
@property(nonatomic,strong)mypicCollectionReusableView* header;
@property(nonatomic,strong)NSString*PIC_ARR_KEY;
@end

@implementation ThirdViewController

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.picarr removeObserver:self forKeyPath:self.PIC_ARR_KEY context:nil];

}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.picarr addObserver:self forKeyPath:self.PIC_ARR_KEY options:NSKeyValueObservingOptionNew
     |NSKeyValueObservingOptionOld context:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.viewcenter=self.colview.center;
    NSLog(@"我的");
    self.toubedelete=-99;

    [self.colview setWidth:self.view.width];

    
    UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc]init];
    layout.scrollDirection=UICollectionViewScrollDirectionVertical;
    layout.itemSize=CGSizeMake(152, 113);

    layout.headerReferenceSize=CGSizeMake(self.view.frame.size.width, 300);
    
    self.navigationItem.title=@"";
    self.navigationController.navigationBar.barStyle=UIBarStyleBlackTranslucent;
    self.colview.showsVerticalScrollIndicator=NO;
    self.colview.showsHorizontalScrollIndicator=NO;
    self.colview.alwaysBounceVertical=YES;//数量不够一屏时也可以滑动
    self.colview.collectionViewLayout=layout;
    self.colview.delegate=self;
    self.colview.dataSource=self;
        [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
   
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getlib:) name:@"lib" object:nil];
    
    

    

    // Do any additional setup after loading the view.
}
-(XZpicarr*)picarr{
    if (_picarr==nil) {
        
        _picarr=[[XZpicarr alloc]init];
        _picarr.arr=[[NSMutableArray alloc]init];
        //加载相册
       // [_picarr getData];
    }
    return  _picarr;
}
-(NSString*)PIC_ARR_KEY{
    if (_PIC_ARR_KEY==nil) {
        _PIC_ARR_KEY=@"arr";
        
    }
    return  _PIC_ARR_KEY;
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if([keyPath isEqualToString:self.PIC_ARR_KEY]){
        NSLog(@"相册发生了变化！！");
        ((BarButton*)(self.btnarr[0])).lab.text=[NSString stringWithFormat:@"%d",self.picarr.arr.count];

        //[self.picarr saveData];
        [self.colview reloadData];
    }
}


-(void)getlib:(NSNotification*)noti{
    [[self.picarr mutableArrayValueForKey:self.PIC_ARR_KEY] addObject:noti.object];
  //  [self.piclibarr addObject:noti.object];
    NSLog(@"获得相册");
    
}
-(UIView*)barview{
    if(_barview==nil){
        
        _barview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
        _barview.backgroundColor=[UIColor colorWithWhite:0.000 alpha:0.460];
//        _barview.alpha=0.5;
        
        
        for (int j=0; j<4; ++j) {
            [_barview addSubview:self.btnarr[j]];
        }
        
        
    }
    return  _barview;
    
}
-(NSMutableArray*)btnarr{
    if(_btnarr==nil){
        _btnarr=[[NSMutableArray alloc]initWithCapacity:4];
        NSInteger wi=floorf(VIEW_W/4);
        for(int i=0;i<4;++i){
            
            CGRect frame=CGRectMake(wi*i, 0, VIEW_W/4, 50);
            NSString* title = @"";

                        switch (i) {
                            case 0:
                                title=@"收藏";
                                break;
            
                            case 1:
                                title=@"好友";
                                break;
                            case 2:
                                title=@"粉丝";
                                break;
                            case 3:
                                title=@"发布";
                                break;
                            default:
                                break;
                        }
            BarButton* btn=[[BarButton alloc]initWithFrameAndTile:frame title:title];
  
            [btn addTarget:self action:@selector(btnpressed:) forControlEvents:UIControlEventTouchUpInside];
            
            [_btnarr addObject:btn];
            
            
        }

        
    }

    return  _btnarr;
    
}
-(void)btnpressed:(id)sender{
    
    BarButton* btn=(BarButton*)sender;

    NSString* typestr=btn.title.text;
    if ([typestr isEqualToString:@"收藏"]) {
        
    }else if([typestr isEqualToString:@"好友"]){
        
    }else if([typestr isEqualToString:@"粉丝"]){
        
    }else if([typestr isEqualToString:@"发布"]){
        PublishViewController* ctl =[[PublishViewController alloc]init];
//        CATransition* transition = [CATransition animation];
//        transition.type = kCATransitionPush;//可更改为其他方式
//        transition.subtype = kCATransitionFromTop;//可更改为其他方式
//        [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
//        
 //       [self.navigationController pushViewController:ctl animated:NO];
   
        UINavigationController* navi  = [[UINavigationController alloc]initWithRootViewController:ctl];
        [self presentViewController:navi animated:YES completion:nil];
    }
    
}


-(UIStatusBarStyle)preferredStatusBarStyle{
    return  UIStatusBarStyleLightContent;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    NSLog(@"offset:%@",NSStringFromCGPoint(self.colview.contentOffset));
    if(self.colview.contentOffset.y<-64){
        
        
    }
   // self.headbac.center=CGPointMake(self.view.frame.size.width/2, 90-self.colview.contentOffset.y);

  
}
-(UICollectionReusableView *) collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{

    UICollectionReusableView* view=nil;
    if(kind==UICollectionElementKindSectionHeader){
        self.header=[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"picheader" forIndexPath:indexPath];

        [self.header setWidth:self.view.width];
        
        LBorderView* addview = [[LBorderView alloc] init ];
        [addview setBounds:CGRectMake(0, 0, self.view.width-10, self.header.newpic.frame.size.height)];
      //  addview.center=CGPointMake(self.view.width/2, self.header.newpic.center.y);
        [addview setCenter:self.header.newpic.center];
        [addview setCenterX:self.view.width/2-10];
        addview.cornerRadius = 5;
        addview.borderType = BorderTypeDashed;
        addview.borderWidth = 1.5;
        addview.borderColor = [UIColor grayColor];
        addview.dashPattern = 5;
        addview.backgroundColor=[UIColor clearColor];
        addview.spacePattern = 5;
        
        [self.barview setFrame:CGRectMake(0, self.header.headbac.frame.size.height-50, self.view.frame.size.width, 50)];
        
        UITapGestureRecognizer* bactap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bactap:)];
        self.header.headbac.backgroundColor=[UIColor blueColor];
        self.header.headbac.userInteractionEnabled=YES;
    
        UIImage* bacimg = [UIImage imageWithData:[[NSUserDefaults standardUserDefaults] objectForKey:USER_BACIMG]];
        self.header.headbac.image=bacimg;
        [self.header.headbac addGestureRecognizer:bactap];
        
        UIImageView* userIcon=[[UIImageView alloc]initWithFrame:CGRectZero];
        userIcon.bounds=CGRectMake(0, 0, 60, 60);
        userIcon.center=CGPointMake(VIEW_W/2, self.header.headbac.frame.size.height/2+10);
        userIcon.layer.cornerRadius=30;
        userIcon.layer.masksToBounds=YES;
        userIcon.userInteractionEnabled=YES;
        userIcon.backgroundColor=[UIColor grayColor];
        userIcon.image=[UIImage imageNamed:@"xiaozhun.jpg"];
    
        UITapGestureRecognizer* icontap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(icontap:)];
        [userIcon addGestureRecognizer:icontap];
        
        [self.header.headbac addSubview:userIcon];
        
        
        [self.header.headbac addSubview:self.barview];
        [self.header.headbacview insertSubview:addview belowSubview:self.header.newpic];
        [self.view bringSubviewToFront:self.header];

        [self.view addSubview:self.header];
        view=self.header;
    
    
        
    }
    
    return view;
}

#pragma mark - 点击头像
-(void)icontap:(UITapGestureRecognizer*)tap{
    
    UIActionSheet * sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"更换头像",@"查看头像", nil];
    sheet.tag=0;
    [sheet showInView:self.view];
}

#pragma mark - 点击背景
-(void)bactap:(UITapGestureRecognizer*)tap{
    NSLog(@"backimage tap");
    UIActionSheet * sheet = [[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"更换背景",@"查看背景", nil];

    sheet.tag=1;
    [sheet showInView:self.view];
    
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    switch (actionSheet.tag) {
        case 0:
        {
            if(buttonIndex == 0){
                
                NSLog(@"更换头像");
                
                [self changebac];
            }else if(buttonIndex ==1){
                NSLog(@"查看头像");
                [self showbac];
            }else if(buttonIndex==2){
                NSLog(@"取消");
                
            }
        
        }
            break;
        case 1:
        {
            if(buttonIndex == 0){
                
                NSLog(@"更换背景");
                
                [self changebac];
            }else if(buttonIndex ==1){
                NSLog(@"查看背景");
                [self showbac];
            }else if(buttonIndex==2){
                NSLog(@"取消");
                
            }
        }
            break;
        default:
            break;
    }
    
    
    
}

#pragma mark - 打开相册操作
-(void)showbac{
    NSLog(@"showbac");
}

-(void)changebac{
    UIImagePickerController *pickerImage = [[UIImagePickerController alloc] init];
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        pickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //pickerImage.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];
        
    }
    pickerImage.delegate = self;
    pickerImage.allowsEditing = YES;
    
    [self presentViewController:pickerImage animated:YES
                     completion:^{
                         
                     }];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"选择完成,%@",info);
        UIImage* bacimg = (UIImage*)info[UIImagePickerControllerOriginalImage];
        [self.header.headbac setImage:bacimg];
        
        NSData* imgdata = UIImageJPEGRepresentation(bacimg, 1.0);
        
   
        [[NSUserDefaults standardUserDefaults]setObject:imgdata forKey:USER_BACIMG];
    }];
}


#pragma mark- collecitonview 操作
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.picarr.arr.count;
    
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return  1;
}


-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
        mypicCollectionViewCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"mypiccell" forIndexPath:indexPath];
        ALAsset *asset =self.picarr.arr[indexPath.row][@"picset"][0];
        CGImageRef ratioThum = [asset aspectRatioThumbnail];
        UIImage* rti = [UIImage imageWithCGImage:ratioThum];
    
    
 
        cell.picname.font=[UIFont systemFontOfSize:12 ];
        cell.picnumber.font=[UIFont systemFontOfSize:12 ];

    
    
        cell.picnumber.text=[NSString stringWithFormat:@"%d张",[self.picarr.arr[indexPath.row][@"picset"] count]];
        cell.picname.text=self.picarr.arr[indexPath.row][@"name"];
        cell.pic.image=rti;
    
    
    
    //长按删除
    
    UILongPressGestureRecognizer* longgs=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longpress:)];
    [cell addGestureRecognizer:longgs];
    longgs.minimumPressDuration=1.0;
    longgs.view.tag=indexPath.row;
    return  cell;
        
 
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    
    ShowPicViewController* ct=[[ShowPicViewController alloc]init];
    ct.dict=self.picarr.arr[indexPath.row];
//    [ct setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
    UINavigationController* navi =[[UINavigationController alloc]initWithRootViewController:ct];
//    [self presentViewController:navi animated:YES completion:^{
//    
//        NSLog(@"展现相册:%d",indexPath.row);
//    }];
//    [self presentModalViewController:navi animated:YES];
    [self presentViewController:navi animated:YES completion:^{
        ct.navigationController.navigationItem.title=ct.dict[@"name"];
    }];
}
-(void)longpress:(UILongPressGestureRecognizer*)ges{
    if(ges.state==UIGestureRecognizerStateBegan){
        self.toubedelete=ges.view.tag;

        NSLog(@"长按，删除！！%d",ges.view.tag);
        UIAlertView* alter=[[UIAlertView alloc ]initWithTitle:nil message:@"确定要删除？" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"删",@"算了吧", nil];
        
        alter.delegate=self;
        alter.tag=DELETE_TAG;
        [alter show];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==0){
        NSLog(@"删");
        [[self.picarr mutableArrayValueForKey:self.PIC_ARR_KEY] removeObjectAtIndex:self.toubedelete];
//        [self.piclibarr removeObjectAtIndex:self.toubedelete];
        
        if(self.picarr.arr.count>1){
        NSIndexPath *index =[NSIndexPath indexPathForRow:self.toubedelete inSection:0];
        NSArray* deletearr=@[index];
            [self.colview deleteItemsAtIndexPaths:deletearr];
        }else{
            [self.colview reloadData];

        }
    }else if(buttonIndex ==1){
        NSLog(@"算了吧");

    }
}
//返回每个collectioncell的inset
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(3, 3, 3, 3);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
  //  [self.picarr removeObserver:self forKeyPath:self.PIC_ARR_KEY context:nil];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
