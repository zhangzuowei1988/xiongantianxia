//
//  SandboxFile.m
//  SKY
//
//  Created by mac  on 12-9-19.
//  Copyright (c) 2012年 SKY. All rights reserved.
//

#import "PDMISandboxFile.h"
#import "NSString+md5.h"
@implementation PDMISandboxFile


+(NSString *)getHomeDirectoryPath
{
    return NSHomeDirectory();
}

+(NSString *)getDocumentPath
{
    NSArray *Paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path=[Paths objectAtIndex:0];
   

    return path;
}

+(NSString *)getCachePath
{
    NSArray *Paths=NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *path=[Paths objectAtIndex:0];
    return path;
}

+(NSString *)getLibraryPath
{
    NSArray *Paths=NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *path=[Paths objectAtIndex:0];
    return path;
}

+(NSString *)getTmpPath
{
    return NSTemporaryDirectory();
}

+(NSString *)getDirectoryForDocuments:(NSString *)dir
{
    NSError* error;
    NSString* path = [[self getDocumentPath] stringByAppendingPathComponent:dir];
    if(![[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error])
    {
        NSLog(@"create dir error: %@",error.debugDescription);
    }
    return path;
}

+(NSString *)getDirectoryForCaches:(NSString *)dir
{
    NSError* error;
    NSString* path = [[self getCachePath] stringByAppendingPathComponent:dir];
    
    if(![[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error])
    {
        NSLog(@"create dir error: %@",error.debugDescription);
    }
    return path;
}
+(BOOL)createFilePath:(NSString *)filePath error:(NSError **)error;
{
    
    if ([self isFileExists:filePath])
    {
        return YES;
    }
    else
    {
        NSFileManager *fileManager=[NSFileManager defaultManager];

       return  [fileManager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:error];
    }
   
}

+(BOOL)writeArray:(NSMutableArray *)arrarObject toFilePath:(NSString *)path error:(NSError **)error
{
   
    if ([self createFilePath:[path stringByDeletingLastPathComponent] error:error]) {
          return [arrarObject writeToFile:path atomically:YES];
    }else{
    return NO;
    }
}

+(BOOL)addArray:(NSMutableArray *)arrarObject toFilePath:(NSString *)path
{
    NSMutableArray *arr = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    [arr addObjectsFromArray:arrarObject];
    return [ arr writeToFile:path atomically:YES ];
}

+(NSMutableArray *)loadArrayFromFilePath:(NSString *)path
{
    
    return  [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}

+(BOOL)writeObject:(id)object toFilePath:(NSString *)path  error:(NSError **)error;
{
    
    if ([self createFilePath:[path stringByDeletingLastPathComponent] error:error]) {
        return  [NSKeyedArchiver archiveRootObject:object toFile:path];
 
    }else{
        return NO;
    }
}
+ (id)loadObjectFromFilePath:(NSString *)path
{
    id obj = nil;
    @try {
        obj = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    }
    @catch (NSException *exception) {
        obj = nil;
        NSLog(@"Exception : %@", exception);
    }
    @finally {
        
    }
    return obj;
   
}
+(BOOL)writeData:(NSData *)data toFilePath:(NSString *)path  error:(NSError **)error;
{
   
    if ([self createFilePath:[path stringByDeletingLastPathComponent] error:error]) {
        return [data writeToFile:path atomically:YES];

    }else{
        return NO;
    }
    
}
+(BOOL)addData:(NSData *)data toFilePath:(NSString *)path
{
    NSMutableData *originData=[NSMutableData dataWithContentsOfFile:path];
    [originData appendData:data];
    return [data writeToFile:path atomically:YES];
}

+ (NSData *)loadDataFromFilePath:(NSString *)path
{
    return [NSData dataWithContentsOfFile:path];
}
+(BOOL)writeUImage:(UIImage *)img toFilePath:(NSString *)path;
{
    NSData *data;
    
    if (UIImagePNGRepresentation(img) == nil) {
        
        data = UIImageJPEGRepresentation(img, 1);
        
    } else {
        
        data = UIImagePNGRepresentation(img);
        
    }
    return [data writeToFile:path atomically:YES];
}
+(UIImage *)loadImageFromFilePath:(NSString *)path
{
    return [UIImage imageWithData:[NSData dataWithContentsOfFile:path]];
}

+(BOOL)isFileExists:(NSString *)filepath
{
   return [[NSFileManager defaultManager] fileExistsAtPath:filepath];
}
+(BOOL)deleteFile:(NSString*)filepath error:(NSError **)error;
{
   
    if([[NSFileManager defaultManager]fileExistsAtPath:filepath])
    {
       return  [[NSFileManager defaultManager] removeItemAtPath:filepath error:error];
    }
    return NO;
}
+(BOOL)copyFileAtPath:(NSString *)srcPath toPath:(NSString *)dstPath error:(NSError **)error
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:dstPath]==NO) {
        [[NSFileManager defaultManager] createDirectoryAtPath:dstPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return [[NSFileManager defaultManager]  copyItemAtPath:srcPath toPath:dstPath error:error];
}
- (BOOL)moveFileAtPath:(NSString *)srcPath toPath:(NSString *)dstPath error:(NSError **)error
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:dstPath]==NO) {
        [[NSFileManager defaultManager] createDirectoryAtPath:dstPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return [[NSFileManager defaultManager]  moveItemAtPath:srcPath toPath:dstPath error:error];
}
+(NSArray *)getSubpathsAtPath:(NSString *)path
{
    NSFileManager *fileManage=[NSFileManager defaultManager];
    NSArray *file=[fileManage subpathsAtPath:path];
    return file;
}

+(void)deleteAllForDocumentsDir:(NSString *)dir
{
    NSFileManager* fileManager = [NSFileManager defaultManager];
    NSArray *fileList = [fileManager contentsOfDirectoryAtPath:[self getDirectoryForDocuments:dir] error:nil];
    for (NSString* filename in fileList) {
        [fileManager removeItemAtPath:[self GetPathForDocuments:filename inDir:dir] error:nil];
    }
}

+(float)fileSizeForDir:(NSString*)path//计算文件夹下文件的总大小
{
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    float size =0;
    NSArray* array =[fileManager contentsOfDirectoryAtPath:path error:nil];
    for(int i = 0; i<[array count]; i++)
    {
        NSString *fullPath = [path stringByAppendingPathComponent:[array objectAtIndex:i]];
        
        BOOL isDir;
        if ( !([fileManager fileExistsAtPath:fullPath isDirectory:&isDir] && isDir) )
        {
            NSDictionary *fileAttributeDic=[fileManager attributesOfItemAtPath:fullPath error:nil];
            size+= fileAttributeDic.fileSize/ 1024.0;
        }
        else
        {
            size+=[self fileSizeForDir:fullPath];
        }
    }
    
    return size;
}



+ (NSNumber *)totalDiskSpace

{
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    
    return [fattributes objectForKey:NSFileSystemSize];
    
}

+ (NSNumber *)freeDiskSpace

{
    NSDictionary *fattributes = [[NSFileManager defaultManager] attributesOfFileSystemForPath:NSHomeDirectory() error:nil];
    
    return [fattributes objectForKey:NSFileSystemFreeSize];
    
}
#pragma mark- 获取文件的数据
+(NSData *)GetDataForPath:(NSString *)path
{
    return [[NSFileManager defaultManager] contentsAtPath:path];
}
+(NSData *)GetDataForResource:(NSString *)name inDir:(NSString *)dir
{
    return [self GetDataForPath:[self GetPathForResource:name inDir:dir]];
}
+(NSData *)GetDataForDocuments:(NSString *)name inDir:(NSString *)dir
{
    return [self GetDataForPath:[self GetPathForDocuments:name inDir:dir]];

}



#pragma mark- 获取文件路径
+(NSString *)GetPathForResource:(NSString *)name
{
    return [[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:name];
}

+(NSString *)GetPathForResource:(NSString *)name inDir:(NSString *)dir
{
    return [[[NSBundle mainBundle].resourcePath stringByAppendingPathComponent:dir] stringByAppendingPathComponent:name];
}

+ (NSString *)GetPathForDocuments:(NSString *)filename
{
    return [[self getDocumentPath] stringByAppendingPathComponent:filename];
}

+(NSString *)GetPathForDocuments:(NSString *)filename inDir:(NSString *)dir
{
    return [[self getDirectoryForDocuments:dir] stringByAppendingPathComponent:filename];
}

+(NSString *)GetPathForCaches:(NSString *)filename
{
    return [[self getCachePath] stringByAppendingPathComponent:filename];
}

+(NSString *)GetPathForCaches:(NSString *)filename inDir:(NSString *)dir
{
    return [[self getDirectoryForCaches:dir] stringByAppendingPathComponent:filename];
}
+ (NSString *)downloadFilePath:(NSString*)fileName
{
    NSString *downloadFile =  [[PDMISandboxFile getDocumentPath] stringByAppendingPathComponent:@"downloadFile"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:downloadFile]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:downloadFile withIntermediateDirectories:YES attributes:nil error:nil];
    }
 //   downloadFile = [downloadFile stringByAppendingPathComponent:[fileName md5HexDigest]];
//    downloadFile = [downloadFile stringByAppendingPathExtension:fileName.pathExtension];
    NSArray *fileArray = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:downloadFile error:nil];
    NSString *filePath;
    for (NSString *fileNameStr in fileArray) {
        if ([fileNameStr containsString:[fileName md5HexDigest]]) {
            filePath = fileNameStr;
        }
    }
    if (filePath.length==0) {
        return nil;
    }
    return [downloadFile stringByAppendingPathComponent:filePath];
}
+ (NSString *)downloadFileZipPath:(NSString*)fileName
{
    NSString *downloadFile =  [[PDMISandboxFile getDocumentPath] stringByAppendingPathComponent:@"downloadFile"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:downloadFile]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:downloadFile withIntermediateDirectories:YES attributes:nil error:nil];
    }
    downloadFile = [downloadFile stringByAppendingPathComponent:[fileName md5HexDigest]];
    NSArray *fileArray = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:downloadFile error:nil];
    if (fileArray.count>0) {
        downloadFile =[downloadFile stringByAppendingString:fileArray.firstObject];
    } else
        downloadFile = nil;
    return downloadFile;
}
@end
