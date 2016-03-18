//
//  SecondViewController.m
//  tu_bar
//
//  Created by 肖准 on 15/9/28.
//  Copyright (c) 2015年 肖准. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate,UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,QCheckBoxDelegate>
// 照相
@property(nonatomic,strong )UIImagePickerController* imagePicker;
@property(nonatomic,assign)BOOL isVideo;

//图片
@property(nonatomic,strong)UIImageView* selectedpic;
@property(nonatomic,copy)NSString* localurl;

// 图片描述
@property(nonatomic,strong)UITextView* tvview;
@property(nonatomic,strong)UILabel* uilabel;
//图片-照相 功能按钮
@property(nonatomic,strong)UIView* btnview;

@property(nonatomic,strong)UITableView* tbview;
@property(nonatomic,strong)UIView*headerview;
@property(nonatomic,strong)UIImage* localimg;
//个人相册信息
@property(nonatomic,strong)AlbumArr* albumArr;
@property(nonatomic,strong)Album* addalbum;

@property(nonatomic,assign)NSInteger rownumer;


//上一次选中的cell index
@property(nonatomic,assign)NSInteger selectedrow;
//模态
//@property(nonatomic,strong)ModalUIView*modalview;
@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad]; [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getalbum:) name:@"lib" object:nil];
    self.isVideo=NO;
    self.albumArr=[Utils getAlbumarrFromString:[Utils UserDefaultGetValueByKey:USER_ALBUMS]];
    
    self.view.backgroundColor =[UIColor colorWithRed:0.873 green:0.968 blue:0.951 alpha:1.000];
    NSLog(@"albumarr:%@,number:%d",self.albumArr,self.albumArr.albarr.count);
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"退出" style:UIBarButtonItemStylePlain target:self action:@selector(quit:)];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"发布" style:UIBarButtonItemStylePlain target:self action:@selector(add:)];
    
    [self.view addSubview:self.tbview];
    //[self.view addSubview:self.tvview];
    [self.view addSubview:self.btnview];
    //[self presentViewController:self.imagePicker animated:YES completion:nil];
    
    
    // Do any additional setup after loading the view.
}
#pragma mark - 初始化
-(UITableView*)tbview{
    if(_tbview==nil){
        _tbview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, self.view.width, self.view.height-120)];
        _tbview.backgroundColor=[UIColor colorWithRed:0.873 green:0.968 blue:0.951 alpha:1.000];
        _tbview.separatorStyle=UITableViewCellSeparatorStyleNone;
        _tbview.delegate=self;
        _tbview.dataSource=self;
        _tbview.tableHeaderView=self.headerview;
        
    }
    return  _tbview;
}
-(Album*)addalbum{
    if(_addalbum==nil){
        _addalbum=nil;
    }
    return  _addalbum;
    
}

-(UIView*)headerview{
    if(_headerview==nil){
        _headerview=[[UIView alloc]init];
        _headerview.bounds = CGRectMake(0, 0, self.view.width, self.tvview.height+10);
        
        _headerview.userInteractionEnabled=YES;
        [_headerview addSubview:self.tvview];
    }
    return  _headerview;
}


-(UITextView*)tvview{
    if (_tvview==nil) {
        _tvview=[[UITextView alloc]init];
        _tvview.tag=-99;
        _tvview.frame=CGRectMake(10, 5, self.view.width-20, 100);
        _tvview.backgroundColor=[UIColor colorWithRed:0.927 green:0.927 blue:0.696 alpha:1.000];
        _tvview.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _tvview.delegate=self;
        
        self.uilabel = [[UILabel alloc]init];
        self.uilabel.frame =CGRectMake(3,5,_tvview.width, 20);
        self.uilabel.font=[UIFont systemFontOfSize:13];
        self.uilabel.text = @"请填写图片描述...";
        self.uilabel.enabled = NO;//lable必须设置为不可用
        self.uilabel.backgroundColor = [UIColor clearColor];
        [_tvview addSubview:self.uilabel];
        
    }
    return _tvview;
}


