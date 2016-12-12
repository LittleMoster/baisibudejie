//
//  UserModel.h
//  百思不得姐
//
//  Created by user on 16/9/6.
//  Copyright © 2016年 ZJQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

/** 用户名 */
@property (nonatomic, copy) NSString *username;
/** 性别 */
@property (nonatomic, copy) NSString *sex;
/** 头像 */
@property (nonatomic, copy) NSString *profile_image;

@end
