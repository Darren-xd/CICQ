//
//  MassagesViewController.m
//  CICQ
//
//  Created by Darren on 16/3/9.
//  Copyright © 2016年 darren. All rights reserved.
//

#import "MassagesViewController.h"

@interface MassagesViewController ()
{
    UITableView *tableView;
    UISegmentedControl *segmentedView;
    NSMutableArray *chatData;
}


@end

@implementation MassagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    chatData = [[NSMutableArray alloc]init];
    NSArray *titles = [NSArray arrayWithObjects:@"消息",@"电话", nil];
    segmentedView = [[UISegmentedControl alloc]initWithItems:titles];
    segmentedView.frame = CGRectMake(60, 0, 150, 30);
    self.navigationItem.titleView = segmentedView;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:nil action:nil];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"消息";
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return chatData.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end
