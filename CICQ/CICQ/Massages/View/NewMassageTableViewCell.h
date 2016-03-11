//
//  NewMassageTableViewCell.h
//  CICQ
//
//  Created by Darren on 16/3/10.
//  Copyright © 2016年 darren. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewMassageTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *massageLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

-(void)setData:(NSString *)head;

@end
