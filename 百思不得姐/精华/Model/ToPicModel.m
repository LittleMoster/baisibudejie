//
//  ToPicModel.m
//  百思不得姐
//
//  Created by user on 16/8/29.
//  Copyright © 2016年 ZJQ. All rights reserved.
//

#import "ToPicModel.h"
#import <MJExtension.h>
#import "CommentModel.h"
#import "UserModel.h"
@implementation ToPicModel
{
    CGFloat _cellheight;
    CGRect _pictureF;
}

+ (NSDictionary *)objectClassInArray
{
    //    return @{@"top_cmt" : [XMGComment class]};
    return @{@"top_cmt" : @"CommentModel"};
}
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"small_image": @"image0",
             @"large_image": @"image1",
             @"middle_image": @"image2",
             @"ID":@"id",
             };

}
-(NSString *)create_time
{
    // 日期格式化类
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // 设置日期格式(y:年,M:月,d:日,H:时,m:分,s:秒)
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    // 帖子的创建时间
    NSDate *create=[fmt dateFromString:_create_time];
     
    if (create.isThisYear) {
        NSDateComponents *cmps=[[NSDate date] deltaFrom:create];
        if (cmps.hour>=1) {
            return [NSString stringWithFormat:@"%zd小时前",cmps.hour];
        }else if (cmps.minute>=1)
        {
            return [NSString stringWithFormat:@"%zd分钟前",cmps.minute];
        }else
        {
            return @"刚刚";
        }
    }else
    {
        return _create_time;
    }
    
}

-(CGFloat)cellheight
{
    if (!_cellheight) {
        CGSize maxSize=CGSizeMake([UIScreen mainScreen].bounds.size.width-4*TopicCellMargin, MAXFLOAT);
        CGFloat textH=[self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;

        _cellheight=TopicCellTextY+textH+TopicCellMargin;
        if (self.type==TopicTypePicture) {//图片帖子
            // 图片显示出来的图片宽度
            CGFloat pictureW=maxSize.width;
            // 图片显示出来的图片高度
            CGFloat pictureH=maxSize.width*self.height/self.width;
            
            if (pictureH>=TopicCellPictureMaxH) {
                pictureH =TopicCellPictureBreaH;
                self.bigPicture=YES;
            }
            CGFloat pictureX=TopicCellMargin;
            CGFloat pictureY=textH+TitilesViewY;//+TopicCellMargin;
            _pictureF=CGRectMake(pictureX, pictureY, pictureW, pictureH);
            
            _cellheight+=pictureH+TopicCellMargin;
            
        
        }else if (self.type==TopicTypeVoice)
        {
            CGFloat voiceX=TopicCellMargin;
            CGFloat voiceY=textH+TitilesViewY;//+TopicCellMargin;
            CGFloat voiceW=maxSize.width;
            CGFloat voiceH=maxSize.width*self.height/self.width;
            _voiceF=CGRectMake(voiceX, voiceY, voiceW, voiceH);
            
            _cellheight+=voiceH+TopicCellMargin;
            
        }else if(self.type==TopicTypeVideo)

        {
            CGFloat voiceX=TopicCellMargin;
            CGFloat voiceY=textH+TitilesViewY;//+TopicCellMargin;
            CGFloat voiceW=maxSize.width;
            CGFloat voiceH=maxSize.width*self.height/self.width;
            _videoF=CGRectMake(voiceX, voiceY, voiceW, voiceH);
            
            _cellheight+=voiceH+TopicCellMargin;
        }
        CommentModel *com=[self.top_cmt firstObject];
        if (com) {
            CGFloat commtextH=[[NSString stringWithFormat:@"%@:%@",com.user.username,com.content] boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size.height;
            _cellheight+=TopicCellComTitleMaxH+commtextH;
        }
        
        //底部工具条高度
        _cellheight+=TopicCellBottomBarH+TopicCellMargin;

    }
    return _cellheight;
}

@end
