//
//  NewMassageModel.h
//  CICQ
//
//  Created by Darren on 16/3/10.
//  Copyright © 2016年 darren. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewMassageModel : NSObject

@property(nonatomic,assign)int userId;
@property(nonatomic,copy)NSString *userName;
@property(nonatomic,copy)NSString *content;
@property(nonatomic,copy)NSString *time;
@property(nonatomic,copy)NSString *head;
@property(nonatomic,assign)int msgCount;

@end
