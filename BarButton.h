//
//  BarButton.h
//  tu_bar
//
//  Created by 肖准 on 15/10/13.
//  Copyright © 2015年 肖准. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BarButton : UIButton
@property(nonatomic,strong)UILabel* lab;
@property(nonatomic,strong)UILabel* title;
-(instancetype)initWithFrameAndTile:(CGRect)frame title:(NSString*)title;

@end
