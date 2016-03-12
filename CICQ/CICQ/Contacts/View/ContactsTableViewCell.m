//
//  ContactsTableViewCell.m
//  CICQ
//
//  Created by Darren on 16/3/12.
//  Copyright © 2016年 darren. All rights reserved.
//

#import "ContactsTableViewCell.h"
#import "CICQUserGroupModel.h"
#import "UIImageView+WebCache.h"


@implementation ContactsTableViewCell

- (void)awakeFromNib {
    // Initialization code
    _haedImage.layer.cornerRadius = 25;
    _haedImage.layer.masksToBounds= YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)setData:(CICQAuthor *)author
{
    [_haedImage sd_setImageWithURL:[NSURL URLWithString:author.avatar] placeholderImage:[UIImage imageNamed:@"defaultHead"]];
    _contextLable.text = author.intro;
    _userNameLabel.text = author.nickname;
}

@end
