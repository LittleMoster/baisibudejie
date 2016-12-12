//
//  CommentCell.m
//  百思不得姐
//
//  Created by user on 16/9/9.
//  Copyright © 2016年 ZJQ. All rights reserved.
//

#import "CommentCell.h"
#import "CommentModel.h"
#import <UIImageView+WebCache.h>
#import "UserModel.h"
@interface CommentCell()
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UIImageView *SexImageView;
@property (weak, nonatomic) IBOutlet UILabel *UserNameLAbel;
@property (weak, nonatomic) IBOutlet UILabel *CommentLabel;
@property (weak, nonatomic) IBOutlet UILabel *LakeCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *voideButton;

@end
@implementation CommentCell

- (void)awakeFromNib {
    UIImageView *bgView=[[UIImageView alloc]init];
    bgView.image=[UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView=bgView;
    
    [super awakeFromNib];
    
}
-(void)setFrame:(CGRect)frame
{
    frame.origin.x=TopicCellMargin;
    frame.size.width-=2*TopicCellMargin;
    [super setFrame:frame];
}
-(BOOL)canBecomeFirstResponder
{
    return YES;
}
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    return NO;
}
-(void)setComment:(CommentModel *)comment
{
    _comment=comment;
    
    self.CommentLabel.text=comment.content;
    self.UserNameLAbel.text=comment.user.username;
    
    if (comment.like_count>9999) {
        self.LakeCountLabel.text=[NSString stringWithFormat:@"%.2ld",comment.like_count/10000];

    }else
    {
    self.LakeCountLabel.text=[NSString stringWithFormat:@"%ld",comment.like_count];
    }
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:comment.user.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    if ([comment.user.sex isEqualToString:UserSexMale]){
      self.SexImageView.image=[UIImage imageNamed:@"Profile_manIcon"];
    }else
    {
      self.SexImageView.image=[UIImage imageNamed:@"Profile_womanIcon"];
    }
    
    if (comment.voiceuri.length) {
        self.voideButton.hidden=NO;
        [self.voideButton setTitle:[NSString stringWithFormat:@"%ld''",comment.voicetime] forState:UIControlStateNormal];
        
    }else
    {
        self.voideButton.hidden=YES;
    }
    
    
    
    
}


@end
