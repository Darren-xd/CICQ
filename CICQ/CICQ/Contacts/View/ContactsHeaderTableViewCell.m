//
//  ContactsHeaderTableViewCell.m
//  CICQ
//
//  Created by Darren on 16/3/12.
//  Copyright © 2016年 darren. All rights reserved.
//

#import "ContactsHeaderTableViewCell.h"

@implementation ContactsHeaderTableViewCell

- (void)awakeFromNib
{
    [_arrowButton addTarget:self action:@selector(onClickArrow:) forControlEvents:UIControlEventTouchUpInside];
}


-(void)onClickArrow:(UIButton *)button
{
    self.userModel.status = !self.userModel.status;
    if ([self.detegate respondsToSelector:@selector(CICQtablehData:)]) {
        [self.detegate CICQtablehData:self];
    }
}


-(void)setData:(CICQUserGroupModel *)groupModel
{
    self.userModel = groupModel;
    if (groupModel.status) {
        _arrowButton.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
    }else{
        _arrowButton.imageView.transform = CGAffineTransformMakeRotation(0);
    }
    
    _groupNameLable.text = groupModel.category.categoryName;
    _numberLabel.text = [NSString stringWithFormat:@"%ld/%lu",(long)groupModel.getOnlineCount,(unsigned long)groupModel.authors.count];
}

@end
