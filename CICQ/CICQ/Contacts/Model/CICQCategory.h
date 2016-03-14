#import <UIKit/UIKit.h>

@interface CICQCategory : NSObject

@property (nonatomic, strong) NSString * categoryName;
@property (nonatomic, strong) NSString * idField;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

- (instancetype)copyWithZone:(NSZone *)zone;

-(NSDictionary *)toDictionary;
@end