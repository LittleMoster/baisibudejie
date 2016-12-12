//
//  CommentHeaderTitle.m
//  百思不得姐
//
//  Created by user on 16/9/7.
//  Copyright © 2016年 ZJQ. All rights reserved.
//

#import "CommentHeaderTitle.h"

@interface CommentHeaderTitle ()

/** 文字标签 */
@property (nonatomic, weak) UILabel *label;
@end



@implementation CommentHeaderTitle



+(instancetype)GetHeaderViewWithTableView:(UITableView *)tableView
{
    static NSString *ID=@"header";
    CommentHeaderTitle *header=[tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
  
    if (header==nil) {//如果缓存池没有，就自己创建
        header=[[CommentHeaderTitle alloc]initWithReuseIdentifier:ID];
    }
    return header;
}

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self=[super initWithReuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor=RGBColor(223, 223, 223);
        //创建label
       UILabel* label=[[UILabel alloc]init];
        label.textColor=RGBColor(67,67,67);
        label.width=200;
        label.x=TopicCellMargin;
        label.autoresizingMask=UIViewAutoresizingFlexibleHeight;
        label.tag=223;
        [self.contentView addSubview:label];
        self.label=label;

    }
    return self;
}
-(void)setTitle:(NSString *)title
{
    _title=title;
    self.label.text=title;
}
@end
