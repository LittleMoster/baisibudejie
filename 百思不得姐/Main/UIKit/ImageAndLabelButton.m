//
//  ImageAndLabelButton.m
//  百思不得姐
//
//  Created by user on 16/8/4.
//  Copyright © 2016年 ZJQ. All rights reserved.
//

/**
 *  图片在上，文字在面
 *
 *  自定义button
 */
#import "ImageAndLabelButton.h"

@implementation ImageAndLabelButton

-(void)setup
{
    self.titleLabel.textAlignment=NSTextAlignmentCenter;
    
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}
-(void)awakeFromNib
{
    [self setup];
    
    [super awakeFromNib];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.x=0;
    self.imageView.y=0;
    self.imageView.width=self.width;
    self.imageView.height=self.imageView.width;
    
    self.titleLabel.x=0;
    self.titleLabel.y=self.imageView.height;
    self.titleLabel.width=self.width;
    self.titleLabel.height=self.height-self.imageView.height;
}

@end
