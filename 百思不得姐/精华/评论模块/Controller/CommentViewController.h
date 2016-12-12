//
//  CommentViewController.h
//  百思不得姐
//
//  Created by user on 16/9/6.
//  Copyright © 2016年 ZJQ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ToPicModel;
@interface CommentViewController : UIViewController


/** 帖子模型*/
@property(nonatomic,strong)ToPicModel *topic;
@end
