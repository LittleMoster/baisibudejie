
#import <Foundation/Foundation.h>
/**
 *  @brief 文件工具类
 *
 *  封装提供文件相关操作
 */
@interface FileUtil : NSObject

/**
 *  计算给定路径的文件大小
 *
 *  @param path 文件路径
 *
 *  @return 文件大小
 */
+ (float)fileSizeAtPath:(NSString *)path;

/**
 *  计算给定路径的文件夹的大小
 *
 *  @param path 文件夹路径
 *
 *  @return 文件夹大小
 */
+ (float)folderSizeAtPath:(NSString *)path;

/**
 *  清理给定目录下的缓存
 *
 *  @param path 目录
 */
+ (void)clearCache:(NSString *)path;

/**
 *  计算给定路径的文件夹的大小
 *
 *  @param path 文件夹路径
 *
 *  @return 文件夹大小
 */
+ (float)getSize:(NSString *)path;

/**
 *  删除缓存，结束后回调
 *
 *  @param path     文件路径
 *  @param complete 回调操作
 */
+ (void)deleteSize:(NSString *)path complete:(void(^)())complete;
@end
