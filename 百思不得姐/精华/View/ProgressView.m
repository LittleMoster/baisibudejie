//
//  ProgressView.m
//  百思不得姐
//
//  Created by user on 16/8/31.
//  Copyright © 2016年 ZJQ. All rights reserved.
//

#import "ProgressView.h"

@implementation ProgressView

-(void)setProgress:(CGFloat)progress animated:(BOOL)animated
{
    [super setProgress:progress animated:animated];
    NSString *text = [NSString stringWithFormat:@"%.0f%%", progress * 100];
    self.progressLabel.text = [text stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
}
-(void)awakeFromNib{
    
    [super awakeFromNib];
    self.roundedCorners=2.0;
    self.trackTintColor=[UIColor redColor];
    self.progressLabel.textColor=[UIColor whiteColor];
}
@end
