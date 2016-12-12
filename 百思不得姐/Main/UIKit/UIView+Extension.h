//
//  UIView+Extension.h
//  百思不得姐
//
//  Created by user on 16/8/1.
//  Copyright © 2016年 ZJQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)


@property(nonatomic,assign)CGFloat width;
@property(nonatomic,assign)CGFloat height;
@property(nonatomic,assign)CGFloat x;
@property(nonatomic,assign)CGFloat y;
@property(nonatomic,assign)CGFloat centerX;
@property(nonatomic,assign)CGFloat centerY;
@property (nonatomic, assign) CGSize size;
/**  该方法用于判断当前视图是否显示在Window上*/
- (BOOL)isShowingOnKeyWindow;
@end
