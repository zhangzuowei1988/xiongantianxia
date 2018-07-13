//
//  WorkRoomNetWork.m
//  WorkRoom
//
//  Created by pdmi on 2017/2/13.
//  Copyright © 2017年 pdmcom.pdmi.test. All rights reserved.
//


#import "NewsNetWork.h"
#import "PDMISandboxFile.h"
#import "NSDictionary+URLParam.h"
#import "NewsAgent.h"
#import "MAgent.h"
#import "NSString+md5.h"
#import "SSZipArchive.h"
@implementation NewsNetWork


static NSTimeInterval timeout=20;
+(NewsNetWork *)shareInstance
{
    static NewsNetWork *manager=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager=[[NewsNetWork alloc] init];
    });
    return manager;
}

- (id)init
{
    self = [super init];
    if (self)
    {
        self.operationQueue = [[NSOperationQueue alloc] init];
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        self.manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    }
    return self;
}
#pragma mark - 获取短信验证码
-(void)getPhoneCodeWithDic:(NSDictionary *)dic WithComplete:(NewsCompleteBlock)completeBlock withErrorBlock:(NewsErrorBlock)errorBlock
{

    NSString *url=[NSString stringWithFormat:@"%@%@",pupBaseUrl,@"iup-asserver/message"];
    NSMutableURLRequest *request=[[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:url parameters:dic error:nil];
    
    [request setTimeoutInterval:timeout];
    
    NSURLSessionDataTask *dataTask = [_manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"Error: %@", error);
            errorBlock(error);
        } else {
            NSLog(@"%@ %@", response, responseObject);
            
            
            NSError *error;
            id jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
            NSLog(@"%@",jsonObject);
            completeBlock(jsonObject);
            
        }
        
        
    }];
    [dataTask resume];
    
    
}
#pragma mark - 短信验证码登录
-(void)loginWithPhoneCodeDic:(NSDictionary *)dic WithComplete:(NewsCompleteBlock)completeBlock withErrorBlock:(NewsErrorBlock)errorBlock
{
    NSString *url=[NSString stringWithFormat:@"%@%@",pupBaseUrl,@"iup-asserver/user/linklogin"];
    NSMutableURLRequest *request=[[AFJSONRequestSerializer serializer] requestWithMethod:@"GET" URLString:url parameters:dic error:nil];
    NSLog(@"\nRequest code  : %@?%@",url,[dic URLParam]);
    
    [request setTimeoutInterval:timeout];
    

    NSURLSessionDataTask *dataTask = [_manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"Error: %@", error);
            errorBlock(error);
        } else {
            NSError *error;
            id jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
            NSLog(@"%@",jsonObject);
            completeBlock(jsonObject);
        }
        
    }];
    [dataTask resume];
    
}
//修改个人信息
#pragma mark 修改个人信息
-(void)updatePersonInfomation:(NSDictionary *)dic WithComplete:(NewsCompleteBlock)completeBlock withErrorBlock:(NewsErrorBlock)errorBlock
{
    NSMutableDictionary *paramDic=[[NSMutableDictionary alloc]init];
    [paramDic setObject:[CommData shareInstance].userModel.loginkey forKey:@"loginkey"];
    [paramDic setObject:[CommData shareInstance].userModel.token forKey:@"userid"];
    [paramDic setObject:client_id forKey:@"client_id"];
    [paramDic setObject:client_secret forKey:@"client_secret"];
    [paramDic setObject:[CommData shareInstance].userModel.token forKey:@"token"];
    [paramDic setObject:@"" forKey:@"birthday"];
    [paramDic setObject:@"" forKey:@"career"];
    [paramDic setObject:@"" forKey:@"emailbox"];
    [paramDic setObject:@"" forKey:@"mobilephone"];
    [paramDic setObject:@"" forKey:@"headpicpath"];
    [paramDic setObject:@"" forKey:@"nickname"];
    [paramDic setObject:@"" forKey:@"gender"];
    [paramDic setValuesForKeysWithDictionary:dic];
    
    NSString *url=[NSString stringWithFormat:@"%@%@",pupBaseUrl,@"iup-asserver/user_info_update"];
    NSMutableURLRequest *request=[[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:url parameters:paramDic error:nil];
    
    [request setTimeoutInterval:timeout];
    

    NSURLSessionDataTask *dataTask = [_manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        
        if (error) {
            NSLog(@"Error: %@", error);
            errorBlock(error);
        } else {
            NSError *error;
            id jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
            
            NSLog(@"%@",jsonObject);
            NSLog(@"%@",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
            completeBlock(jsonObject);
        }
        
    }];
    [dataTask resume];
    
    
    
}
#pragma mark - 修改个人头像
-(void)updatePersonPhotoWithDic:(NSDictionary *)dic WithComplete:(NewsCompleteBlock)completeBlock withErrorBlock:(NewsErrorBlock)errorBlock
{
    
    
    NSString *url=[NSString stringWithFormat:@"%@%@",pupBaseUrl,@"iup-userservice/previewlast"];
    
    NSMutableURLRequest *request=[[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:url parameters:dic error:nil];
    
    [request setTimeoutInterval:timeout];
    

    NSURLSessionDataTask *dataTask = [_manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        
        if (error) {
            NSLog(@"Error: %@", error);
            errorBlock(error);
        } else {
            NSError *error;
            id jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
            
            NSLog(@"%@",jsonObject);
            NSLog(@"%@",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
            completeBlock(jsonObject);
        }
        
    }];
    [dataTask resume];
    
    
    
    
}
//获取个人信息
#pragma mark 获取个人信息
-(void)getPersonInformationWithComplete:(NewsCompleteBlock)completeBlock withErrorBlock:(NewsErrorBlock)errorBlock
{
    NSMutableDictionary *dic=[[NSMutableDictionary alloc] init];
    [dic setObject:client_id forKey:@"client_id"];
    [dic setObject:client_secret forKey:@"client_secret"];
    [dic setObject:[CommData shareInstance].userModel.loginkey forKey:@"loginkey"];
    [dic setObject:[CommData shareInstance].userModel.token forKey:@"token"];
    
    NSString *url=[NSString stringWithFormat:@"%@%@",pupBaseUrl,@"iup-asserver/user_info_login?"];
    NSMutableURLRequest *request=[[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:url parameters:dic error:nil];
    [request setTimeoutInterval:timeout];
    
    

    NSURLSessionDataTask *dataTask = [_manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"Error: %@", error);
            errorBlock(error);
        } else {
            NSLog(@"%@ %@", response, responseObject);
            
            
            NSError *error;
            id jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
            NSDictionary *dataDict = jsonObject;
            [CommData shareInstance].userModel.birthday = checkNull(dataDict[@"birthday"]);
            [CommData shareInstance].userModel.gender = checkNull(dataDict[@"gender"]);
            [CommData shareInstance].userModel.career = checkNull(dataDict[@"career"]);
            [CommData shareInstance].userModel.headpicpath = checkNull(dataDict[@"headpicpath"]);
            //            [CommData shareInstance].userModel.headpicpath =[NSString stringWithFormat:@"%@%@",pupBaseUrl,checkNull(dataDict[@"headpicpath"])] ;
            [CommData shareInstance].userModel.nickname = checkNull(dataDict[@"nickname"]);
            [CommData shareInstance].userModel.phone = checkNull(dataDict[@"phone"]);
            [CommData shareInstance].userModel.emailbox = checkNull(dataDict[@"emailbox"]);
            
            [[CommData shareInstance] saveUserMessageWithModel:[CommData shareInstance].userModel];

            NSLog(@"%@",jsonObject);
            completeBlock(jsonObject);
        }
    }];
    [dataTask resume];
}
//获取大数据列表
-(void)getBigDataListWithTagName:(NSString *)tagName isFirst:(BOOL)isFirst WithComplete:(NewsCompleteBlock)completeBlock withErrorBlock:(NewsErrorBlock)errorBlock
{
    NSDictionary *params = @{@"appkey":[NewsAgent getAppKey],
                             @"adspot":tagName,
                             @"t":[self getTimesTamp],
                             @"uuid":[MAgent getUUID],
                             @"from":@"m",
                             @"max_count":@"10",
                             @"duplicat_flag":@"0",
                             @"format":@"simple",
                             @"max_behot_time":isFirst?@"-1":@"0",
                             @"show_model":[NSNumber numberWithInteger:1]
                             };
    [self setRequestGetWithJsonData:params requestUrl:BIGDATA_URL WithComplete:completeBlock error:errorBlock];
}

