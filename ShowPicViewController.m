//
//  ShowPicViewController.m
//  tu_bar
//
//  Created by 肖准 on 15/10/14.
//  Copyright © 2015年 肖准. All rights reserved.
//

#import "ShowPicViewController.h"

@interface ShowPicViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITableViewDataSource,UITableViewDelegate>{
    CGFloat _popoverWidth;
}
@property(nonatomic,assign)CGSize cellsize;
@property(nonatomic,strong)UICollectionView* colview;
@property(nonatomic,strong)UIButton*titleLb;
@property (nonatomic, strong) DXPopover *popover;
@property (nonatomic, strong) UITableView *tbview;
@property (nonatomic, strong) NSArray *configs;
@property(nonatomic,assign)NSInteger flow_type;
@property(assign,nonatomic)BOOL istaped;
@property(nonatomic,strong)UIView* bgview;

@property(nonatomic,strong)UICollectionViewLayout* layout;
@end

@implementation ShowPicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.flow_type=0;
    self.istaped=NO;
    [self.view addSubview:self.colview];
    
    UIButton* my=[UIButton buttonWithType:UIButtonTypeCustom];
    [my setTitle:@"点我啊" forState:UIControlStateNormal];
    [my setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
     my.frame=CGRectMake(0, 0, 100, 40);
    [my addTarget:self action:@selector(popover:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    self.titleLb = [[UIButton alloc] initWithFrame:CGRectMake(270,10, 44, 25)];
    [self.titleLb setTitle:@"平铺" forState:UIControlStateNormal];
    [self.titleLb addTarget:self
                     action:@selector(popover:)
           forControlEvents:UIControlEventTouchUpInside];
    [self.titleLb setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.navigationController.navigationBar addSubview:self.titleLb];
//    self.navigationItem.rightBarButtonItem=my;
//    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"平铺" style:UIBarButtonItemStylePlain target:self action:@selector(popover:)];
    
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(back:)];
    UITableView *blueView = [[UITableView alloc] init];
    blueView.frame = CGRectMake(0, 0, _popoverWidth, 90);
    blueView.dataSource = self;
    blueView.delegate = self;
    self.tbview = blueView;
    [self resetPopover];
    


    // Do any additional setup after loading the view.
}

-(NSArray*)configs{
    if(_configs==nil){
        _configs=@[@"平铺",@"水平", @"垂直"];
    }
    return  _configs;
    
}
- (void)resetPopover {
    self.popover = [DXPopover new];
    
    _popoverWidth = 100.0;
}
-(void)back:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(UICollectionView*)colview{
    if(_colview==nil){
        self.layout=nil;
        
        switch (self.flow_type) {
            case 1:
                self.layout= [[HJCarouselViewLayout alloc] initWithAnim:HJCarouselAnimLinear];
                ((HJCarouselViewLayout*)self.layout).scrollDirection = UICollectionViewScrollDirectionHorizontal;
                ((HJCarouselViewLayout*)self.layout).itemSize = CGSizeMake(250, 250);

                break;
            case 2:
                self.layout= [[HJCarouselViewLayout alloc] initWithAnim:HJCarouselAnimLinear];
                ((HJCarouselViewLayout*)self.layout).scrollDirection = UICollectionViewScrollDirectionVertical;
                ((HJCarouselViewLayout*)self.layout).itemSize = CGSizeMake(250, 250);
                break;
            default:
                self.layout=[[UICollectionViewFlowLayout alloc]init];
                break;
        }

        _colview=[[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:self.layout];
        NSLog(@"layout:%@",NSStringFromClass([self.layout class]));
        _colview.backgroundColor=[UIColor clearColor];
        [_colview registerClass:[ShowPicCollectionViewCell class] forCellWithReuseIdentifier:@"picshowcell"];
        _colview.delegate=self;
        _colview.dataSource=self;
    }
    return _colview;
    
}

#pragma layout delegate

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    self.cellsize=CGSizeMake((self.view.frame.size.width-15)/3, (self.view.frame.size.width-15)/3+15);
    return  CGSizeMake((self.view.frame.size.width-15)/3, (self.view.frame.size.width-15)/3+15);
    
    
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return  3;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 3;
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return  UIEdgeInsetsMake(3, 3, 3, 3);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma collecitonview 
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 5;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    ShowPicCollectionViewCell* cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"picshowcell" forIndexPath:indexPath];
        NSDictionary* info = [[NSDictionary alloc]init];
        info=@{@"image":@"huajie.png",@"up":@"点赞:13",@"speech":@"留言:33"};
  
    cell.pic.image=[UIImage imageNamed:info[@"image"]];
    NSString* up=info[@"up"];
    cell.up.text=up;
    cell.up.font=[UIFont systemFontOfSize:10];
    
    NSString* speech=info[@"speech"];
    cell.speech.text=speech;
    cell.speech.font=[UIFont systemFontOfSize:10];
    cell.contentView.backgroundColor=[UIColor clearColor];
    
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pictap:)];
    [cell addGestureRecognizer:tap];
    return cell;
  
}

