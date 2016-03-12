//
//  NewMassageTableViewCell.m
//  CICQ
//
//  Created by Darren on 16/3/10.
//  Copyright © 2016年 darren. All rights reserved.
//

#import "NewMassageTableViewCell.h"
#import "NewMassageModel.h"

@implementation NewMassageTableViewCell

- (void)awakeFromNib {
    _headImageView.layer.cornerRadius = 25;
    _headImageView.layer.masksToBounds = YES;
    
}


-(void)setData:(NewMassageModel *)chatModel
{
    _userNameLabel.text = chatModel.userName;
    _massageLabel.text = chatModel.content;
    _timeLabel.text = chatModel.time;
    _headImageView.image = [UIImage imageNamed:chatModel.head];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
