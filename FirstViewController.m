//
//  FirstViewController.m
//  tu_bar
//
//  Created by 肖准 on 15/9/28.
//  Copyright (c) 2015年 肖准. All rights reserved.
//

#import "FirstViewController.h"
#define PICWIDTH floor(self.view.frame.size.width/3.0)-7
#define F_PIC_W  floor(self.view.frame.size.width/2.0)-5

#define CELL_WIDTH 126
#define CELL_COUNT 30
#define CELL_IDENTIFIER @"WaterfallCell"

@interface FirstViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate,UIGestureRecognizerDelegate,UICollectionViewDelegateWaterfallLayout,NSXMLParserDelegate,ASIHTTPRequestDelegate>{

    
}
@property(nonatomic,strong)UICollectionView*         colview;
@property(nonatomic,strong)NSMutableArray*           pics;
@property(nonatomic,strong)UIPanGestureRecognizer    *panGesture;
@property (assign, nonatomic) float                  lastContentOffset;
@property (strong, nonatomic) UIView                 *overlay;
@property (assign, nonatomic) BOOL                   isCollapsed;
@property (assign, nonatomic) BOOL                   isExpanded;
@property (nonatomic, strong) NSMutableArray         *cellHeights;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    
    
    //当前用户的配置 一次配置就行
//    NSUserDefaults* user = [NSUserDefaults standardUserDefaults];
//    [user setObject:@"13302332014" forKey:@"userId"];
//    [user setObject:@"tyrant" forKey:@"userName"];
//    [user setObject:@"xiaozhun.jpg" forKey:@"iconUsrl"];
//    [user setObject:@"start.png" forKey:@"bacUrl"];
    
    NSLog(@"首页,%f",self.tabBarController.tabBar.frame.size.height);
    NSMutableArray* picarr= [[[NSBundle mainBundle]pathsForResourcesOfType:@"png" inDirectory:@"pic"] mutableCopy];
    //NSLog(@"pic:%@",self.pics);
    //NSString* path=@"/Users/tyrantxz/Desktop/pic";
    self.pics=[[NSMutableArray alloc]init];
    [picarr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.pics addObject:[UIImage imageNamed:obj]];
    }];
    
    
    //从服务器获取picInfo
   // [Utils getPicInfo:]
    
    
    
    
    
//    NSFileManager* fm = [NSFileManager defaultManager];
//    if([fm fileExistsAtPath:path]){
//        NSArray* arr= [fm subpathsAtPath:path];
//        for(int i=0;i<arr.count;++i){
//                if([[arr[i] pathExtension]isEqualToString:@"png"]||[[arr[i] pathExtension] isEqualToString:@"jpg"]){
//                    NSString* imagepath = [path stringByAppendingPathComponent:arr[i]];
//                        [self.pics addObject:[UIImage imageNamed:imagepath]];
//                }
//        }
//        
//    }

    NSLog(@"frame:%@,barframe:%@",NSStringFromCGRect( self.navigationController.navigationBar.frame),NSStringFromCGRect(self.tabBarController.tabBar.frame));
    
    
    self.panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    [self.panGesture setMaximumNumberOfTouches:1];
    
    [self.panGesture setDelegate:self];
    [self.colview addGestureRecognizer:self.panGesture];
    
    
    
    self.navigationController.navigationBar.tintColor = [self.navigationController.navigationBar.tintColor
                                                         colorWithAlphaComponent:1];
//    CGRect frame = self.navigationController.navigationBar.frame;
//    frame.origin = CGPointZero;
//    self.overlay = [[UIView alloc] initWithFrame:frame];
//    if ([self isIOS7]) {
//        if (self.navigationController.navigationBar.barTintColor) {
//            [self.overlay setBackgroundColor:self.navigationController.navigationBar.barTintColor];
//        }
//    }
//    
//    [self.overlay setUserInteractionEnabled:NO];
//    [self.navigationController.navigationBar addSubview:self.overlay];
//    [self.overlay setAlpha:0];
    
    [self.view addSubview:self.colview];
    