-(void)getBigDataListWithTagName:(NSString *)tagName recTime:(NSNumber*)recTime WithComplete:(NewsCompleteBlock)completeBlock withErrorBlock:(NewsErrorBlock)errorBlock
{
    if (recTime == nil) {
        recTime = @(0);
    }
    NSDictionary *params = @{@"appkey":[NewsAgent getAppKey],
                             @"adspot":tagName,
                             @"t":[self getTimesTamp],
                             @"uuid":[MAgent getUUID],
                             @"from":@"m",
                             @"max_count":@"10",
                             @"format":@"simple",
                             @"duplicat_flag":@"0",
                             @"max_behot_time":recTime,
                             @"show_model":[NSNumber numberWithInteger:1]
                             };
    [self setRequestGetWithJsonData:params requestUrl:BIGDATA_URL WithComplete:completeBlock error:errorBlock];
}

- (NSString*)getTimesTamp
{
    NSTimeInterval interVal = [[NSDate date] timeIntervalSince1970]*1000;
    return [NSString stringWithFormat:@"%ld",(long)interVal];
    
}
- (void)downLoadFileWithUrl:(NSString*)fileUrl withComplete:(NewsCompleteBlock)completeBlock withErrorBlock:(NewsErrorBlock)errorBlock
{
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDownloadTask *downLoadTask = [session downloadTaskWithURL:[NSURL URLWithString:fileUrl] completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
      NSString *downloadFileDirectory =  [[PDMISandboxFile getDocumentPath] stringByAppendingPathComponent:@"downloadFile"];
        if (![[NSFileManager defaultManager] fileExistsAtPath:downloadFileDirectory]) {
            [[NSFileManager defaultManager] createDirectoryAtPath:downloadFileDirectory withIntermediateDirectories:YES attributes:nil error:nil];
        }
       NSString * downloadFile = [downloadFileDirectory stringByAppendingPathComponent:[fileUrl md5HexDigest]];
        downloadFile = [downloadFile stringByAppendingPathExtension:response.suggestedFilename.pathExtension];

        [[NSFileManager defaultManager] moveItemAtPath:location.path toPath:downloadFile error:nil];
            if (error) {
                errorBlock(error);
            } else {
                completeBlock(nil);
            }
        }

    }];
    [downLoadTask resume];
}

