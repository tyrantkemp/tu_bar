//
//  PublishViewController.m
//  tu_bar
//
//  Created by 肖准 on 15/11/23.
//  Copyright © 2015年 肖准. All rights reserved.
//

#import "PublishViewController.h"

@interface PublishViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView* tbview;



@property(nonatomic,strong)NSMutableDictionary* dicbydate;
@end

@implementation PublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initImgInfo:[Utils getImgInfofromPlist]];
    
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"退出" style:UIBarButtonItemStylePlain target:self action:@selector(quit:)];

    [self.view addSubview:self.tbview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 初始化


-(UITableView*)tbview{
    if(_tbview==nil){
        
        _tbview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, self.view.height) style:UITableViewStyleGrouped];
        _tbview.delegate=self;
        _tbview.dataSource=self;
        _tbview.separatorStyle=UITableViewCellSeparatorStyleNone;
        [_tbview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"blank"];
       // [_tbview registerClass:[PublicTableViewCell class] forCellReuseIdentifier:@"public_cell"];

    }
    return  _tbview;
}

#pragma mark- uitableview 实现
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray* arr =[self.dicbydate allKeys];
    
    NSString* key = arr[section];
    
    NSArray* arr1 = [self.dicbydate objectForKey:key];
    NSLog(@"section:%d, %d",section,arr1.count);
    return arr1.count*2-1;
    
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  [self.dicbydate allKeys].count;
}
-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
   

    return [self.dicbydate allKeys][section];
    
  
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = indexPath.row;
    return (row%2==1)?5:150;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    
    if(indexPath.row%2==1){
        
        UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"blank" forIndexPath:indexPath];
        
        if(!cell){
            
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"blank"];
            
        }
        cell.backgroundColor=[UIColor clearColor];
        cell.userInteractionEnabled=NO;
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return  cell;
        
        
    }else {
        
     
         PublicTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"public_cell"];
        if(cell==nil){
            
            // 是否是应用内置图片?
            
            NSArray* arr= [self.dicbydate allKeys];
            
            NSArray* arr1 = [self.dicbydate objectForKey:arr[indexPath.section]];
            NSDictionary* dic=arr1[indexPath.row/2];
            NSString* key =[dic allKeys][0];
            NSDictionary* dic1 = [dic objectForKey:key];
            NSURL* url = [NSURL URLWithString:[dic1 objectForKey:@"localurl"]];
            
            
            NSLog(@"url:%@",url);
            
            __block UIImage *img =nil;
            ALAssetsLibrary  *lib = [[ALAssetsLibrary alloc] init];
            //先创建一个semaphore
            dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
            dispatch_queue_t queue = dispatch_queue_create("getimginfo", NULL);
            dispatch_async(queue, ^(void) {
            
                [lib assetForURL:url resultBlock:^(ALAsset *asset)
                 {
                     // 使用asset来获取本地图片
                     ALAssetRepresentation *assetRep = [asset defaultRepresentation];
                     CGImageRef imgRef = [assetRep fullResolutionImage];
                     img = [UIImage imageWithCGImage:imgRef
                                               scale:assetRep.scale
                                         orientation:(UIImageOrientation)assetRep.orientation];
                     //             if (nil == img) {// 使用默认图片
                     //                 if (nil == defaultImageName) {
                     //                     return;
                     //                 }
                     //
                     //                 [aPerson updateAvaterImageOfPerson: aPerson assetUrlString: aPerson.nameOfdefaultImg defaultImageName:nil];
                     //
                     //             }
                     
                     NSLog(@"读取完成:%@",img);
                     //发出已完成的信号
                     dispatch_semaphore_signal(semaphore);
                     
                 }
                    failureBlock:^(NSError *error)
                 {
                     // 访问库文件被拒绝,则直接使用默认图片
                     //             if (nil == aPerson.avatarImage) {// 使用默认图片
                     //                 if (nil == defaultImageName) {
                     //                     return;
                     //                 }
                     //
                     //                 [aPerson updateAvaterImageOfPerson: aPerson assetUrlString: aPerson.nameOfdefaultImg defaultImageName:nil];
                     
                     NSLog(@"读取失败");
                     //发出已完成的信号
                     dispatch_semaphore_signal(semaphore);
                     
                 }];

            });
                        
            //等待执行，不会占用资源
            dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        
            NSLog(@"开始初始化cell");
            MODcomments*doc=[[MODcomments alloc]init];
            cell = [[PublicTableViewCell alloc]initWithStyleandInfo:UITableViewCellStyleDefault reuseIdentifier:@"public_cell" info:doc Image:img];


        }
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return  cell;
    }
}

//编辑类型
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}
//允许编辑
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return  YES;
}
//具体操作
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(editingStyle==UITableViewCellEditingStyleDelete){
        //数据更新操作
        [self.tbview deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
        
    }
}
#pragma mark - 其他操作
-(void)quit:(id)sender{
    NSLog(@"public ctl 退出");

    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)initImgInfo:(NSMutableDictionary*)imgdic{
    NSAssert(imgdic!=nil, @"提取的imginfo不能为空");
    self.dicbydate=[[NSMutableDictionary alloc]init];
    [imgdic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSDictionary* dic= (NSDictionary*)obj;
        NSString* timestr = [dic objectForKey:@"time"];
        NSLog(@"datestr:%@",timestr);
        
        NSMutableArray* datearr = [[NSMutableArray alloc]init];
        
        NSArray* datelist = [timestr componentsSeparatedByString:@"&"];
        
        NSMutableDictionary* timedict = [[NSMutableDictionary alloc]init];
        [timedict setValue:dic forKey:datelist[1]];
        [datearr addObject:timedict];
        
        if(![self.dicbydate objectForKey:datelist[0]]){
            [self.dicbydate setValue:datearr forKey:datelist[0]];
        }else{
            NSMutableArray* arr=[self.dicbydate objectForKey:datelist[0]];
            [arr addObject:timedict];
            [self.dicbydate setValue:arr forKey:datelist[0]];
            
        }
        
    }];
    NSLog(@"%@",self.dicbydate);
    
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