//    UIImageView* vi=[[UIImageView alloc]initWithFrame:self.view.frame];
//    [vi setImage:[UIImage imageNamed:@"bac.png"]];
//    [self.view addSubview:vi];
    // Do any additional setup after loading the view.
    
   // UIImage* imga=[UIImage imageNamed:@"green.png"];
    
    //图片上传服务器
    //[self uploadImgToServer:imga];
    [self.colview registerClass:[imageCollectionViewCell class]
 forCellWithReuseIdentifier:CELL_IDENTIFIER];

    [self getPicInfo:@"http://tyrantkemp.imwork.net:21848/test1/app/getPicInfo" type:@"normal"];
    
    
}
-(void)uploadImgToServer:(UIImage*)image{
    ASIFormDataRequest *formDataRequest=[ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://tyrantkemp.imwork.net:21848/test1/app/uploadfile"]];
    [formDataRequest setPostValue:@"green.png" forKey:@"name"];
    NSData *postData=UIImageJPEGRepresentation(image, .3);
    if(postData==nil){
        NSLog(@"pic data为空！！！");
    }
    [formDataRequest setDelegate:self];
    [formDataRequest addData:postData forKey:@"file"];
    [formDataRequest setDidFailSelector:@selector(urlRequestFailed:)];
    [formDataRequest setDidFinishSelector:@selector(urlRequestSucceeded:)];
    [formDataRequest startSynchronous];
   // NSLog(@"responce is %@",[formDataRequest responseString]);

}
-(void)urlRequestFailed:(ASIHTTPRequest *)request
{
    NSError *error =[request error];
    NSLog(@"%@",[error localizedDescription]);
    NSLog(@"连接失败！");
    UIAlertView * alt=[[UIAlertView alloc] initWithTitle:@"提示" message:@"连接服务器失败" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alt show];
}

//请求成功
-(void)urlRequestSucceeded:(ASIHTTPRequest *)request
{
    NSData *data=[request responseData];
    NSXMLParser *parser=[[NSXMLParser alloc] initWithData:data];
    NSLog(@"data length = %lu",(unsigned long)[data length]);
    NSLog(@"xml data = %@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    [parser setDelegate:self];
    [parser parse];//进入解析
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




-(UICollectionView*)colview{
    
        if(_colview==nil){
            UICollectionViewWaterfallLayout *layout = [[UICollectionViewWaterfallLayout alloc] init];
            layout.sectionInset = UIEdgeInsetsMake(9, 9, 9, 9);
            layout.delegate = self;
            [layout setItemWidth:(self.view.width-36.0)/3];
            _colview=[[UICollectionView alloc]initWithFrame:CGRectMake(0, ISIPHONE5?0:64, self.view.frame.size.width, self.view.frame.size.height) collectionViewLayout:layout];
            _colview.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
            _colview.dataSource = self;
            _colview.delegate = self;
            _colview.backgroundColor = [UIColor colorWithRed:1.000 green:0.925 blue:0.812 alpha:1.000];
           

        }
        return _colview;
        
        
    
}
- (NSMutableArray *)cellHeights
{
    if (!_cellHeights) {
        _cellHeights = [NSMutableArray arrayWithCapacity:self.pics.count];
        for (NSInteger i = 0; i < self.pics.count; i++) {
            //每个cell的高度
 //           _cellHeights[i] = @(arc4random()%50+100);
            UIImage* temp =(UIImage*)self.pics[i];
            _cellHeights[i]=@(temp.size.height*(96/temp.size.width));
            
            
            
        }
    }
    return _cellHeights;
}
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                         duration:(NSTimeInterval)duration
{
    [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation
                                            duration:duration];
    [self updateLayout];
}

- (void)updateLayout
{
    UICollectionViewWaterfallLayout *layout =
    (UICollectionViewWaterfallLayout *)self.colview.collectionViewLayout;
    layout.columnCount = self.colview.bounds.size.width / CELL_WIDTH;
    layout.itemWidth = CELL_WIDTH;
}



-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.pics.count;
    //return self.pics.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    NSLog(@"seciton number");
    return 1;
}




-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    
    NSString *key = [NSString stringWithFormat:@"%ld-%ld",(long)indexPath.section, (long)indexPath.row];

    imageCollectionViewCell* cell =[[Utils sharedCache] objectForKey:key];
    
    if(!cell){
        NSLog(@"cell 初始化");
        cell =
        (imageCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CELL_IDENTIFIER
                                                                             forIndexPath:indexPath];
        //    if(!cell){
        //                cell=[[imageCollectionViewCell alloc]initWithFrame:CGRectZero];
        //            }
        cell.pic.image=[self.pics objectAtIndex:indexPath.row];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        [cell.pic addGestureRecognizer:tap ];
        cell.pic.userInteractionEnabled=YES;
      
        //对cell layer渲染会导致collview滑动卡顿
        
        //    cell.layer.masksToBounds=YES;
       // cell.layer.cornerRadius=3;
        
       // cell.layer.shadowColor=[UIColor grayColor].CGColor;
       // cell.layer.shadowOffset=CGSizeMake(2, 2);
        //cell.layer.shadowOpacity=.9;
        [[Utils sharedCache] setObject:cell forKey:key];
        
    }
    return cell;
    
}
#pragma mark - UICollectionViewWaterfallLayoutDelegate
- (CGFloat)collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewWaterfallLayout *)collectionViewLayout
 heightForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.cellHeights[indexPath.item] floatValue];
}


