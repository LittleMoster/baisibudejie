//
//  AddTagViewController.h
//  百思不得姐
//
//  Created by user on 16/9/18.
//  Copyright © 2016年 ZJQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddTagViewController : UIViewController

/** 获取tags*/
@property(nonatomic,copy)void(^tagsBlock)(NSArray *tagsArr);
/** tag数组*/
@property(nonatomic,strong)NSArray *tagsArr;
@end
