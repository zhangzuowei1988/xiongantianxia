/*
 Licensed to the Apache Software Foundation (ASF) under one
 or more contributor license agreements.  See the NOTICE file
 distributed with this work for additional information
 regarding copyright ownership.  The ASF licenses this file
 to you under the Apache License, Version 2.0 (the
 "License"); you may not use this file except in compliance
 with the License.  You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing,
 software distributed under the License is distributed on an
 "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 KIND, either express or implied.  See the License for the
 specific language governing permissions and limitations
 under the License.
 */

#import <Foundation/Foundation.h>


@interface NSArray (PDMIJSONSerializing)


/*!
 *	@brief	将数组转化为json字符串
 *
 *	@return	转化后的json字符串
 */
- (NSString*)JSONString;
@end

@interface NSDictionary (PDMIJSONSerializing)
/*!
 *	@brief	将字典转化为json字符串
 *
 *	@return	转化后的json字符串
 */
- (NSString*)JSONString;
@end

@interface NSString (PDMIJSONSerializing)
/*!
 *	@brief	将json字符串转话为对象
 *
 *	@return	转化后的对象
 */
- (id)JSONObject;

@end
