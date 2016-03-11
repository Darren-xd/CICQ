//
//  ChatMassageService.h
//  CICQ
//
//  Created by Darren on 16/3/10.
//  Copyright © 2016年 darren. All rights reserved.
//

#import "BaseService.h"

typedef void (^function)(id obj);

@interface ChatMassageService : BaseService

+(id)getUserFriends:(function)sucess failed:(function)failed;

@end
