//
//  UIImageView+Extension.m
//  百思不得姐
//
//  Created by user on 2016/11/27.
//  Copyright © 2016年 ZJQ. All rights reserved.
//

#import "UIImageView+Extension.h"
#import <UIImageView+WebCache.h>
@implementation UIImageView (Extension)



- (void)setcircleImageUrl:(NSString *)url setCirclePlaceholder:(NSString *)placeholder

{
    
    UIImage *place = [[UIImage imageNamed:placeholder] circleImage];//占位图片，当URL上下载的图片为空，就显示该图片
    
    [self sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:place completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {//当图片下载完会来到这个block，执行以下代码
        
       
     
        
            
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//             self.image = place;
//            
//            NSLog(@"3333%@---%@",image,self.image);
//        });
        self.image = image ? [image circleImage] : place;
      
 
    }];
    
}
@end
