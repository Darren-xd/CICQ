//
//  ContactsTableViewCell.h
//  CICQ
//
//  Created by Darren on 16/3/12.
//  Copyright © 2016年 darren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CICQUserGroupModel.h"

@interface ContactsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *haedImage;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *contextLable;
@property (weak, nonatomic) IBOutlet UILabel *netWordLabel;

-(void)setData:(CICQAuthor *)author;

@end
