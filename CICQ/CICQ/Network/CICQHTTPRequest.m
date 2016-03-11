//
//  CICQHTTPRequest.m
//  CICQ
//
//  Created by Darren on 16/3/11.
//  Copyright © 2016年 darren. All rights reserved.
//

#import "CICQHTTPRequest.h"
#import "AFHTTPRequestOperation.h"

#define DATA_URL @"http://7rf426.com2.z0.glb.qiniucdn.com/news.json"

@interface CICQHTTPRequest()
{
    NSString* _httpRequest;
}

@end


@implementation CICQHTTPRequest

#pragma mark 获取好友列表
-(id)initGetUserFriends
{
    if (self = [super init]) {
        _httpRequest = [NSString stringWithFormat:DATA_URL];
    }
    return self;
}

#pragma mark 发送请求
-(void)sendWithRequestSucess:(function)sucess andFailed:(function)failed
{
    NSURL *url = [NSURL URLWithString:_httpRequest];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    op.responseSerializer = [AFJSONResponseSerializer serializer];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation* requestOperation,id requestObject){
        if (sucess) {
            sucess(requestObject);
        }
    }failure:^(AFHTTPRequestOperation *operation, NSError *error){
        if (failed) {
            failed(error);
        }
    }];
    [[NSOperationQueue mainQueue] addOperation:op];
}


@end
