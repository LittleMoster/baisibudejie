//
//  TopicCell.m
//  百思不得姐
//
//  Created by user on 16/8/29.
//  Copyright © 2016年 ZJQ. All rights reserved.
//

#import "TopicCell.h"
#import "TopicPictureView.h"
#import <UIImageView+WebCache.h>
#import "TopicVoiceView.h"
#import "TopicVideoView.h"
#import "CommentModel.h"
#import "UserModel.h"
#import "UIImageView+Extension.h"
@interface TopicCell ()
/**帖子的文件内容*/
@property (weak, nonatomic) IBOutlet UILabel *topictextlabel;
/**新浪加V图标*/
@property (weak, nonatomic) IBOutlet UIImageView *V_sina;
/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
/** 昵称 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** 时间 */
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
/** 顶 */
@property (weak, nonatomic) IBOutlet UIButton *dingButton;
/** 踩 */
@property (weak, nonatomic) IBOutlet UIButton *caiButton;
/** 分享 */
@property (weak, nonatomic) IBOutlet UIButton *shareButton;
/** 评论 */
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
/** 评论文字 */
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
/** 评论视图 */
@property (weak, nonatomic) IBOutlet UIView *CommentView;

/** 中间内容图片帖子*/
@property(nonatomic,strong)TopicPictureView *pictureView;
/** 中间内容图片帖子*/
@property(nonatomic,strong)TopicVoiceView *voiceView;
/** 中间内容图片帖子*/
@property(nonatomic,strong)TopicVideoView *videoView;
@end
@implementation TopicCell


+(instancetype)GetCell
{
    return  [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]firstObject];
}
-(TopicPictureView *)pictureView
{
    if (!_pictureView) {
        TopicPictureView *picture=[TopicPictureView setPictureView];
        [self.contentView addSubview:picture];
        _pictureView=picture;
    }
    return _pictureView;
}
-(TopicVideoView *)videoView
{
    if (!_videoView) {
        TopicVideoView *picture=[TopicVideoView setVideoView];
        [self.contentView addSubview:picture];
        _videoView=picture;
    }
    return _videoView;
}
-(TopicVoiceView *)voiceView
{
    if (!_voiceView) {
        TopicVoiceView *picture=[TopicVoiceView setVoiceView];
        [self.contentView addSubview:picture];
        _voiceView=picture;
    }
    return _voiceView;
}
- (void)awakeFromNib {
    UIImageView *bgView=[[UIImageView alloc]init];
    bgView.image=[UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView=bgView;
    
    [super awakeFromNib];
}
-(void)setTopic:(ToPicModel *)topic
{
    _topic=topic;
    // 设置其他控件
   
    self.V_sina.hidden=!topic.isSina_v;
//    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    [self.profileImageView setcircleImageUrl:topic.profile_image setCirclePlaceholder:@"defaultUserIcon"];
    
    self.nameLabel.text = topic.name;
    //设置时间，格式处理在模型类里
    self.createTimeLabel.text = topic.create_time;
    
    // 设置按钮文字
    [self setupButtonTitle:self.dingButton count:topic.ding placeholder:@"顶"];
    [self setupButtonTitle:self.caiButton count:topic.cai placeholder:@"踩"];
    [self setupButtonTitle:self.shareButton count:topic.repost placeholder:@"分享"];
    [self setupButtonTitle:self.commentButton count:topic.comment placeholder:@"评论"];
    
//    文字内容
    self.topictextlabel.text=topic.text;
    
    if (topic.type==TopicTypePicture) {//如果是图片帖子
        self.voiceView.hidden=YES;
        self.pictureView.hidden=NO;
        self.videoView.hidden=YES;
        self.pictureView.topic=topic;
        self.pictureView.frame=topic.pictureF;
    }
    if (topic.type==TopicTypeVoice) {//如果是声音帖子
        self.voiceView.hidden=NO;
        self.pictureView.hidden=YES;
        self.videoView.hidden=YES;
        self.voiceView.topic=topic;
        self.voiceView.frame=topic.voiceF;
    } if (topic.type==TopicTypeVideo) {//如果是视频帖子
        self.voiceView.hidden=YES;
        self.pictureView.hidden=YES;
        self.videoView.hidden=NO;
        self.videoView.topic=topic;
        self.videoView.frame=topic.videoF;
    }if (topic.type==TopicTypeWord) {
        self.voiceView.hidden=YES;
        self.pictureView.hidden=YES;
        self.videoView.hidden=YES;
    }
    //处理最热文字
    CommentModel *com=[topic.top_cmt firstObject];
    if (com) {
        self.CommentView.hidden=NO;
        self.commentLabel.text=[NSString stringWithFormat:@"%@:%@",com.user.username,com.content];
    }else
    {
        self.CommentView.hidden=YES;
    }
    

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
/**
 * 设置底部按钮文字
 */
- (void)setupButtonTitle:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder
{
    if (count > 10000) {
        placeholder = [NSString stringWithFormat:@"%.1f万", count / 10000.0];
    } else if (count > 0) {
        placeholder = [NSString stringWithFormat:@"%zd", count];
    }
    [button setTitle:placeholder forState:UIControlStateNormal];
}

- (void)setFrame:(CGRect)frame
{
    static CGFloat margin = 10;
    
    frame.origin.x = margin;
    frame.size.width -= 2 * margin;
//    frame.size.height -= margin;
    frame.size.height=self.topic.cellheight-margin;
    frame.origin.y += margin;
    
    [super setFrame:frame];
}
- (IBAction)DingAction:(id)sender {
}
- (IBAction)CaiAction:(id)sender {
}
- (IBAction)ShareAction:(id)sender {
}
- (IBAction)CommentAction:(id)sender {
   
    
}

@end
