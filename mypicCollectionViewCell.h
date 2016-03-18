//
//  mypicCollectionViewCell.h
//  tu_bar
//
//  Created by 肖准 on 15/10/9.
//  Copyright © 2015年 肖准. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mypicCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *pic;
@property (strong, nonatomic) IBOutlet UILabel *picname;
@property (strong, nonatomic) IBOutlet UILabel *picnumber;

@end
