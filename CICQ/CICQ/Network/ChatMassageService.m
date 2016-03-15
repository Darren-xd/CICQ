//
//  ChatMassageService.m
//  CICQ
//
//  Created by Darren on 16/3/10.
//  Copyright © 2016年 darren. All rights reserved.
//

#import "ChatMassageService.h"
#import "CICQHTTPRequest.h"

@implementation ChatMassageService

+(id)getUserFriends:(function)sucess failed:(function)failed
{
    CICQHTTPRequest *request = [[CICQHTTPRequest alloc]initGetUserFriends];
    [request sendWithRequestSucess:^(id obj){
        if (sucess) {
            sucess(obj);
        }
    }andFailed:^(id obj){
        failed(obj);
    }];
    return nil;
}




@end