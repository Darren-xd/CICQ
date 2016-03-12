//
//	CICQCategory.m
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "CICQCategory.h"

NSString *const kCICQCategoryCategoryName = @"categoryName";
NSString *const kCICQCategoryIdField = @"id";

@interface CICQCategory ()
@end
@implementation CICQCategory




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

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


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
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

/**
 * Implementation of NSCoding encoding method
 */
/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
	if(self.categoryName != nil){
		[aCoder encodeObject:self.categoryName forKey:kCICQCategoryCategoryName];
	}
	if(self.idField != nil){
		[aCoder encodeObject:self.idField forKey:kCICQCategoryIdField];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.categoryName = [aDecoder decodeObjectForKey:kCICQCategoryCategoryName];
	self.idField = [aDecoder decodeObjectForKey:kCICQCategoryIdField];
	return self;

}


/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	CICQCategory *copy = [CICQCategory new];

	copy.categoryName = [self.categoryName copyWithZone:zone];
	copy.idField = [self.idField copyWithZone:zone];

	return copy;
}
@end