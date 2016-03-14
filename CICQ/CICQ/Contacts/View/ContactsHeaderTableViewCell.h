//
//  ContactsHeaderTableViewCell.h
//  CICQ
//
//  Created by Darren on 16/3/12.
//  Copyright © 2016年 darren. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContactsTableViewCell.h"

#define HEAD_CELL_IDENTIFIER @"headCellIdentifier"
#define HEND_CELL_NIB @"ContactsHeaderTableViewCell"
@class ContactsHeaderTableViewCell;
@protocol CICQContactsHeadTableViewCellDetegate <NSObject>

-(void)CICQtablehData:(ContactsHeaderTableViewCell*)headerCell;

@end

@interface ContactsHeaderTableViewCell : UITableViewHeaderFooterView
@property(nonatomic,strong)UILabel *groupNameLable;
@property(nonatomic,strong)UIButton *arrowButton;
@property(nonatomic,strong)CICQUserGroupModel *userModel;

@property(nonatomic,strong)id<CICQContactsHeadTableViewCellDetegate>detegate;

-(void)setData:(CICQUserGroupModel *)groupModel;

@end
