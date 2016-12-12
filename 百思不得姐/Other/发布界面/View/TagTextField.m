//
//  TagTextField.m
//  百思不得姐
//
//  Created by user on 16/9/18.
//  Copyright © 2016年 ZJQ. All rights reserved.
//

#import "TagTextField.h"

@implementation TagTextField

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
        self.width=UIWidth;
        self.height=30;
        self.placeholder=@"多个标签用逗号或换行隔开";
    }
    return self;
}
-(void)deleteBackward
{
   
    if (self.cleanblock) {
        self.cleanblock();
    }
     [super deleteBackward];
}
@end
