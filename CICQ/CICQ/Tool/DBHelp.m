//
//  DBHelp.m
//  DropdownAnimation
//
//  Created by Darren on 16/3/13.
//  Copyright © 2016年 darren. All rights reserved.
//

#import "DBHelp.h"
#import "FMDatabase.h"


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


+(BOOL)openDataBase:(NSString*)path
{
    dataBase = [[FMDatabase alloc]initWithPath:path];
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


+(BOOL)closeDataBase
{
    if (dataBase && isOpen) {
        return [dataBase close];
    }
    return NO;
}




@end
