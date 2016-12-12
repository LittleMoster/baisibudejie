//
//  RecommendCategory.m
//  百思不得姐
//
//  Created by user on 16/8/3.
//  Copyright © 2016年 ZJQ. All rights reserved.
//

#import "RecommendCategory.h"

@implementation RecommendCategory

-(NSMutableArray *)users
{
    if (!_users) {
        _users=[NSMutableArray array];
    }
    return _users;
}
@end
