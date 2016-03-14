//
//  ContactsHeaderTableViewCell.m
//  CICQ
//
//  Created by Darren on 16/3/12.
//  Copyright © 2016年 darren. All rights reserved.
//

#import "ContactsHeaderTableViewCell.h"

@implementation ContactsHeaderTableViewCell


- (instancetype)initWithReuseIdentifier:(nullable NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        self.arrowButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 15, 10, 10)];
        [_arrowButton setImage:[UIImage imageNamed:@"ContactRightArrow"] forState:UIControlStateNormal];
        _arrowButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_arrowButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _arrowButton.imageView.contentMode = UIViewContentModeCenter;
        _arrowButton.imageView.clipsToBounds = NO;
        [self.contentView addSubview:_arrowButton];
        [_arrowButton addTarget:self action:@selector(onClickArrow:) forControlEvents:UIControlEventTouchUpInside];
        
        self.groupNameLable = [[UILabel alloc]initWithFrame:CGRectMake(35, 8, 300, 20)];
        
        [self.contentView addSubview:_groupNameLable];
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onClickArrow:)];
        
        [self.contentView addGestureRecognizer:tapGesture];
        
    }
    return self;
}

-(void)onClickArrow:(id)ender
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
    NSString *name = [groupModel.category.categoryName stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    NSString *str = [NSString stringWithFormat:@"%@  (%ld/%lu)",name,(long)groupModel.getOnlineCount,(unsigned long)groupModel.authors.count];
    NSLog(str,nil);
    _groupNameLable.text = str;
}

@end
