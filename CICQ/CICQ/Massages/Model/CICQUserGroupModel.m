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




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

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
		self.authors = authorsItems;
	}
	if(![dictionary[kCICQUserModelCategory] isKindOfClass:[NSNull class]]){
		self.category = [[CICQCategory alloc] initWithDictionary:dictionary[kCICQUserModelCategory]];
	}

	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
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

/**
 * Implementation of NSCoding encoding method
 */
/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
	if(self.authors != nil){
		[aCoder encodeObject:self.authors forKey:kCICQUserModelAuthors];
	}
	if(self.category != nil){
		[aCoder encodeObject:self.category forKey:kCICQUserModelCategory];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.authors = [aDecoder decodeObjectForKey:kCICQUserModelAuthors];
	self.category = [aDecoder decodeObjectForKey:kCICQUserModelCategory];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
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