-(UIView*)btnview{
    if(_btnview==nil){
        _btnview=[[UIView alloc]initWithFrame:CGRectMake(0, self.view.height-44, self.view.width, 44)];
        _btnview.backgroundColor=[UIColor colorWithWhite:0.667 alpha:0.546];
        _btnview.userInteractionEnabled=YES;
        UIButton* picbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [picbtn  setImage:[UIImage imageNamed:@"pic.png"] forState:UIControlStateNormal];
        picbtn.bounds=CGRectMake(0, 0, 44, 44);
        picbtn.center=CGPointMake(self.view.width/4, 22);
        [picbtn addTarget:self action:@selector(addpic:) forControlEvents:UIControlEventTouchUpInside];
        
        
        UIButton* cabtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [cabtn  setImage:[UIImage imageNamed:@"camera.png"] forState:UIControlStateNormal];
        
        cabtn.bounds=CGRectMake(0, 0, 44, 44);
        cabtn.center=CGPointMake(self.view.width/4*3, 22);
        [cabtn addTarget:self action:@selector(addca:) forControlEvents:UIControlEventTouchUpInside];
        
        [_btnview addSubview:picbtn];
        [_btnview addSubview:cabtn];
        
    }
    return _btnview;
}

-(UIImagePickerController *)imagePicker{
    if (!_imagePicker) {
        _imagePicker=[[UIImagePickerController alloc]init];
        _imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;//设置image picker的来源，这里设置为摄像头
        _imagePicker.cameraDevice=UIImagePickerControllerCameraDeviceRear;//设置使用哪个摄像头，这里设置为后置摄像头
        if (self.isVideo) {
            _imagePicker.mediaTypes=@[(NSString*)kUTTypeMovie];
            _imagePicker.videoQuality=UIImagePickerControllerQualityTypeIFrame1280x720;
            _imagePicker.cameraCaptureMode=UIImagePickerControllerCameraCaptureModeVideo;//设置摄像头模式（拍照，录制视频）
            
        }else{
            _imagePicker.cameraCaptureMode=UIImagePickerControllerCameraCaptureModePhoto;
        }
        _imagePicker.allowsEditing=YES;//允许编辑
        _imagePicker.delegate=self;//设置代理，检测操作
    }
    return _imagePicker;
}


