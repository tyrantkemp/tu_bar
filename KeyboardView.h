//
//  KeyboardView.h
//  XZLogin
//
//  Created by 肖准 on 15/9/14.
//  Copyright (c) 2015年 肖准. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KeyboardView;
@protocol KeyboardViewDelegate<NSObject>

-(void)KeyboardView:(KeyboardView*)keyboard textfiedbegin:(UITextField*)textfield;
-(void)KeyboardView:(KeyboardView *)keyboard textfiedreturn:(UITextField *)textfield;

@end

@interface KeyboardView : UIView
@property(nonatomic,strong) id<KeyboardViewDelegate>delegate;
@property(nonatomic,strong)UITextField* textField;

@end