-(void)tap:(UITapGestureRecognizer*)ges{
    NSLog(@"pic tapped");
    DetailViewController* ctl=[[DetailViewController alloc]init];
//    ctl.pic=(UIImageView*)ges.view;
    ctl.hidesBottomBarWhenPushed=YES;

    
    [self.navigationController pushViewController:ctl animated:YES];
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch* tu=[touches anyObject]
    ;
    
    NSLog(@"touch class:%@",NSStringFromClass([[tu view] class]));
    
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}
- (void)handlePan:(UIPanGestureRecognizer*)gesture {
    CGPoint translation = [gesture translationInView:[self.colview superview]];
    float delta = self.lastContentOffset - translation.y;
    self.lastContentOffset = translation.y;
    CGRect frame;
    CGRect barframe;
    if (delta > 0) {
        if (self.isCollapsed) {
            return;
        }
        
        frame = self.navigationController.navigationBar.frame;
        barframe=self.tabBarController.tabBar.frame;
        if (frame.origin.y - delta < -24) {
            delta = frame.origin.y + 24;
        }
        
        frame.origin.y = MAX(-24, frame.origin.y - delta);
        barframe.origin.y=self.view.frame.size.height;
        self.navigationController.navigationBar.frame = frame;
        [UIView animateWithDuration:0.3 animations:^{
            self.tabBarController.tabBar.frame=barframe;

        }];
        if (frame.origin.y == -24) {
            self.isCollapsed = YES;
            self.isExpanded = NO;
        }
        
        [self updateSizingWithDelta:delta];
        
        // Keeps the view's scroll position steady until the navbar is gone
        if ([self.colview isKindOfClass:[UICollectionView class]]) {
            UICollectionView *scrollView = (UICollectionView *)self.colview;
            [scrollView setContentOffset:CGPointMake(scrollView.contentOffset.x,
                                                     scrollView.contentOffset.y - delta)];
        }
    }
    
    if (delta < 0) {
        if (self.isExpanded) {
            return;
        }
        
        frame = self.navigationController.navigationBar.frame;
//        barframe=self.tabBarController.tabBar.frame;

        if (frame.origin.y - delta > 20) {
            delta = frame.origin.y - 20;
        }
        frame.origin.y = MIN(20, frame.origin.y - delta);
//        barframe.origin.y = self.view.frame.size.height-49;

        self.navigationController.navigationBar.frame = frame;
        [UIView animateWithDuration:0.3 animations:^{
            [self.tabBarController.tabBar setY:self.view.window.frame.size.height-49];
        }];

        if (frame.origin.y == 20) {
            self.isExpanded = YES;
            self.isCollapsed = NO;
        }
        
        [self updateSizingWithDelta:delta];
    }
    
    if ([gesture state] == UIGestureRecognizerStateEnded) {
        self.lastContentOffset = 0;
        [self checkForPartialScroll];
    }
    return;
}

