//
//	CICQUserModel.m
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "CICQUserGroupModel.h"
#import "CICQCategory.h"

NSString *const kCICQUserModelAuthors = @"authors";
NSString *const kCICQUserModelCategory = @"category";

@interface CICQUserGroupModel ()
@end
@implementation CICQUserGroupModel


-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(dictionary[kCICQUserModelAuthors] != nil && [dictionary[kCICQUserModelAuthors] isKindOfClass:[NSArray class]]){
		NSArray * authorsDictionaries = dictionary[kCICQUserModelAuthors];
		NSMutableArray * authorsItems = [NSMutableArray array];
		for(NSDictionary * authorsDictionary in authorsDictionaries){
			CICQAuthor * authorsItem = [[CICQAuthor alloc] initWithDictionary:authorsDictionary];
			[authorsItems addObject:authorsItem];
		}
        
        //            (void)bubbleSort:(NSMutableArray *)array{
        //                int i, y; BOOL bFinish = YES;
        //                for (i = 1; i<= [array count] && bFinish; i++) {
        //                    bFinish = NO;
        //                    for (y = (int)[array count]-1; y>=i; y--) {
        //                        if ([[array objectAtIndex:y] intValue] < [[array objectAtIndex:y-1] intValue]) {
        //                            [array exchangeObjectAtIndex:y-1 withObjectAtIndex:y];
        //                            bFinish = YES;
        //                        }
        //                    }
        //                }
        //            }
        
        [self sort:authorsItems];
        
		self.authors = authorsItems;
	}
	if(![dictionary[kCICQUserModelCategory] isKindOfClass:[NSNull class]]){
		self.category = [[CICQCategory alloc] initWithDictionary:dictionary[kCICQUserModelCategory]];
	}

	return self;
}
#pragma mark 冒泡排序
-(void)sort:(NSMutableArray *)array
{
    int i;
    int y;
    BOOL bFinish = YES;
    CICQAuthor *a;
    CICQAuthor *b;
    for (i = 1; i<= [array count] && bFinish; i++) {
        bFinish = NO;
        for (y = (int)[array count]-1; y>=i; y--) {
            a = array[y];
            b = array[y-1];
            if (a.followStatus > b.followStatus) {
                [array exchangeObjectAtIndex:y-1 withObjectAtIndex:y];
                bFinish = YES;
            }
        }
    }
    
}


-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.authors != nil){
		NSMutableArray * dictionaryElements = [NSMutableArray array];
		for(CICQAuthor * authorsElement in self.authors){
			[dictionaryElements addObject:[authorsElement toDictionary]];
		}
		dictionary[kCICQUserModelAuthors] = dictionaryElements;
	}
	if(self.category != nil){
		dictionary[kCICQUserModelCategory] = [self.category toDictionary];
	}
	return dictionary;

}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
	if(self.authors != nil){
		[aCoder encodeObject:self.authors forKey:kCICQUserModelAuthors];
	}
	if(self.category != nil){
		[aCoder encodeObject:self.category forKey:kCICQUserModelCategory];
	}

}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.authors = [aDecoder decodeObjectForKey:kCICQUserModelAuthors];
	self.category = [aDecoder decodeObjectForKey:kCICQUserModelCategory];
	return self;

}

- (instancetype)copyWithZone:(NSZone *)zone
{
	CICQUserGroupModel *copy = [CICQUserGroupModel new];

	copy.authors = [self.authors copyWithZone:zone];
	copy.category = [self.category copyWithZone:zone];

	return copy;
}

/**
 * 在线人数
 */
-(NSInteger)getOnlineCount
{
    int count = 0;
    for (CICQAuthor *author in self.authors) {
        if (author.followStatus) {
            count ++;
        }
    }
    return count;
}



@end