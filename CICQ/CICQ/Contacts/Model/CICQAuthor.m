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


-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	if(![dictionary[kCICQAuthorAvatar] isKindOfClass:[NSNull class]]){
		self.avatar = dictionary[kCICQAuthorAvatar];
	}	
	if(![dictionary[kCICQAuthorFollowStatus] isKindOfClass:[NSNull class]]){
        float f = (arc4random() % 5);
        self.followStatus = (f < 2) ? YES:NO;
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
    if (self.followStatus) {
        if ((arc4random() % 3)>1) {
            self.network = [NSString stringWithFormat:@"3G"];
        }else{
            self.network = [NSString stringWithFormat:@"Wi-Fi"];
        }
    }
    
	return self;
}

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