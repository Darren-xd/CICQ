//
//  BaseViewController.m
//  CICQ
//
//  Created by Darren on 16/3/9.
//  Copyright © 2016年 darren. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createLeftImage];
}

#pragma mack 私有方法创建左边头像
-(void)createLeftImage{
    UIImage *image                          = [UIImage imageNamed:@"head.png"];
    UIImageView *handView                   = [[UIImageView alloc]initWithImage:image];
    handView.frame                          = CGRectMake(-10, 0, 40, 40);
    handView.layer.masksToBounds            = YES;
    handView.layer.cornerRadius             = 20;
    handView.backgroundColor                = [UIColor redColor];
    
    UIBarButtonItem *barButton              = [[UIBarButtonItem alloc]initWithCustomView:handView];
    self.navigationItem.leftBarButtonItem   = barButton;
}

@end
