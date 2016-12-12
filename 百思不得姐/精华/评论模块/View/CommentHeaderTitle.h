//
//  CommentHeaderTitle.h
//  百思不得姐
//
//  Created by user on 16/9/7.
//  Copyright © 2016年 ZJQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentHeaderTitle : UITableViewHeaderFooterView


/** 标题*/
@property(nonatomic,strong)NSString *title;
+(instancetype)GetHeaderViewWithTableView:(UITableView*)tableView;
@end
