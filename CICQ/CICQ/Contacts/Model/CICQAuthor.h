#import <UIKit/UIKit.h>

@interface CICQAuthor : NSObject

@property (nonatomic, strong) NSString * avatar;
@property (nonatomic, assign) BOOL followStatus;
@property (nonatomic, strong) NSString * idField;
@property (nonatomic, strong) NSString * intro;
@property (nonatomic, strong) NSString * nickname;
@property (nonatomic, strong) NSString * subscriptionNum;
@property (nonatomic, strong) NSString * network;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end