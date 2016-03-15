//
//  FirstStartApp.m
//  CICQ
//
//  Created by Darren on 16/3/15.
//  Copyright © 2016年 darren. All rights reserved.
//

#import "FirstStartApp.h"
#import "DBHelp.h"

#define userKey @"First";

@implementation FirstStartApp

#pragma mark 初始化APP
+(BOOL)init
{
    [DBHelp openDataBase];
    //检查是否是第一次启动APP
    BOOL bo = [self isFirst];
    if (bo) {
        //初始化DB
        return [self initAPPDataBase];
    }
    return !bo;
}


#pragma mark 是否第一次启动APP
+(BOOL)isFirst
{
    NSString *cicq = [[NSUserDefaults standardUserDefaults]objectForKey:@"firstStart"];
    NSLog(@"APP 状态 %@",cicq);
    if (cicq == nil || [cicq isEqualToString:@""]) {
        [[NSUserDefaults standardUserDefaults]setObject:@"CICQ" forKey:@"firstStart"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        return YES;
    }
    return NO;
}

#pragma mark 初始化数据库
+(BOOL)initAPPDataBase
{
    NSString *sqlStr = @"CREATE TABLE massageList (user_Id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL , user_Name TEXT NOT NULL , content TEXT ,time TEXT NOT NULL , head TEXT NOT NULL , msg_count INTEGER NOT NULL , type INTEGER NOT NULL)";
    BOOL bo = [DBHelp createTableHelp:sqlStr];
    if (bo) {
        [[NSUserDefaults standardUserDefaults]setDouble:YES forKey:@"first"];
        return YES;
    }
    return NO;
}

@end