#pragma mark - tableview 生成及操作
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  1;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger rownumber =2+(self.albumArr.albarr.count);
    self.rownumer=rownumber;
    return rownumber;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==0){
        return  self.selectedpic==nil?50:self.selectedpic.height+10;
    }else {
        return  50;
    }
    
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return  YES;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(editingStyle==UITableViewCellEditingStyleDelete){
        NSLog(@"删除");
        self.selectedpic=nil;
        [self.tbview deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
    }
    
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    if(indexPath.row==0){
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"seceond_pic_cell"];
        
        if(cell==nil){
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"seceond_pic_cell"];
            cell.selectionStyle=UITableViewCellSelectionStyleNone;
            cell.contentView.backgroundColor=[UIColor clearColor];
            cell.backgroundColor=[UIColor clearColor];
        }
        for (int i =0 ; i<[cell.contentView.subviews count]; ++i) {
            UIView* view =cell.contentView.subviews[i];
            [view removeFromSuperview];
        }
        
        if(self.selectedpic==nil){
            return cell;
        }else{
            [cell.contentView addSubview:self.selectedpic];
            return  cell;
            
        }
        
    }else if(indexPath.row==self.rownumer-1){
        
        
        UITableViewCell* cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"add_pic_cell"];
        UIButton* addbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [addbtn setTitle:@"新建相册" forState:UIControlStateNormal];
        [addbtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [addbtn addTarget:self action:@selector(addalbum:) forControlEvents:UIControlEventTouchUpInside];
        addbtn.bounds=CGRectMake(0, 0, self.view.width-10, 40);
        addbtn.center=CGPointMake(self.view.width/2, 25);
        
        addbtn.backgroundColor=[UIColor clearColor];
        LBorderView* addview = [[LBorderView alloc] init ];
        // [addview setBounds:CGRectMake(0, 0, self.view.width-10,48)];
        //  addview.center=CGPointMake(self.view.width/2, self.header.newpic.center.y);
        //[addview setCenter:self.header.newpic.center];
        
        
        //[addview setCenterX:self.view.width/2-10];
        addview.bounds=CGRectMake(0, 0, self.view.width-10, 40);
        addview.center=CGPointMake(self.view.width/2, 25);
        
        addview.cornerRadius = 0.5;
        addview.borderType = BorderTypeDashed;
        addview.borderWidth = 1.5;
        addview.borderColor = [UIColor grayColor];
        addview.dashPattern = 5;
        addview.backgroundColor=[UIColor clearColor];
        addview.spacePattern = 5;
        addview.backgroundColor=[UIColor clearColor];
        cell.backgroundColor=[UIColor clearColor];
        
        [addview addSubview:addbtn];
        cell.contentView.backgroundColor=[UIColor clearColor];
        
        [cell.contentView addSubview:addview];
        
        return cell;
        
    }else{
        
        Album* al = self.albumArr.albarr[indexPath.row-1];
        
        
        AlbumCell* cell = [[AlbumCell alloc]initWithStyleAndAlbumInfo:UITableViewCellStyleDefault reuseIdentifier:@"album_cell" album:al];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        QCheckBox* check = [[QCheckBox alloc]initWithDelegate:self];
        check.bounds=CGRectMake(0, 0, 20, 40);
        check.center  = CGPointMake(self.view.width-20, 25);
        [cell.contentView addSubview:check];
        [check setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [check setTitleColor:[UIColor greenColor] forState:UIControlStateHighlighted];
        [check setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
        [check.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
        [check setImage:[UIImage imageNamed:@"uncheck_icon.png"] forState:UIControlStateNormal];
        [check setImage:[UIImage imageNamed:@"check_icon.png"] forState:UIControlStateSelected];
        [check setChecked:NO];
        cell.checkbox=check;
        
        //=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"huajie1.png"]];
        return  cell;
    }
    
    
    
}
#pragma mark QCheckBoxDelegate

- (void)didSelectedCheckBox:(QCheckBox *)checkbox checked:(BOOL)checked {
    //NSLog(@"did tap on CheckBox:%@ checked:%d", checkbox.titleLabel.text, checked);
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   //保证相册选择的唯一性
    if(indexPath.row!=0 &&  indexPath.row!=self.rownumer-1){
        NSLog(@"selceted:%d",indexPath.row);
        if(self.selectedrow!=0){
            if (self.selectedrow!=indexPath.row) {
                NSIndexPath* path=[NSIndexPath indexPathForRow:self.selectedrow inSection:0];
                AlbumCell *cell= [self.tbview cellForRowAtIndexPath:path];
                [cell.checkbox setChecked:false];
            }
        }

        AlbumCell *cell= [self.tbview cellForRowAtIndexPath:indexPath];
        [cell.checkbox setChecked:!cell.checkbox.checked];
        self.selectedrow=indexPath.row;
        
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 键盘改动的时候其他view随着变化
-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"viewwillApppear");
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
   
}

-(void)keyboardShow:(NSNotification *)note
{
    CGRect keyBoardRect=[note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat deltaY=keyBoardRect.size.height;
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        self.btnview.transform=CGAffineTransformMakeTranslation(0, -deltaY);
    }];
    // self.isKeyShown=YES;
}
-(void)keyboardHide:(NSNotification *)note
{
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue] animations:^{
        self.btnview.transform = CGAffineTransformIdentity;
    }];
    //  self.isKeyShown=NO;
    
}//点击返回键

#pragma mark - uitextview 操作
-(void)textViewDidChange:(UITextView *)textView
{
    self.tvview.text =  textView.text;
    if (textView.text.length == 0) {
        self.uilabel.text = @"请填写图片描述...";
    }else{
        self.uilabel.text = @"";
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]){ //判断输入的字是否是回车，即按下return
        [self.view endEditing:YES];
        return NO; //这里返回NO，就代表return键值失效，即页面上按下return，不会出现换行，如果为yes，则输入页面会换行
    }
    return YES;
}


#pragma mark - 打开相册操作
-(void)addpic:(id)sender{
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
        // self.localurl =(NSString *)[info valueForKey:UIImagePickerControllerReferenceURL];
        
        
        UIImage* bacimg = (UIImage*)info[UIImagePickerControllerOriginalImage];
        UIImage* newim=[bacimg getNewImageByNewSzie:CGSizeMake(self.view.width-16,(self.view.width-16)*(bacimg.size.height/bacimg.size.width))];
        
        self.localimg= bacimg;
        //NSData* imgdata = UIImageJPEGRepresentation(bacimg, 1.0);
        self.selectedpic=[[UIImageView alloc]initWithImage:newim];
        //CGFloat min = MIN(newim.size.width, newim.size.height);
        self.selectedpic.frame=CGRectMake(8, 5, newim.size.width, newim.size.height);
        
        
        [self.tbview reloadData];
        //[self.view addSubview:self.selectedpic];
        
        
    }];
}


