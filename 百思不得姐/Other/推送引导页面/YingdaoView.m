//
//  YingdaoView.m
//  百思不得姐
//
//  Created by user on 16/8/5.
//  Copyright © 2016年 ZJQ. All rights reserved.
//

#import "YingdaoView.h"

@implementation YingdaoView

+(void)ShowView
{
    NSString *key = @"CFBundleShortVersionString";
    // 获得当前软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    // 获得沙盒中存储的版本号
    NSString *sanboxVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    
    if (![currentVersion isEqualToString:sanboxVersion]) {
       
        
        YingdaoView *view=[[[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil]firstObject];
        
        UIWindow *window=[UIApplication sharedApplication].keyWindow;
        view.frame=window.bounds;
        [window addSubview:view];
        
        // 存储版本号
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }

}
- (IBAction)Edit {
    
    [self removeFromSuperview];
}

@end
