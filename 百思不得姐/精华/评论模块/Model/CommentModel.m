//
//  CommentModel.m
//  百思不得姐
//
//  Created by user on 16/9/6.
//  Copyright © 2016年 ZJQ. All rights reserved.
//

#import "CommentModel.h"
#import "MJExtension.h"
@implementation CommentModel

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"ID":@"id"};
}
@end
