//
//  squareButton.m
//  百思不得姐
//
//  Created by user on 16/9/13.
//  Copyright © 2016年 ZJQ. All rights reserved.
//

#import "squareButton.h"
#import "SquareModel.h"
#import <UIButton+WebCache.h>
@implementation squareButton

-(void)setup

{
    
    self.titleLabel.textAlignment=NSTextAlignmentCenter;//按钮文字居中
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:15];
    [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
    
}
-(void)setSquare:(SquareModel *)square
{
    _square=square;
    [self setTitle:square.name forState:UIControlStateNormal];
    
    [self sd_setImageWithURL:[NSURL URLWithString:square.icon] forState:UIControlStateNormal];
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
    [super awakeFromNib];
    [self setup];
    
}

-(void)layoutSubviews

{//自定义布局
    
    [super layoutSubviews];
    
        // 调整图片
    self.imageView.y=self.height*0.15;
    
    self.imageView.width=self.width *0.5;
    
    self.imageView.height=self.imageView.width;
    
    self.imageView.centerX=self.width *0.5;
    
//

    
    self.titleLabel.x=0;
    
    self.titleLabel.y=CGRectGetMaxY(self.imageView.frame);
    
    self.titleLabel.width=self.width;
    
    self.titleLabel.height=self.height-self.titleLabel.y;
    
}
@end