- (void)checkForPartialScroll {
    CGFloat pos = self.navigationController.navigationBar.frame.origin.y;
    
    // Get back down
    if (pos >= -2) {
        [UIView animateWithDuration:0.2 animations:^{
            CGRect frame;
            frame = self.navigationController.navigationBar.frame;
            CGFloat delta = frame.origin.y - 20;
            frame.origin.y = MIN(20, frame.origin.y - delta);
            self.navigationController.navigationBar.frame = frame;
            
            self.isExpanded = YES;
            self.isCollapsed = NO;
            [self updateSizingWithDelta:delta];
        }];
    } else {
        // And back up
        [UIView animateWithDuration:0.2 animations:^{
            CGRect frame;
            frame = self.navigationController.navigationBar.frame;
            CGFloat delta = frame.origin.y + 24;
            frame.origin.y = MAX(-24, frame.origin.y - delta);
            self.navigationController.navigationBar.frame = frame;
            
            self.isExpanded = NO;
            self.isCollapsed = YES;
            [self updateSizingWithDelta:delta];
        }];
    }
    return;
}

- (void)updateSizingWithDelta:(CGFloat)delta {
    CGRect frame = self.navigationController.navigationBar.frame;
    
    float alpha = (frame.origin.y + 24) / frame.size.height;
//    [self.overlay setAlpha:1 - alpha];
    self.navigationController.navigationBar.tintColor = [self.navigationController.navigationBar.tintColor
                                                         colorWithAlphaComponent:alpha];
    
    frame = self.colview.superview.frame;
    
    frame.origin.y = self.navigationController.navigationBar.frame.origin.y;
    frame.origin.y += self.navigationController.navigationBar.frame.size.height;
    
    // 判断是否是ios7及其以上版本
    if ([self isIOS7]) {
        frame.origin.y =  self.navigationController.navigationBar.frame.origin.y - 20;
    }

    frame.size.height = frame.size.height + delta;
    self.colview.superview.frame = frame;
    
    // Changing the layer's frame avoids UIWebView's glitchiness
    frame = self.colview.layer.frame;
    frame.size.height += delta;
    self.colview.layer.frame = frame;
    return;
}


#pragma mark - 获取图片信息
-(void)getPicInfo:(NSString*)url type:(NSString*)type {
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
    [request startAsynchronous];
    [request setDelegate:self];
    //    NSLog(@"获取的picinfo:%@",[request responseString]);
}
- (void)requestFinished:(ASIHTTPRequest *)request
{
    // Use when fetching text data
    NSString *responseString = [request responseString];
   // NSData* data = [NSJSONSerialization dataWithJSONObject:responseString options:NSJSONWritingPrettyPrinted error:nil];
    NSError* err=nil;
    NSMutableArray *arrcom = [MODcomments arrayOfModelsFromData:[request responseData] error:&err];
    if(err){
        NSLog(@"err:%@",[err localizedDescription]);
    }
    // NSLog(@"获取的picinfo:%@",arrcom);
    // Use when fetching binary data
}
- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(@"获取的picinfo失败:%@",[error localizedDescription]);
    
}
- (BOOL)isIOS7 {
    return ([UIDevice currentDevice].systemVersion.integerValue >= 7) ? YES : NO;
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
