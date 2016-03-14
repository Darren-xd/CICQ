//
//  DBHelp.h
//  DropdownAnimation
//
//  Created by Darren on 16/3/13.
//  Copyright © 2016年 darren. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

static FMDatabase *dataBase = nil;

@interface DBHelp : NSObject



+(BOOL)openDataBase:(NSString*)path;

+(BOOL)createTableHelp:(NSString*)sql;

+(BOOL)insertDataBase:(NSString*)sql;

+(FMResultSet*)selectDataBase:(NSString *)sql;

+(BOOL)closeDataBase;

@end
