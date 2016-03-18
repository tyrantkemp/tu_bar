//
//  MODcomments.h
//  
//
//  Created by 肖准 on 15/10/4.
//
//

#import <Foundation/Foundation.h>
#import "JSONModelLib.h"
#import "NSComment.h"



@interface MODcomments : JSONModel
@property(nonatomic,copy)NSString* imgId;
@property(nonatomic,copy)NSString* nameId;
@property(nonatomic,copy)NSString* url;
@property(nonatomic,copy)NSString* des;
@property(nonatomic,copy)NSString* auther;
@property(nonatomic,assign)NSInteger top;
@property(nonatomic,assign)NSInteger down ;
@property(nonatomic,strong)NSMutableArray<NSComment>* comments ;
@end

