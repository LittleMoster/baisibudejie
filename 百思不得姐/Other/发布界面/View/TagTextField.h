//
//  TagTextField.h
//  百思不得姐
//
//  Created by user on 16/9/18.
//  Copyright © 2016年 ZJQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TagTextField : UITextField

/** 删除按钮点击block*/
@property(nonatomic,copy)void(^cleanblock)();
@end
