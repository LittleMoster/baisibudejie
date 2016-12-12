//
//  RecommendTagsCell.h
//  百思不得姐
//
//  Created by user on 16/8/4.
//  Copyright © 2016年 ZJQ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RecommendTagsModel;
@interface RecommendTagsCell : UITableViewCell

/** 标签数据模型*/
@property(nonatomic,strong)RecommendTagsModel *tagsModel;
@end