#pragma mark - 其他操作
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch* touch = [touches anyObject];
    if([touch view].tag!=-99){
        [self.view endEditing:YES];
    }
}
//tabbarview不同页面之间的切换
-(void)quit:(id)sender{
    NSLog(@"退出");
    [self.view endEditing:YES];
    UIView* fromview=[self.tabBarController.selectedViewController view];
    UIView* toview=[[self.tabBarController.viewControllers objectAtIndex:0] view];
    [UIView transitionFromView:fromview toView:toview duration:0.5 options:UIViewAnimationOptionTransitionFlipFromRight completion:^(BOOL finished) {
        if(finished){
            [self.tabBarController setSelectedIndex:0];
            self.uilabel.text = @"请填写图片描述...";
            self.selectedpic=nil;
            [self.tbview reloadData];
        }
    }];
    
}
#pragma mark 发布照片
-(void)add:(id)sender{
    NSLog(@"发布");
    if(self.selectedpic==nil){
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"请选择照片" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag=0;
        [alert show];
    }else {
        //通过模态窗口 选择指定相册
        
        
        
        //        ModalViewController* ctl = [[ModalViewController alloc]init];
        //
        //        [self presentViewController:ctl animated:YES completion:^{
        //
        //        }];
        //        self.modalview = [[ModalUIView alloc]initWithBounds:CGRectMake(0, 0, 200, 300)];
        //        self.modalview.center=CGPointMake(self.view.width/2, self.view.height+150);
        //        self.modalview.backgroundColor=[UIColor whiteColor];
        //        //[self.view addSubview:modalview];
        //
        //
        //        UIButton* quitbtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //        [quitbtn setTitle:@"X" forState:UIControlStateNormal];
        //        [quitbtn setTitleColor:[UIColor colorWithRed:0.173 green:0.577 blue:0.904 alpha:1.000] forState:UIControlStateNormal];
        //        quitbtn.frame=CGRectMake(5, 5, 20, 20);
        //        [quitbtn addTarget:self action:@selector(btnquit:) forControlEvents:UIControlEventTouchUpInside];
        //
        //        [self.modalview addSubview:quitbtn];
        //        [self.view addSubview:self.modalview];
        //        [UIView animateWithDuration:.5 animations:^{
        //
        //            self.modalview.center=CGPointMake(self.view.width/2, self.view.height/2);
        //        } completion:^(BOOL finished) {
        //
        //        }];
            UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"确定发布？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                alert.tag=1;
            [alert show];
    }
    [self.view endEditing:YES];
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.tag==0){
        
    }else if(alertView.tag==1){
        if (buttonIndex==1) {
            NSLog(@"确认发布");
            [ProgressHUD show:@"发布ing"];
            //所选img保存到自建相册，并将imgid和localurl写入img.plist中转文件
            [Utils saveImgtoAlbum:self.localimg com:^(NSURL *url) {
                NSString* imgid = [Utils getImgid:url];
              
                
                //选中图片id及本地路径保存入img.plist文件
                [Utils writeToimgPlist:imgid imgLocalUrl:url imgUrl:@"312"];
                
                
                //更新相册信息
                NSIndexPath* path = [NSIndexPath indexPathForRow:self.selectedrow inSection:0];
                AlbumCell *cell= [self.tbview cellForRowAtIndexPath:path];
                [Utils saveImgIdtoAlbum:imgid albumname:cell.albumname.text];
                
                //异步上传服务器（照片及照片信息）
                [Utils uploadImgToServerWithImageidAndUsername:self.localimg withImageId:imgid];
                
                
                
                [ProgressHUD dismiss];
                [self quit:nil];
                
            }];
            
        }
    }
}



-(void)addca:(id)sender{
    NSLog(@"拍照获取照片");
}

//新建相册
-(void)addalbum:(id)sender{
    
    AddPicViewController* actl = [[AddPicViewController alloc]init];
    [self presentViewController:actl animated:YES completion:nil];
    
}
//getalbu
-(void)getalbum:(NSNotification*)noti{
    //  [self.piclibarr addObject:noti.object];
    NSDictionary* doc = noti.object;
    NSLog(@"doc:%@",doc);
    NSString* name = [doc objectForKey:@"name"];
    NSArray* arr = [doc objectForKey:@"picset"];
    
    self.addalbum =[[Album alloc]initWithParams:name holderimgid:nil imgids:nil];

 //   self.addalbum.albumname=name;
 //   self.addalbum.imgids=arr;
    [self.albumArr.albarr addObject:self.addalbum];
    
    //保存修改的相册信息
    [Utils saveAlbumarr:self.albumArr];
    
   [self.tbview reloadData];
    NSLog(@"获得相册,%@",noti.object);
    
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
