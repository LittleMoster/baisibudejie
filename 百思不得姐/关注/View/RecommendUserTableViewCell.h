//
//  RecommendUserTableViewCell.h
//  百思不得姐
//
//  Created by user on 16/8/3.
//  Copyright © 2016年 ZJQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryUserModel.h"

@interface RecommendUserTableViewCell : UITableViewCell


/** 右边数据模型*/
@property(nonatomic,strong)CategoryUserModel *UserModel;
@end
