//
//  AddPicViewController.m
//  tu_bar
//
//  Created by 肖准 on 15/10/10.
//  Copyright © 2015年 肖准. All rights reserved.
//

#import "AddPicViewController.h"
#define BAC_H self.view.frame.size.height*1/3
@interface AddPicViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIAlertViewDelegate,UITableViewDataSource,UITableViewDelegate,ASIHTTPRequestDelegate,NSXMLParserDelegate>

//上半部分背景视图
@property(nonatomic,strong)UIImageView* bacview;

//返回主页面按钮
@property(nonatomic,strong)UIButton* bacbtn;

//相册名的输入textfield
@property(nonatomic,strong)UITextField* name;
//相册名字的输入textfiel的外围视图
@property(nonatomic,strong)LBorderView* picnameview;


//更改相册封面按钮
@property(nonatomic,strong)LBorderView* changebacview;
//添加图片的“+”号按钮
@property(nonatomic,strong)LBorderView* addview;



@property(nonatomic,strong)NSMutableArray* addedpicset;

@property(nonatomic,strong)UITableView* table;
//完成按钮
@property(nonatomic,strong)UIButton * donebtn;

@property(nonatomic,strong)NSMutableArray* picarrtobeupload; //

@end

@implementation AddPicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor lightGrayColor];
    [self.view addSubview:self.bacview];
    //[self.view addSubview:self.addview];
    [self.view addSubview:self.donebtn];
    [self.view addSubview:self.table];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showadded:) name:@"add" object:nil];

    [self.table registerNib:[UINib nibWithNibName:@"PicTableViewCell" bundle:nil] forCellReuseIdentifier:@"piccell"];
    [self.table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"blank"];
    // Do any additional setup after loading the view.
}

#pragma  mark 初始化
-(NSMutableArray*)picarrtobeupload{
    if(_picarrtobeupload==nil){
        _picarrtobeupload = [[NSMutableArray alloc]init];
    }
    return  _picarrtobeupload;
}

