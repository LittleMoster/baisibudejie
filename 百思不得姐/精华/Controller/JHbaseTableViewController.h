//
//  JHbaseTableViewController.h
//  百思不得姐
//
//  Created by user on 16/8/29.
//  Copyright © 2016年 ZJQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHbaseTableViewController : UITableViewController
/** 帖子类型(交给子类去实现) */
@property (nonatomic, assign) TopicType type;
@end
