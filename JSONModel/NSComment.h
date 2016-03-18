//
//  NSComment.h
//  
//
//  Created by 肖准 on 15/10/4.
//
//

#import <Foundation/Foundation.h>
#import"JSONModelLib.h"
#import"MOOtherComments.h"
@protocol NSComment
@end
@interface NSComment : JSONModel
@property(nonatomic,copy)NSString* url;
@property(nonatomic,copy)NSString* auther;
@property(nonatomic,copy)NSString* des;
@property(nonatomic,assign)NSInteger index;
@property(nonatomic,strong)NSMutableArray<MOOtherComments>* othercomments;
@end
