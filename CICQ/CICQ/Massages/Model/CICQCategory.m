//
//	CICQCategory.m
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "CICQCategory.h"

NSString *const kCICQCategoryCategoryName = @"categoryName";
NSString *const kCICQCategoryIdField = @"id";

@interface CICQCategory ()
@end
@implementation CICQCategory



-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kCICQCategoryCategoryName] isKindOfClass:[NSNull class]]){
		self.categoryName = dictionary[kCICQCategoryCategoryName];
	}	
	if(![dictionary[kCICQCategoryIdField] isKindOfClass:[NSNull class]]){
		self.idField = dictionary[kCICQCategoryIdField];
	}	
	return self;
}


-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.categoryName != nil){
		dictionary[kCICQCategoryCategoryName] = self.categoryName;
	}
	if(self.idField != nil){
		dictionary[kCICQCategoryIdField] = self.idField;
	}
	return dictionary;

}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
	if(self.categoryName != nil){
		[aCoder encodeObject:self.categoryName forKey:kCICQCategoryCategoryName];
	}
	if(self.idField != nil){
		[aCoder encodeObject:self.idField forKey:kCICQCategoryIdField];
	}

}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.categoryName = [aDecoder decodeObjectForKey:kCICQCategoryCategoryName];
	self.idField = [aDecoder decodeObjectForKey:kCICQCategoryIdField];
	return self;

}


- (instancetype)copyWithZone:(NSZone *)zone
{
	CICQCategory *copy = [CICQCategory new];

	copy.categoryName = [self.categoryName copyWithZone:zone];
	copy.idField = [self.idField copyWithZone:zone];

	return copy;
}
@end