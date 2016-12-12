//
//  RecommendUserTableViewCell.m
//  百思不得姐
//
//  Created by user on 16/8/3.
//  Copyright © 2016年 ZJQ. All rights reserved.
//

#import "RecommendUserTableViewCell.h"
#import <UIImageView+WebCache.h>
@interface RecommendUserTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *HeaderImageView;
@property (weak, nonatomic) IBOutlet UILabel *NameLabel;
@property (weak, nonatomic) IBOutlet UILabel *CountNumLabel;



@end

@implementation RecommendUserTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    [super awakeFromNib];
}
-(void)setUserModel:(CategoryUserModel *)UserModel
{
    _UserModel = UserModel;
    
    self.NameLabel.text = UserModel.screen_name;
    self.CountNumLabel.text = [NSString stringWithFormat:@"%zd人关注", UserModel.fans_count];
    [self.HeaderImageView sd_setImageWithURL:[NSURL URLWithString:UserModel.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];

}
    
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
