

#import "FileUtil.h"
#import <UIImageView+WebCache.h>

@implementation FileUtil

+ (float)fileSizeAtPath:(NSString *)path {
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path]){
        long long size=[fileManager attributesOfItemAtPath:path error:nil].fileSize;
        return size/1024.0/1024.0;
    }
    return 0;
}

+ (float)folderSizeAtPath:(NSString *)path {
    NSFileManager *fileManager=[NSFileManager defaultManager];
    float folderSize;
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            folderSize +=[FileUtil fileSizeAtPath:absolutePath];
            NSLog(@"%zd",folderSize);
        }
        //SDWebImage框架自身计算缓存的实现
        folderSize+=[[SDImageCache sharedImageCache] getSize]/1024.0/1024.0;
        return folderSize;
    }
    return 0;
}

+ (void)clearCache:(NSString *)path {
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:path]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:path];
        for (NSString *fileName in childerFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件
            NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:absolutePath error:nil];
        }
    }
    [[SDImageCache sharedImageCache] cleanDisk];
}
/**
 *  传入文件夹路径，计算其大小
 *
 *  @param path 文件夹路径
 */
+ (float)getSize:(NSString *)path
{
    NSFileManager *manager = [NSFileManager defaultManager];
    
//    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
//    NSString *cachePath = [caches stringByAppendingPathComponent:@"default/com.hackemist.SDWebImageCache.default"];
    
    NSDirectoryEnumerator *fileEnumerator = [manager enumeratorAtPath:path];
    NSInteger totalSize = 0;
    for (NSString *fileName in fileEnumerator) {
        NSString *filepath = [path stringByAppendingPathComponent:fileName];
        
        //        BOOL dir = NO;
        // 判断文件的类型：文件\文件夹
        //        [manager fileExistsAtPath:filepath isDirectory:&dir];
        //        if (dir) continue;
        NSDictionary *attrs = [manager attributesOfItemAtPath:filepath error:nil];
        if ([attrs[NSFileType] isEqualToString:NSFileTypeDirectory]) continue;
        
        totalSize += [attrs[NSFileSize] integerValue];
        
       
    }
//    totalSize+=[[SDImageCache sharedImageCache] getSize];
    
    float total= totalSize/1000.0/1000.0;
   
        return total;
}
+ (void)deleteSize:(NSString *)path complete:(void(^)())complete
{
    NSFileManager *manager = [NSFileManager defaultManager];
    
    //    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    //    NSString *cachePath = [caches stringByAppendingPathComponent:@"default/com.hackemist.SDWebImageCache.default"];
    
    NSDirectoryEnumerator *fileEnumerator = [manager enumeratorAtPath:path];
    for (NSString *fileName in fileEnumerator) {
        NSString *absolutePath=[path stringByAppendingPathComponent:fileName];
        [manager removeItemAtPath:absolutePath error:nil];
        
        
    }
    
//    [[SDImageCache sharedImageCache] cleanDisk];
    if (complete) {
        complete();
    }

}
@end
