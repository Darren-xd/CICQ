//
//  DBHelp.m
//  DropdownAnimation
//
//  Created by Darren on 16/3/13.
//  Copyright © 2016年 darren. All rights reserved.
//

#import "DBHelp.h"
#import "FMDatabase.h"
#import "NewMassageModel.h"


static BOOL isOpen = NO;

@implementation DBHelp

#pragma mark 创建数据库表
+(BOOL)createTableHelp:(NSString*)sql
{
    if (!dataBase || !isOpen) {
        NSLog(@"DB is not open");
        return NO;
    }
    BOOL s = [dataBase executeUpdateWithFormat:sql,nil];
    if (!s) {
        NSLog(@"crate error %@", sql);
        return NO;
    }
    return YES;
}


+(BOOL)openDataBase
{
    NSString *dbPath = [DBHelp documentPath];
    dataBase = [[FMDatabase alloc]initWithPath:dbPath];
    isOpen = [dataBase open];
    return isOpen;
}


+(BOOL)insertDataBase:(NSString*)sql
{
    if (dataBase == nil || !isOpen) {
        NSLog(@"DB is not open");
        return NO;
    }
    BOOL s = [dataBase executeUpdateWithFormat:sql,nil];
    return s;
}

+(FMResultSet*)selectDataBase:(NSString *)sql
{
    if (!dataBase || !isOpen) {
        NSLog(@"DB is not open");
        return nil;
    }
    FMResultSet *result = [dataBase executeQuery:sql];
    return result;
}

#pragma mark 插入聊天数据
+(BOOL)addNewMassageModel:(NewMassageModel *)model
{
    NSString *insertSql = [NSString stringWithFormat:@"insert into massageList (user_Name,content,time,head,msg_count,type) values ('%@','%@','%@','%@',%d,%d)",model.userName,model.content,model.time,model.head,model.msgCount,model.type];
    return [self insertDataBase:insertSql];
}


+(BOOL)closeDataBase
{
    if (dataBase && isOpen) {
        return [dataBase close];
    }
    return NO;
}


+(NSString *)documentPath
{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSFileManager *manager = [NSFileManager defaultManager];
    BOOL tag = [manager fileExistsAtPath:path isDirectory:NULL];
    if (!tag) {
        [manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:NULL];
    }
    NSString *dbPath = [path stringByAppendingPathComponent:@"userData.db"];
    return dbPath;
}


@end
