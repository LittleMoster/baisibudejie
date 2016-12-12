//
//  TagButton.m
//  百思不得姐
//
//  Created by user on 16/9/18.
//  Copyright © 2016年 ZJQ. All rights reserved.
//

#import "TagButton.h"

@implementation TagButton


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
          self.backgroundColor=RGBColor(74, 139, 209);
        
        [self setImage:[UIImage imageNamed:@"chose_tag_close_icon"] forState:UIControlStateNormal];
        self.titleLabel.font=[UIFont systemFontOfSize:14];
    }
    return self;
}
-(void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    [self sizeToFit];
    
    self.width +=3*TextMargin;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.titleLabel.x=TextMargin;
    self.imageView.x=CGRectGetMaxX(self.titleLabel.frame)+TextMargin;
    
    
}
@end