-(void)pictap:(UIGestureRecognizer*)ges{
    //当前view置顶
    ShowPicCollectionViewCell* cell=(ShowPicCollectionViewCell*)ges.view;

    [self.view bringSubviewToFront:cell];
    if(self.istaped){
        [cell.up setHidden:NO];
        [cell.speech setHidden:NO];
        [UIView animateWithDuration:.2 animations:^{
            if([cell superview]){
                [[cell superview] removeFromSuperview];
                [self.colview addSubview:cell];
            }
            cell.transform=CGAffineTransformIdentity;
        }];
        self.istaped=NO;
    }else{
        self.istaped=YES;
        CGPoint translationoff=CGPointMake(self.view.center.x-cell.center.x, self.view.center.y-cell.center.y);
      
        [cell.up setHidden:YES];
        [cell.speech setHidden:YES];
        [cell setBackgroundColor:[UIColor clearColor]];
        [self.bgview addSubview:cell];

        [self.colview addSubview:self.bgview];
        CGFloat factor=(self.view.frame.size.width/cell.frame.size.width)*1.04;
        [UIView animateWithDuration:0.2 animations:^{
            cell.transform=CGAffineTransformMakeTranslation(translationoff.x, translationoff.y);
            cell.transform=CGAffineTransformScale(cell.transform,factor,factor);
            
            //ges.view.transform=CGAffineTransformScale(ges.view.transform,1.0/factor, 1.0/factor);
            
        }];
        
        
    }
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    

    
}
-(UIView*)bgview{
    
    if(_bgview==nil){
        _bgview=[[UIView alloc]initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height)];
        _bgview.backgroundColor=[UIColor colorWithWhite:0.000 alpha:0.820];
        // _bgview.alpha=0.3;
    }
    return  _bgview;
}

-(void)popover:(id)sender
{    [self updateTableViewFrame];
    
    self.popover.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.popover.backgroundColor = [UIColor whiteColor];
    
    UIView *titleView = self.titleLb;
    CGPoint startPoint =
    CGPointMake(CGRectGetMidX(titleView.frame), CGRectGetMaxY(titleView.frame) + 20);
    [self.popover showAtPoint:startPoint
               popoverPostion:DXPopoverPositionDown
              withContentView:self.tbview
                       inView:self.navigationController.view];
    __weak typeof(self) weakSelf = self;
    self.popover.didDismissHandler = ^{
        [weakSelf bounceTargetView:titleView];
    };

}
- (void)updateTableViewFrame {
    CGRect tableViewFrame = self.tbview.frame;
    tableViewFrame.size.width = _popoverWidth;
    self.tbview.frame = tableViewFrame;
    self.popover.contentInset = UIEdgeInsetsZero;
    self.popover.backgroundColor = [UIColor whiteColor];
}
- (void)bounceTargetView:(UIView *)targetView {
    targetView.transform = CGAffineTransformMakeScale(0.9, 0.9);
    [UIView animateWithDuration:0.5
                          delay:0.0
         usingSpringWithDamping:0.3
          initialSpringVelocity:5
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         targetView.transform = CGAffineTransformIdentity;
                     }
                     completion:nil];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   return  30;
}



- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellId];
    }
    cell.textLabel.text = self.configs[indexPath.row];
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row= indexPath.row;
    [self.colview removeFromSuperview];
    self.colview=nil;
    self.flow_type=row;
    if(row==0){
        NSLog(@"平铺");
        [self.titleLb setTitle:@"平铺" forState:UIControlStateNormal];
        self.colview.frame=CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height);
    }else if(row==1){
        NSLog(@"水平");
        [self.titleLb setTitle:@"水平" forState:UIControlStateNormal];
    }
    else if(row==2){
        NSLog(@"垂直");
        [self.titleLb setTitle:@"垂直" forState:UIControlStateNormal];
    }
    [self.view addSubview:self.colview];
    [self.popover dismiss];
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
