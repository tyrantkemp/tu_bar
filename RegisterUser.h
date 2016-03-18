//
//  RegisterUser.h
//  tu_bar
//
//  Created by 肖准 on 15/11/11.
//  Copyright © 2015年 肖准. All rights reserved.
//

#import <Foundation/Foundation.h>
#import"JSONModel.h"

@interface RegisterUser : JSONModel
@property(nonatomic,strong)NSString* mail;
@property(nonatomic,strong)NSString* username;
@property(nonatomic,strong)NSString* password;
//@property(nonatomic,strong)NSString* bacimgUrl;
@property(nonatomic,assign)BOOL isAutoLogin;

