//
//  FirstStartApp.h
//  CICQ
//
//  Created by Darren on 16/3/15.
//  Copyright © 2016年 darren. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FirstStartApp : NSObject

//是否第一次启动
+(BOOL)isFirst;
//初始化数据库
+(BOOL)initAPPDataBase;
//APP 启动初始化
+(BOOL)init;

@end
