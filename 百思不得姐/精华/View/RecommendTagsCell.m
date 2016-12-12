//
//  RecommendTagsCell.m
//  百思不得姐
//
//  Created by user on 16/8/4.
//  Copyright © 2016年 ZJQ. All rights reserved.
//

#import "RecommendTagsCell.h"
#import "RecommendTagsModel.h"
#import <UIImageView+WebCache.h>

@interface RecommendTagsCell()
@property (weak, nonatomic) IBOutlet UIImageView *HeaderLiatImageView;
@property (weak, nonatomic) IBOutlet UILabel *TagsNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *TagsloveNumLabel;

@end
@implementation RecommendTagsCell

- (void)awakeFromNib {
    // Initialization code
    
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setTagsModel:(RecommendTagsModel *)tagsModel
{
    _tagsModel=tagsModel;
    [self.HeaderLiatImageView sd_setImageWithURL:[NSURL URLWithString:tagsModel.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.TagsNameLabel.text=tagsModel.theme_name;
    NSString *subnum=nil;
    if (tagsModel.sub_number>10000) {
        subnum=[NSString stringWithFormat:@"%.1f万人订阅",tagsModel.sub_number/10000.0];
    }else
    {
        subnum=[NSString stringWithFormat:@"%.zd人订阅",tagsModel.sub_number];
    }
    self.TagsloveNumLabel.text=subnum;
}

-(void)setFrame:(CGRect)frame
{
    frame.origin.x=5;
    frame.size.width-=frame.origin.x*2;
    frame.size.height-=1;
    
    [super setFrame:frame];
    
}
@end