-(UITableView*)table{
    
    if(_table==nil){
        _table=[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _table.frame=CGRectMake(0, BAC_H+5, self.view.frame.size.width, self.view.frame.size.height- BAC_H-5-44);
        _table.backgroundColor=[UIColor clearColor];
        _table.delegate=self;
        _table.dataSource=self;
        
    }
    return  _table;
}

-(UIImageView*)bacview{
    if(_bacview==nil){
        _bacview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, BAC_H)];
        _bacview.backgroundColor=[UIColor colorWithWhite:0.851 alpha:1.000];
        _bacview.userInteractionEnabled=YES;
        
        self.bacbtn=[UIButton buttonWithType:UIButtonTypeCustom];
        
        self.bacbtn.frame=CGRectMake(10, 20, 50, 30);
        [self.bacbtn setTitle:@"取消" forState:UIControlStateNormal];
        [self.bacbtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [self.bacbtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
        
        [_bacview addSubview:self.picnameview];
        [_bacview addSubview:self.bacbtn];
        [_bacview addSubview:self.changebacview];
        
    }
    return  _bacview;
    
}
-(LBorderView*)picnameview{
    if(_picnameview==nil){
        _picnameview = [[LBorderView alloc] init ];
        _picnameview.bounds=CGRectMake(0, 0, 250, 40);
        _picnameview.center=CGPointMake(self.view.frame.size.width/2, BAC_H-95);
        _picnameview.cornerRadius = 10;
        _picnameview.borderType = BorderTypeDashed;
        _picnameview.borderWidth = 1;
        _picnameview.borderColor = [UIColor whiteColor];
        _picnameview.dashPattern = 5;
        _picnameview.backgroundColor=[UIColor clearColor];
        _picnameview.spacePattern = 5;
        
        NSString* holderstr=@"新建相册名";
        
        self.name= [[UITextField alloc]init];
        //   self.name.frame=CGRectMake(self.view.frame.size.width/2, 5, 40, 30);
        self.name.textAlignment=NSTextAlignmentCenter;
        [self.name setTextColor:[UIColor whiteColor]];
        self.name.placeholder=holderstr;
        self.name.font=[UIFont boldSystemFontOfSize:16];
        self.name.backgroundColor=[UIColor clearColor];
        CGSize size = [holderstr sizeWithFont:self.name.font constrainedToSize:CGSizeMake(MAXFLOAT, self.name.frame.size.height)];
        [self.name setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
        
        //self.name.bounds=CGRectMake(0, 0, size.width, 30);
        //self.name.center=CGPointMake(self.view.width/2, BAC_H-95);
        [self.name setFrame:CGRectMake(_picnameview.width/2-size.width/2, 5, size.width, 30)];
        [_picnameview addSubview:self.name];
        
    }
    return  _picnameview;
}

-(LBorderView*)changebacview{
    if(_changebacview==nil){
        _changebacview = [[LBorderView alloc] init ];
        _changebacview.bounds=CGRectMake(0, 0, 70, 30);
        _changebacview.center=CGPointMake(self.view.frame.size.width/2, BAC_H-40);
        _changebacview.cornerRadius = 5;
        _changebacview.borderType = BorderTypeDashed;
        _changebacview.borderWidth = 1;
        _changebacview.borderColor = [UIColor whiteColor];
        _changebacview.dashPattern = 5;
        _changebacview.backgroundColor=[UIColor clearColor];
        _changebacview.spacePattern = 0;
        
        
        UIButton* changebtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [changebtn setFrame:CGRectMake(0, 0, 70, 30)];
        [changebtn setTitle:@"更改封面" forState:UIControlStateNormal];
        changebtn.titleLabel.font=[UIFont systemFontOfSize:13];
        
        [changebtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [changebtn addTarget:self action:@selector(changebac:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [_changebacview addSubview:changebtn];
        
    }
    return  _changebacview;
    
    
}


-(LBorderView*)addview{
    if(_addview==nil){
        _addview = [[LBorderView alloc] init ];
        //        _addview.bounds=CGRectMake(0, 0, self.view.frame.size.width-10, 100);
        //        _addview.center=CGPointMake(self.view.frame.size.width/2, 320);
        _addview.frame=CGRectMake(0, 5, self.view.frame.size.width, 90);
        _addview.cornerRadius = 20;
        _addview.borderType = BorderTypeDashed;
        _addview.borderWidth = 1;
        _addview.borderColor = [UIColor grayColor];
        _addview.dashPattern = 5;
        _addview.backgroundColor=[UIColor clearColor];
        _addview.spacePattern = 5;
        _addview.userInteractionEnabled=YES;
        
        UIButton* addbtn=[UIButton buttonWithType:UIButtonTypeContactAdd];
        //        addbtn.bounds=_addview.bounds;
        //        addbtn.center=_addview.center;
        [addbtn setFrame:CGRectMake(0, 0, _addview.frame.size.width, _addview.frame.size.height)];
        [addbtn addTarget:self action:@selector(addpic:) forControlEvents:UIControlEventTouchUpInside];
        
        [_addview addSubview:addbtn];
        
    }
    return  _addview;
    
}

-(void)showadded:(NSNotification*)noti{
    self.addedpicset=noti.object;
    NSLog(@"addedpic:%@",self.addedpicset);
    [self.table reloadData];
}

-(UIButton*)donebtn{
    if(_donebtn==nil){
        _donebtn=[UIButton buttonWithType:UIButtonTypeCustom];
        [_donebtn setFrame:CGRectMake(0, self.view.frame.size.height-44, self.view.frame.size.width, 44)];
        [_donebtn setBackgroundColor:[UIColor orangeColor]];
        [_donebtn setTitle:@"完成" forState:UIControlStateNormal];
        [_donebtn addTarget:self action:@selector(donepressed:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return  _donebtn;
    
}

#pragma mark  - uitableview delegate & datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  1;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  self.addedpicset?self.addedpicset.count*2-1:0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return (indexPath.row%2==1)?5:80;
}
-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView* foot= [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
    [foot addSubview:self.addview];
    return foot;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if(indexPath.row%2==1){
    
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"blank" forIndexPath:indexPath];
        
        if(!cell){
            
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"blank"];
         
            cell.backgroundColor=[UIColor lightGrayColor];
            cell.userInteractionEnabled=NO;
        }
        return  cell;
        
        
    }else{
    PicTableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:@"piccell" forIndexPath:indexPath];
    
    ALAsset *asset =self.addedpicset[indexPath.row/2];
    CGImageRef ratioThum = [asset aspectRatioThumbnail];
    UIImage* rti = [UIImage imageWithCGImage:ratioThum];

        if(indexPath.row==0){
            self.bacview.image=rti;
        }
    cell.pic.image=rti;
        [self.picarrtobeupload addObject:rti];
    
//    cell.pic.backgroundColor=[UIColor orangeColor];
        return  cell;
    
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return  0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 100;
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return  YES;
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"删除");
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
#pragma  mark - 视图设置
-(UIStatusBarStyle) preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

#pragma  mark - 选择从本身相册还是拍照选取照片
-(void)addpic:(id)sender{
    NSLog(@"创建相册");
    UIAlertView* alert=[[UIAlertView alloc ]initWithTitle:nil message:nil delegate:self cancelButtonTitle:@"算了"
      otherButtonTitles:@"来一张",@"从相册选取", nil];
    [alert show];
}

#pragma  mark  alertview delegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if(buttonIndex==0){
        if(alertView.tag==99){
            
            NSLog(@"已存在该相册名");
            self.name.text=@"";
            [self.name becomeFirstResponder];
        }
    }else if(buttonIndex==1){
        
            NSLog(@"来一张");

            
        
        
    }else if(buttonIndex ==2){
        NSLog(@"从相册选取");
        
//        UIImagePickerController *pickerImage = [[UIImagePickerController alloc] init];
//        
//        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
//            pickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//            //pickerImage.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
//            pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];
//            
//        }
//        pickerImage.view.tag=2;
//
//        pickerImage.delegate = self;
//        pickerImage.allowsEditing = NO;
//        
//        [self presentViewController:pickerImage animated:YES
//                         completion:^{
//                             NSLog(@"打开相册,%@",pickerImage.mediaTypes);
//                             
//                         }];

        MShowGroupVc* vc = [[MShowGroupVc alloc]init];
        UINavigationController* navi = [[UINavigationController alloc]initWithRootViewController:vc];
        [self presentViewController:navi animated:YES completion:^{
            NSLog(@"进入相册");
        }];
    
    
    
    }
    
}

#pragma  mark - 创建相册成功
-(void)donepressed:(id)sender{
    
    NSLog(@"完成");
    BOOL isrepeat = [Utils albumNameIsRepeat:self.name.text];
    
    if(isrepeat){
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle:@"相册名重复" message:nil delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        alert.tag=99;
        alert.delegate=self;
        [alert show];
    }else {
        //相册名不能为空
        if(![self.name.text isEqual:@""]){
            [self dismissViewControllerAnimated:YES completion:^{
                //  NSLog(@"%@",self.picarrtobeupload);
                // [Utils uploadImgToServer:self.picarrtobeupload];
                NSMutableDictionary* dic=[[NSMutableDictionary alloc]init];
                dic[@"name"]=self.name.text;
                dic[@"picset"]=self.addedpicset;
                NSLog(@"创建成功");
                [[NSNotificationCenter defaultCenter]postNotificationName:@"lib" object:dic];
            }];
        }
        
        
    
    }

    
}

#pragma  mark - 更改相册封面
-(void)changebac:(id)sender{
    
    NSLog(@"更改桌面");
    
    UIImagePickerController *pickerImage = [[UIImagePickerController alloc] init];
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        pickerImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //pickerImage.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        pickerImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:pickerImage.sourceType];
        
    }
    pickerImage.view.tag=1;
    pickerImage.delegate = self;
    pickerImage.allowsEditing = YES;

    [self presentViewController:pickerImage animated:YES
                     completion:^{
                         NSLog(@"打开相册,%@",pickerImage.mediaTypes);
                         
                     }];
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSLog(@"点击图片,%d",picker.view.tag);
    if(picker.view.tag==1){
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"选择完成,%@",info);
        
        [self.bacview setImage:(UIImage*)info[UIImagePickerControllerOriginalImage]];
        
    }];
    }
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    NSLog(@"取消图片选择");
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
-(void)back:(id)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"取消");
    }];
    
}
#pragma  mark- 其他设置
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
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

@end