# pragma mark - 获取首页列表
-(void)getMainListWithLink:(NSString *)link WithComplete:(NewsCompleteBlock)completeBlock withErrorBlock:(NewsErrorBlock)errorBlock;
{
    [self setRequestGetWithJsonData:nil requestUrl:link WithComplete:completeBlock error:errorBlock];
}

#pragma mark - 获取工作室详情列表
-(void)getArticleContentWithLink:(NSString *)link WithComplete:(NewsCompleteBlock)completeBlock withErrorBlock:(NewsErrorBlock)errorBlock;
{
    [self setRequestGetWithJsonData:nil requestUrl:link WithComplete:completeBlock error:errorBlock];
}


#pragma mark - post请求
-(void)setRequestPostWithJsonData:(NSDictionary *)jsondic method:(NSString *)requestMethod WithComplete:(NewsCompleteBlock)completeBlock  error:(NewsErrorBlock)errorBlock{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    NSString *url=requestMethod;
    
    NSMutableURLRequest *request=[[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:url parameters:jsondic error:nil];
    [request setTimeoutInterval:timeout];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];

    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        
        if (error) {
            NSLog(@"Error: %@", error);
            errorBlock(error);
        } else {
            NSError *error;
            id jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
            
            NSLog(@"%@",jsonObject);
            NSLog(@"%@",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
            completeBlock(jsonObject);
        }
        
    }];
    [dataTask resume];
}

#pragma mark -get 请求

-(void)setRequestGetWithJsonData:(NSDictionary *)jsondic requestUrl:(NSString *)requestUrl WithComplete:(NewsCompleteBlock)completeBlock  error:(NewsErrorBlock)errorBlock{
    
    NSMutableURLRequest *request=[[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:requestUrl parameters:jsondic error:nil];
    
    NSLog(@"\nRequest code  : %@?%@",requestUrl,[jsondic URLParam]);

    [request setTimeoutInterval:timeout];
    
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    
    NSURLSessionDataTask *dataTask = [_manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"Error: %@", error);
            errorBlock(error);
        } else {
            NSLog(@"%@ %@", response, responseObject);
            NSError *error;
            id jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
            NSLog(@"%@",jsonObject);
            completeBlock(jsonObject);
            
        }
    }];
    [dataTask resume];
    
    
}
#pragma mark -
#pragma mark - 获取配置文件
//获取配置文件
-(void)getConfigureWithComplete:(NewsCompleteBlock)completeBlock withErrorBlock:(NewsErrorBlock)errorBlock
{

    NSMutableURLRequest *request=[[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:configUrl parameters:nil error:nil];
    [request setTimeoutInterval:timeout];
    
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    
    NSURLSessionDataTask *dataTask = [_manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"Error: %@", error);
            errorBlock(error);
        } else {
            NSLog(@"%@ %@", response, responseObject);
            NSError *error;
            id jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
            NSLog(@"%@",jsonObject);
            if ([jsonObject isKindOfClass:[NSDictionary class]]) {
                [self resetModelWithDic:jsonObject andComplete:completeBlock];
            }
        }
    }];
    [dataTask resume];
}
-(void)resetModelWithDic:(NSDictionary *)modelDic andComplete:(NewsCompleteBlock)completeBlock
{
    NSMutableArray *itemArray = [NSMutableArray array];
    for (NSDictionary* dic in modelDic[@"list"]) {
        PDMITagItem * rItemModel = [[PDMITagItem alloc]initWithDict:dic];
        [itemArray addObject:rItemModel];
    }    
    [[CommData shareInstance]saveHotspotData:itemArray];
    completeBlock(nil);
}



