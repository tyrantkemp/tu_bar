//
//  leftmenuTableViewController.m
//  tu_bar
//
//  Created by 肖准 on 15/9/28.
//  Copyright (c) 2015年 肖准. All rights reserved.
//

#import "leftmenuTableViewController.h"
static NSString* const CELL=@"menucell";
static CGFloat CELL_HEIGHT=36;
static CGFloat HEADER_HEIGHT=34;

@interface leftmenuTableViewController ()<UIAlertViewDelegate>
@property(nonatomic,strong)UIVisualEffectView*visualEffectView;
@property (strong, nonatomic) IBOutlet UITableView *tablev;
@property(weak,nonatomic)ICSDrawerController* manctl;
@end

@implementation leftmenuTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorColor = [UIColor colorWithRed:150/255.0f green:161/255.0f blue:177/255.0f alpha:1.0f];
    self.tableView.opaque = NO;
    NSLog(@"%@",self.tableView.backgroundView);
   // self.tableView.alpha=0.1;
    [self.tableView setBackgroundView:[[UIView alloc]init]];
    self.tableView.backgroundView.backgroundColor = [UIColor clearColor];
    self.tableView.backgroundColor = [UIColor whiteColor];
    //使用图片初始化背景色
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bac.png"]];
    //实现模糊效果
     self.visualEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
    self.visualEffectView.frame = self.tablev.backgroundView.frame;
    self.visualEffectView.alpha = 1.0;
    [self.tableView registerClass:[menuTableViewCell class] forCellReuseIdentifier:CELL];
    [self.view insertSubview:self.visualEffectView atIndex:0];
//    NSLog(@"%d",[self.tablev subviews].count);
//    for (int i=0 ; i<[self.view subviews].count; ++i) {
//        NSLog(@"%@ \n",NSStringFromClass([[self.view subviews][i] class]));
//        
//    }
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setDrawer:(ICSDrawerController *)drawer{
    NSLog(@"setdrawer");
}


