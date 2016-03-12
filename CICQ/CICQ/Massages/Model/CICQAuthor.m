//
//	CICQAuthor.m
//	Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "CICQAuthor.h"

NSString *const kCICQAuthorAvatar = @"avatar";
NSString *const kCICQAuthorFollowStatus = @"followStatus";
NSString *const kCICQAuthorIdField = @"id";
NSString *const kCICQAuthorIntro = @"intro";
NSString *const kCICQAuthorNickname = @"nickname";
NSString *const kCICQAuthorSubscriptionNum = @"subscriptionNum";

@interface CICQAuthor ()
@end
@implementation CICQAuthor




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kCICQAuthorAvatar] isKindOfClass:[NSNull class]]){
		self.avatar = dictionary[kCICQAuthorAvatar];
	}	
	if(![dictionary[kCICQAuthorFollowStatus] isKindOfClass:[NSNull class]]){
		self.followStatus = [dictionary[kCICQAuthorFollowStatus] boolValue];
	}

	if(![dictionary[kCICQAuthorIdField] isKindOfClass:[NSNull class]]){
		self.idField = dictionary[kCICQAuthorIdField];
	}	
	if(![dictionary[kCICQAuthorIntro] isKindOfClass:[NSNull class]]){
		self.intro = dictionary[kCICQAuthorIntro];
	}	
	if(![dictionary[kCICQAuthorNickname] isKindOfClass:[NSNull class]]){
		self.nickname = dictionary[kCICQAuthorNickname];
	}	
	if(![dictionary[kCICQAuthorSubscriptionNum] isKindOfClass:[NSNull class]]){
		self.subscriptionNum = dictionary[kCICQAuthorSubscriptionNum];
	}	
	return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
	NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
	if(self.avatar != nil){
		dictionary[kCICQAuthorAvatar] = self.avatar;
	}
	dictionary[kCICQAuthorFollowStatus] = @(self.followStatus);
	if(self.idField != nil){
		dictionary[kCICQAuthorIdField] = self.idField;
	}
	if(self.intro != nil){
		dictionary[kCICQAuthorIntro] = self.intro;
	}
	if(self.nickname != nil){
		dictionary[kCICQAuthorNickname] = self.nickname;
	}
	if(self.subscriptionNum != nil){
		dictionary[kCICQAuthorSubscriptionNum] = self.subscriptionNum;
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
	if(self.avatar != nil){
		[aCoder encodeObject:self.avatar forKey:kCICQAuthorAvatar];
	}
	[aCoder encodeObject:@(self.followStatus) forKey:kCICQAuthorFollowStatus];	if(self.idField != nil){
		[aCoder encodeObject:self.idField forKey:kCICQAuthorIdField];
	}
	if(self.intro != nil){
		[aCoder encodeObject:self.intro forKey:kCICQAuthorIntro];
	}
	if(self.nickname != nil){
		[aCoder encodeObject:self.nickname forKey:kCICQAuthorNickname];
	}
	if(self.subscriptionNum != nil){
		[aCoder encodeObject:self.subscriptionNum forKey:kCICQAuthorSubscriptionNum];
	}

}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	self.avatar = [aDecoder decodeObjectForKey:kCICQAuthorAvatar];
	self.followStatus = [[aDecoder decodeObjectForKey:kCICQAuthorFollowStatus] boolValue];
	self.idField = [aDecoder decodeObjectForKey:kCICQAuthorIdField];
	self.intro = [aDecoder decodeObjectForKey:kCICQAuthorIntro];
	self.nickname = [aDecoder decodeObjectForKey:kCICQAuthorNickname];
	self.subscriptionNum = [aDecoder decodeObjectForKey:kCICQAuthorSubscriptionNum];
	return self;

}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
	CICQAuthor *copy = [CICQAuthor new];

	copy.avatar = [self.avatar copyWithZone:zone];
	copy.followStatus = self.followStatus;
	copy.idField = [self.idField copyWithZone:zone];
	copy.intro = [self.intro copyWithZone:zone];
	copy.nickname = [self.nickname copyWithZone:zone];
	copy.subscriptionNum = [self.subscriptionNum copyWithZone:zone];

	return copy;
}
@end