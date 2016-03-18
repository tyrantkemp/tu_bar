//
//  UIImage+vImage.h
//  tu_bar
//
//  Created by 肖准 on 15/11/3.
//  Copyright © 2015年 肖准. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Accelerate/Accelerate.h>
@interface UIImage (vImage)
- (UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur;
@end