-(void )tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
//    menuTableViewCell *cell = (menuTableViewCell* )[tableView cellForRowAtIndexPath:indexPath];
//    cell.backgroundColor=[UIColor colorWithWhite:0.187 alpha:1.000];
    
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    switch (section) {
        case 0:
            switch (row) {
                case 0:
                {
                    NSLog(@"000");

                }
                    
                    break;
                
                case 1:{
                    
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        ChatListViewController *chatListViewController = [[ChatListViewController alloc]init];
                        UINavigationController* navi = [[UINavigationController alloc]initWithRootViewController:chatListViewController];
                        // [navi.navigationBar setBackgroundColor:[UIColor blackColor]];
                        UIFont *font = [UIFont systemFontOfSize:19.f];
                        NSDictionary *textAttributes = @{
                                                         NSFontAttributeName : font,
                                                         NSForegroundColorAttributeName : [UIColor whiteColor]
                                                         };
                        [navi.navigationBar setTitleTextAttributes:textAttributes];
                        [navi.navigationBar setTintColor:[UIColor whiteColor]];//按钮字体颜色
                        [navi.navigationBar setBarTintColor:[UIColor colorWithRed:(1 / 255.0f) green:(149 / 255.0f) blue:(255 / 255.0f) alpha:1]];
 
                        [chatListViewController setModalTransitionStyle:UIModalTransitionStyleCoverVertical];
                        [self presentViewController:navi animated:YES completion:^{
                            [[NSNotificationCenter defaultCenter]postNotificationName:LEFTVIEWCLOSE object:nil];
                        }];
                    
                    });
                    
                }

                    break;
                case 2:
                    NSLog(@"2222");

                    break;
                case 3:
                    NSLog(@"333");

                    break;
                default:
                    break;
            }
            break;
        case 1:
            switch (row) {
                case 0:
                    break;
                default:
                    break;
            }
            break;
        case 2:
            switch (row) {
                case 0:
                    break;
                    
                case 1:
                    break;
                default:
                    break;
            }
            break;
        case 3:
            switch (row) {
                case 0:
                  [Utils alertTitle:@"确定退出？" message:nil delegate:self cancelBtn:@"No" otherBtnName:@"Yes"] ;
                break;
                    
                    
                default:
                    break;
            }
            
        default:
            break;
    }
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        NSLog(@"不退出");
    }else{
        NSLog(@"确定退出");
        [self dismissViewControllerAnimated:YES completion:^{
            [Utils setAutoLogin:NO];
        }];

    }
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0){
        return nil;
    
    }
    else if(section ==1){
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 34)];
        view.backgroundColor = [UIColor clearColor];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 0, 0)];
        label.text = @"我的收藏";
        label.font = [UIFont systemFontOfSize:10];
        label.textColor = [UIColor colorWithWhite:0.960 alpha:1.000];
        label.backgroundColor = [UIColor clearColor];
        UIView * underline=[[UIView alloc]initWithFrame:CGRectMake(0, 20, tableView.frame.size.width, .5)];
        underline.backgroundColor=[UIColor colorWithWhite:0.496 alpha:1.000];
        [label sizeToFit];
        [view addSubview:label];
        [view addSubview:underline];
        
        return view;
    
    }else if(section==2){
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 34)];
        view.backgroundColor = [UIColor clearColor];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 0, 0)];
        label.text = @"订阅";
        label.font = [UIFont systemFontOfSize:10];
        label.textColor = [UIColor colorWithWhite:0.960 alpha:1.000];
        label.backgroundColor = [UIColor clearColor];
        UIView * underline=[[UIView alloc]initWithFrame:CGRectMake(0, 20, tableView.frame.size.width, .5)];
        underline.backgroundColor=[UIColor colorWithWhite:0.496 alpha:1.000];
        [label sizeToFit];
        [view addSubview:label];
        [view addSubview:underline];
        return view;
        
        
    }else{
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 34)];
        view.backgroundColor = [UIColor clearColor];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 0, 0)];
        label.text = @"配置";
        label.font = [UIFont systemFontOfSize:10];
        label.textColor = [UIColor colorWithWhite:0.960 alpha:1.000];
        label.backgroundColor = [UIColor clearColor];
        UIView * underline=[[UIView alloc]initWithFrame:CGRectMake(0, 20, tableView.frame.size.width, .5)];
        underline.backgroundColor=[UIColor colorWithWhite:0.496 alpha:1.000];
        [label sizeToFit];
        [view addSubview:label];
        [view addSubview:underline];
        
        return view;
        
    }
    return nil;
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
    if(section==0){
        return 4;
    }else if(section==1){
        return 1;
    }else if(section==2){
        return 2;
        
    }else{
        return  2;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    CGFloat height=30;
    if(section==0){
        height=100;
        
    }
    return  height;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger section = indexPath.section;
    NSInteger row= indexPath.row;
    CGFloat height=36;
    if(section==0){
        if (row==0) {
            height =56;
        }
    }
    return  height;
}
//-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    NSString* title;
//    if(section==1){
//        title= @"我的收藏";
//    }else if(section ==2)
//        title =@"订阅";
//    
//    return  title;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   

    NSInteger seciton=indexPath.section;
    NSInteger row=indexPath.row;
    
    menuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL forIndexPath:indexPath];
    
    if(cell==nil){
       cell=[[menuTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL];
     }
    
    switch (seciton) {
        case 0:
            switch (row) {
                case 0:
                {
                    [cell.menuicon setFrame:CGRectMake(34, 3, 50, 50)];
                    cell.menuicon.image=[UIImage imageNamed:@"xiaozhun.jpg"];
                    cell.selectionStyle=UITableViewCellSelectionStyleNone;
                    cell.menuicon.userInteractionEnabled=YES;
                    UITapGestureRecognizer* icontap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(icontaped:)];
                    [cell.menuicon addGestureRecognizer:icontap];
                    break;
                }
                case 1:
                    cell.menuname.text=@"私信";

                    break;
                case 2:
                    cell.menuname.text=@"朋友圈";

                    break;
                case 3:
                    cell.menuname.text=@"地图交友";

                    break;
                default:
                    break;
            }
            break;
        case 1:
            switch (row) {
                case 0:
                    cell.menuname.text=@"收藏1";
                    break;
                default:
                    break;
            }
            break;
         case 2:
            switch (row) {
                case 0:
                    cell.menuname.text=@"花姐6225";
                    break;
           
                case 1:
                    cell.menuname.text=@"山东";
                    break;
                default:
                    break;
            }
             break;
        case 3:
            switch (row) {
                case 0:
                    cell.menuname.text=@"退出";
                    break;
           
                    
                default:
                    break;
            }
            
        default:
            break;
    }
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(void)icontaped:(UITapGestureRecognizer*)tap{
    NSLog(@"touxiang tapped");
}

@end