-(BOOL)getHotConfigureWithComplete:(NewsCompleteBlock)completeBlock withErrorBlock:(NewsErrorBlock)errorBlock
{
   
    NSData *data=[[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:@"http://43.250.238.158/zgsjbcs/json"]];
    
    if ([data writeToFile:[[CommData shareInstance] getConfigureJsonPath] atomically:YES]==YES) {
        NSLog(@"初始化成功");
        return YES;
    }else{
        NSLog(@"初始化失败");
        
        return NO;
    }
    
    
}


#pragma mark - urlEncode
-(NSString*)encodeUrl:(NSString*)str{
    
    
    NSMutableCharacterSet * allowedCharacterSet = [[NSCharacterSet URLQueryAllowedCharacterSet] mutableCopy];
    [allowedCharacterSet removeCharactersInString:@":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"];
    NSString *encodedValue                      = [str stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacterSet];
    
    return encodedValue;
    
}
- (AFHTTPRequestOperation *)requestWithParm:(NSMutableDictionary *)requestParam
                                    success:(void (^)(AFHTTPRequestOperation *operation, id result))success
                                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    
    AFHTTPRequestOperation *operation =  [self buildRequestOperation:requestParam];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         
         if (success) { success(operation,responseObject);}
         
     }failure:^(AFHTTPRequestOperation *operation, NSError *error){
         
         NSLog(@"\nRequest failure : \n%@\n",error);
         NSLog(@"%@",error);
         if (error.domain == NSURLErrorDomain && error.code == -999)
         {
             NSLog(@"The request cancel. \n %@",error);
         }
         
         if (error.domain == NSURLErrorDomain && error.code == -1001)
         {
             NSLog(@"The request timed out.\n %@",error);
         }
         if (failure) { failure(operation,error);}
     }];
    
    [self.operationQueue addOperation:operation];
    return operation;
}


