//
//  CommentCell.h
//  百思不得姐
//
//  Created by user on 16/9/9.
//  Copyright © 2016年 ZJQ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CommentModel;
@interface CommentCell : UITableViewCell

/** 评论模型*/
@property(nonatomic,strong)CommentModel *comment;
@end
