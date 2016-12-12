//
//  MeViewCell.m
//  百思不得姐
//
//  Created by user on 16/9/13.
//  Copyright © 2016年 ZJQ. All rights reserved.
//

#import "MeViewCell.h"

@implementation MeViewCell

- (void)awakeFromNib {
    // Initialization cod
    [super awakeFromNib];
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //cell右边箭头
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        UIImageView *bgView = [[UIImageView alloc] init];
        bgView.image = [UIImage imageNamed:@"mainCellBackground"];
        self.backgroundView = bgView;
        
        self.textLabel.textColor = [UIColor darkGrayColor];
        self.textLabel.font = [UIFont systemFontOfSize:16];

    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    if (self.imageView.image==nil) {
        return;
    }
    self.imageView.width=30;
    self.imageView.height=self.imageView.width;
    self.imageView.centerY=0.5*self.contentView.height;
    self.textLabel.x=CGRectGetMaxX(self.imageView.frame)+10;
}
@end
