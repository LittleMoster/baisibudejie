//
//  RecommendCategoryCell.m
//  百思不得姐
//
//  Created by user on 16/8/3.
//  Copyright © 2016年 ZJQ. All rights reserved.
//

#import "RecommendCategoryCell.h"

@interface RecommendCategoryCell() 
@property (weak, nonatomic) IBOutlet UIView *selectView;

@end
@implementation RecommendCategoryCell

- (void)awakeFromNib {
    self.backgroundColor=RGBColor(244, 244, 244);
    self.selectView.backgroundColor = RGBColor(219, 21, 26);
    
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.selectView.hidden=!selected;
    
     // 当cell的selection为None时, 即使cell被选中了, 内部的子控件也不会进入高亮状态
    self.textLabel.textColor= selected ? self.selectView.backgroundColor:RGBColor(78, 78, 78);
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.textLabel.y = 2;
    self.textLabel.height = self.contentView.height - 2 * self.textLabel.y;
}
-(void)setCategoty:(RecommendCategory *)categoty
{
    _categoty=categoty;
    self.textLabel.text=_categoty.name;
}
@end
