//
//  UIBarButtonItem+Extension.m
//  百思不得姐
//
//  Created by user on 16/8/1.
//  Copyright © 2016年 ZJQ. All rights reserved.
//

#import "UIBarButtonItem+Extension.h"

@implementation UIBarButtonItem (Extension)



+(UIBarButtonItem *)itemWithImageName:(NSString*)Norimage WithHeight:(NSString*)hightImage target:(id)target action:(SEL)action
{
    UIButton *item=[[UIButton alloc]init];
    UIImage *itemImage=[UIImage imageNamed:Norimage];
    [item setBackgroundImage:itemImage forState:UIControlStateNormal];
    if (hightImage) {
        UIImage *hight=[UIImage imageNamed:hightImage];
        [item setBackgroundImage:hight forState:UIControlStateHighlighted];
    }
    CGRect frame=item.frame;
    frame.size=item.currentBackgroundImage.size;
    item.frame=frame;
    
    [item addTarget:target action:action forControlEvents:UIControlEventTouchDown];
    
    return [[UIBarButtonItem alloc]initWithCustomView:item];
}
@end
