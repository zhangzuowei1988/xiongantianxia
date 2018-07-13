//
//  SandboxFile.h
//  SKY
//
//  Author   Created by mac  on 12-9-19.
//  Copyright (c) 2012年 SKY. All rights reserved.
//  Sand Box foundation Class


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
/*!
 *	@brief	文件的相关操作，创建文件路径，存储文件，删除文件，
 */
@interface PDMISandboxFile : NSObject



/*!
 *	@brief	获取程序的Home目录路径
 *
 *	@return	返回home 目录路径
 */
+(NSString *)getHomeDirectoryPath;


/*!
 *	@brief	获取document目录路径，iTunes备份和恢复的时候会包括此目录。
 *
 *	@return	返回 document 目录路径
 */
+(NSString *)getDocumentPath;


/*!
 *	@brief	获取Cache目录路径，存放缓存文件，iTunes不会备份此目录，此目录下文件不会在应用退出删除 
 *
 *	@return	返回cache 目录路径
 */
+(NSString *)getCachePath;


/*!
 *	@brief	获取Library目录路径
 *
 *	@return	返回library 目录路径
 */
+(NSString *)getLibraryPath;


/*!
 *	@brief	获取Tmp目录路径，存放临时文件，iTunes不会备份和恢复此目录，此目录下文件可能会在应用退出后删除
 *
 *	@return	返回temp 目录路径
 */
+(NSString *)getTmpPath;



/*!
 *	@brief	根据路径创建文件
 *
 *	@param 	filePath 	文件夹的存储路径
 *	@param 	error 	    error信息
 *
 *	@return	是否创建成功
 */
+(BOOL)createFilePath:(NSString *)filePath error:(NSError **)error;


/*!
 *	@brief	判断文件路径是否存在
 *
 *	@param 	filepath 	指定文件路径
 *
 *	@return	文件是否存在
 */
+(BOOL)isFileExists:(NSString *)filepath;



/*!
 *	@brief	删除文件
 *
 *	@param 	filepath 	删除文件路径
 *	@param 	error 	    error信息
 *
 *	@return	是否删除成功
 */
+(BOOL)deleteFile:(NSString*)filepath error:(NSError **)error;

/*!
 *	@brief	复制一个文件到一个具体位置
 *
 *	@param 	srcPath 	原文件存储位置
 *	@param 	dstPath 	目标文件存储位置
 *	@param 	error 	    error信息
 *
 *	@return	是否复制成功
 */
+(BOOL)copyFileAtPath:(NSString *)srcPath toPath:(NSString *)dstPath error:(NSError **)error;

/*!
 *	@brief	把一个文件移动到指定位置
 *
 *	@param 	srcPath 	原文件存储路径
 *	@param 	dstPath 	目标文件存储路径
 *	@param 	error 	error信息
 *
 *	@return	是否移动成功
 */
- (BOOL)moveFileAtPath:(NSString *)srcPath toPath:(NSString *)dstPath error:(NSError **)error;



/*!
 *	@brief	获取目录列表里所有的文件名
 *
 *	@param 	path 	指定的目录文件
 *
 *	@return	返回指定文件内的文件夹名
 */
+(NSArray *)getSubpathsAtPath:(NSString *)path;

/*!
 *	@brief	计算文件夹下文件的总大小
 *
 *	@param 	path 	指定文件夹路径
 *
 *	@return	返回文件夹下文件的总大小 KB
 */
+(float)fileSizeForDir:(NSString*)path;



/*!
 *	@brief	写入可变数组到指定路径
 *
 *	@param 	arrarObject 	数组对象
 *	@param 	path 	数组存储路径
 *	@param 	error 	    error信息
 *
 *	@return	返回是否存储成功
 */
+(BOOL)writeArray:(NSMutableArray *)arrarObject toFilePath:(NSString *)path error:(NSError **)error;

/*!
 *	@brief	追加数组数据到已经存储的数组
 *
 *	@param 	arrarObject 	新添加的数组数据
 *	@param 	path 	数组存储路径
 *
 *	@return	返回是否追加成功
 */
+(BOOL)addArray:(NSMutableArray *)arrarObject toFilePath:(NSString *)path;
/*!
 *	@brief	获取存储的数组数据
 *
 *	@param 	path 	指定获取数组存储路径
 *
 *	@return	返回数组数据
 */
+(NSMutableArray *)loadArrayFromFilePath:(NSString *)path;


/*!
 *	@brief	存储对象，对象必须遵循 NSCoding 协议
 *
 *	@param 	object 	遵循NSCoding的对象
 *	@param 	path 	指定存储路径
 *	@param 	error 	    error信息
 *
 *	@return	返回是否序列化成功
 */
+(BOOL)writeObject:(id)object toFilePath:(NSString *)path  error:(NSError **)error;


/*!
 *	@brief	获取存储的序列化对象
 *
 *	@param 	path 	指定获取路径
 *
 *	@return	返回存储的序列化对象，失败返回nil
 */
+ (id)loadObjectFromFilePath:(NSString *)path ;

/*!
 *	@brief	写入NSdata数据
 *
 *	@param 	data 	存储的data数据
 *	@param 	path 	指定存储路径
 *	@param 	error 	    error信息
 *
 *	@return	返回是否存储成功
 */
+(BOOL)writeData:(NSData *)data toFilePath:(NSString *)path  error:(NSError **)error;


/*!
 *	@brief	追加data数据到原来的数据
 *
 *	@param 	data 	要追加的data 数据
 *	@param 	path 	数据存储路径
 *
 *	@return	是否追加数据成功。
 */
+(BOOL)addData:(NSData *)data toFilePath:(NSString *)path;

/*!
 *	@brief	获取NSdata 数据
 *
 *	@param 	path 	指定获取路径
 *
 *	@return	返回data数据
 */
+ (NSData *)loadDataFromFilePath:(NSString *)path ;

/*!
 *	@brief	存储image对象
 *
 *	@param 	img 	image对象
 *	@param 	path 	image对象的存储路径
 *
 *	@return	是否存储成功
 */
+(BOOL)writeUImage:(UIImage *)img toFilePath:(NSString *)path;

/*!
 *	@brief	获取存储的image对象
 *
 *	@param 	path 	image对象的存储路径
 *
 *	@return	返回存储对象
 */
+(UIImage *)loadImageFromFilePath:(NSString *)path;



/*!
 *	@brief	磁盘总空间
 *
 *	@return 返回磁盘总空间大小 kb
 */
+ (NSNumber *)totalDiskSpace;

/*!
 *	@brief	剩余空间大小
 *
 *	@return	返回磁盘剩余空间大小 kb
 */
+ (NSNumber *)freeDiskSpace;


/**
 下载文件的路径

 @param fileName 文件名
 @return 文件路径
 */
+ (NSString *)downloadFilePath:(NSString*)fileName;

/**
 获取zip文件格式的路径

 @param fileName 文件名称
 @return 文件路径
 */
+ (NSString *)downloadFileZipPath:(NSString*)fileName;

@end
