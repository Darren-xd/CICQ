//
//  CICQHTTPRequest.h
//  CICQ
//
//  Created by Darren on 16/3/11.
//  Copyright © 2016年 darren. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^function)(id obj);

@interface CICQHTTPRequest : NSObject

//获取好友列表
-(id)initGetUserFriends;

//发送请求
-(void)sendWithRequestSucess:(function)sucess andFailed:(function)failed;

@end