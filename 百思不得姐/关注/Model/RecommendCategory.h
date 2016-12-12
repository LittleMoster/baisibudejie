//
//  RecommendCategory.h
//  百思不得姐
//
//  Created by user on 16/8/3.
//  Copyright © 2016年 ZJQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecommendCategory : NSObject


/** id*/
@property(nonatomic,assign)NSInteger id;
/** 名字*/
@property(nonatomic,strong)NSString *name;
/** 总数*/
@property(nonatomic,assign)NSInteger count;


/** 右边用户数据数组*/
@property(nonatomic,strong)NSMutableArray *users;
/** 总数 */
@property (nonatomic, assign) NSInteger total;
/** 当前页码 */
@property (nonatomic, assign) NSInteger currentPage;
@end
