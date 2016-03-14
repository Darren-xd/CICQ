#import <UIKit/UIKit.h>
#import "CICQAuthor.h"
#import "CICQCategory.h"

@interface CICQUserGroupModel : NSObject

@property (nonatomic, strong) NSArray * authors;
@property (nonatomic, strong) CICQCategory * category;
@property (nonatomic, assign) BOOL status;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;
-(NSInteger)getOnlineCount;

-(NSDictionary *)toDictionary;
@end