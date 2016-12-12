//
//  TopicCell.h
//  百思不得姐
//
//  Created by user on 16/8/29.
//  Copyright © 2016年 ZJQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToPicModel.h"
@interface TopicCell : UITableViewCell

/** 数据模型*/
@property(nonatomic,strong)ToPicModel *topic;
+(instancetype)GetCell;
@end