- (AFHTTPRequestOperation *)buildRequestOperation:(NSMutableDictionary*)myDic
{
    NSString *boundary = @"mj";
    NSString *beginTag = [NSString stringWithFormat:@"--%@\r\n", boundary];
    NSString *endTag = [NSString stringWithFormat:@"--%@--", boundary];
    NSString *parth = @"iup-asserver/user_info_update";
    NSString *url = [NSString stringWithFormat:@"%@%@",pupBaseUrl,parth];//sofaService
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                       timeoutInterval:25];
    // 拼接请求体
    NSMutableData *data = [NSMutableData data];
    NSMutableDictionary *dic = myDic;
    
    for (NSString *key in dic)
    {
        id value = [dic objectForKey:key];
        if ([value isKindOfClass:NSString.class])
        {
            // 普通参数-username
            // 普通参数开始的一个标记
            [data appendData:[beginTag dataUsingEncoding:NSUTF8StringEncoding]];
            
            
            // 参数描述
            NSString *disposition =[NSString stringWithFormat:@"Content-Disposition:form-data; name=\"%@\"\r\n", key];
            [data appendData:[disposition dataUsingEncoding:NSUTF8StringEncoding]];
            
            // 参数值
            NSString *valueString = [NSString stringWithFormat:@"\r\n%@\r\n", value];
            [data appendData:[valueString dataUsingEncoding:NSUTF8StringEncoding]];
        }
        else if([value isKindOfClass:NSData.class])
        {
            // 文件参数-file
            // 文件参数开始的一个标记
            [data appendData:[beginTag dataUsingEncoding:NSUTF8StringEncoding]];
            // 文件参数描述
            NSString *disposition = [NSString stringWithFormat:@"Content-Disposition:form-data; name=\"%@\"; filename=\"%@.png\"\r\n", key,key];
            [data appendData:[disposition dataUsingEncoding:NSUTF8StringEncoding]];
            
            // 文件的MINETYPE
            [data appendData:[@"Content-Type:image/png\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            
            // 文件内容
            [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            
            [data appendData:value];
            [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        }
        else if ([value isKindOfClass:[NSMutableArray class]])
        {
            int i = 0;
            for (NSData *imagesData in value)
            {
                // 文件参数-file
                // 文件参数开始的一个标记
                [data appendData:[beginTag dataUsingEncoding:NSUTF8StringEncoding]];
                // 文件参数描述
                NSString *disposition = [NSString stringWithFormat:@"Content-Disposition:form-data; name=\"%@\"; filename=\"%@.png\"\r\n",[NSString stringWithFormat:@"%@",key] ,[NSString stringWithFormat:@"key%d",i]];
                [data appendData:[disposition dataUsingEncoding:NSUTF8StringEncoding]];
                
                // 文件的MINETYPE
                [data appendData:[@"Content-Type:image/png\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                
                // 文件内容
                [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                
                [data appendData:imagesData];
                [data appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
                
                i ++;
            }
        }
    }
    // 参数结束的标识
    [data appendData:[endTag dataUsingEncoding:NSUTF8StringEncoding]];
    
    //设置HTTPHeader中Content-Type的值
    NSString *content=[[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@",boundary];
    //设置HTTPHeader
    [request setValue:content forHTTPHeaderField:@"Content-Type"];
    //设置Content-Length
    [request setValue:[NSString stringWithFormat:@"%@", @([data length])] forHTTPHeaderField:@"Content-Length"];
    //http method
    [request setHTTPMethod:@"POST"];
    
    //设置http body
    [request setHTTPBody:data];
    AFHTTPRequestOperation * operation;
    operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    return operation;
}







#pragma mark 获取评论列表
-(void)getArticleCommentWithDic:(NSDictionary *)dic WithComplete:(NewsCompleteBlock)completeBlock withErrorBlock:(NewsErrorBlock)errorBlock;
{
    
    
    NSString *url=[NSString stringWithFormat:@"%@%@",pupPinglunUrl,@"api/commentapi/commentList.html?"];
    NSMutableURLRequest *request=[[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:url parameters:dic error:nil];
    [request setTimeoutInterval:timeout];
    
    
    
    NSURLSessionDataTask *dataTask = [_manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"Error: %@", error);
            errorBlock(error);
        } else {
            NSLog(@"%@ %@", response, responseObject);
            
            
            NSError *error;
            id jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
            NSLog(@"%@",jsonObject);
            completeBlock(jsonObject);
            
        }
        
        
    }];
    [dataTask resume];
    
}
#pragma mark 发布评论
-(void)releaseArticleCommentWithDic:(NSDictionary *)dic WithComplete:(NewsCompleteBlock)completeBlock withErrorBlock:(NewsErrorBlock)errorBlock;
{
    
    
    NSString *url=[NSString stringWithFormat:@"%@%@",pupPinglunUrl,@"api/commentapi/commentSend.html?"];
    NSMutableURLRequest *request=[[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:url parameters:dic error:nil];
    [request setTimeoutInterval:timeout];
    
    NSLog(@"\nRequest code  : %@%@",url,[dic URLParam]);

    
    NSURLSessionDataTask *dataTask = [_manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"Error: %@", error);
            errorBlock(error);
        } else {
            NSLog(@"%@ %@", response, responseObject);
            
            
            NSError *error;
            id jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
            NSLog(@"%@",jsonObject);
            completeBlock(jsonObject);
            
        }
        
        
    }];
    [dataTask resume];
    
}



#pragma mark -截取字符串get 请求

-(void)setRequestGetWithJsonDataIntercept:(NSDictionary *)jsondic requestUrl:(NSString *)requestUrl WithComplete:(NewsCompleteBlock)completeBlock  error:(NewsErrorBlock)errorBlock{
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    configuration.TLSMaximumSupportedProtocol = kTLSProtocol1;
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    
    NSMutableURLRequest *request=[[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:requestUrl parameters:jsondic error:nil];
    
    [request setTimeoutInterval:timeout];
    
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (error) {
            NSLog(@"Error: %@", error);
            errorBlock(error);
        } else {
            NSLog(@"%@ %@", response, responseObject);
            
            
            NSError *error;
            NSString *str=[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            if (str.length>2) {
                
                str = [str substringFromIndex:1];
                str = [str substringToIndex:str.length-2];
                
                
            }
            
            id jsonObject=[str JSONObject];
            
//            id jsonObject = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:&error];
            NSLog(@"%@",jsonObject);
            completeBlock(jsonObject);
            
        }
    }];
    [dataTask resume];
    
    
}


@end

