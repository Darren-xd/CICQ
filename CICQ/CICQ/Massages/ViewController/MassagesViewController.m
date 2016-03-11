//
//  MassagesViewController.m
//  CICQ
//
//  Created by Darren on 16/3/9.
//  Copyright © 2016年 darren. All rights reserved.
//

#import "MassagesViewController.h"
#import "NewMassageTableViewCell.h"
#import "PhoneTableViewCell.h"
#import <AudioToolbox/AudioToolbox.h>
#import "ChatMassageService.h"


#define SOUNDID  1109
#define MYCHATCELL @"myNewCell"
#define SWIDTH self.view.frome.size.width;
#define SHEIGHT self.view.frome.size.height;

@interface MassagesViewController ()
{
    UITableView *msgTableView;
    UISegmentedControl *segmentedView;
    NSMutableArray *chatData;
    NSMutableArray *phoneData;
    NSMutableArray *searchData;
    
}


@end

@implementation MassagesViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    chatData = [[NSMutableArray alloc]init];
    phoneData = [[NSMutableArray alloc]init];
    searchData = [[NSMutableArray alloc]init];
    
    [chatData addObject:@"1.jpg"];
    [chatData addObject:@"2.jpg"];
    [chatData addObject:@"3.jpg"];
    
    
    [phoneData addObject:@"222"];
    [phoneData addObject:@"222"];
    
    
    msgTableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    msgTableView.delegate = self;
    msgTableView.dataSource = self;
    msgTableView.backgroundColor = [UIColor clearColor];
    [msgTableView registerNib:[UINib nibWithNibName:@"NewMassageTableViewCell" bundle:nil] forCellReuseIdentifier:MYCHATCELL];
    [self.view addSubview:msgTableView];
    
    UISearchController *searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
    searchController.delegate = self;
    searchController.searchResultsUpdater = self;
    msgTableView.tableHeaderView = searchController.searchBar;
    
    NSArray *titles = [NSArray arrayWithObjects:@"消息",@"电话", nil];
    segmentedView = [[UISegmentedControl alloc]initWithItems:titles];
    segmentedView.frame = CGRectMake(60, 0, 150, 30);
    segmentedView.selectedSegmentIndex = 0;
    
    [segmentedView addTarget:self action:@selector(onClickSegmentedControl:) forControlEvents:UIControlEventValueChanged];
    
    self.navigationItem.titleView = segmentedView;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(onClickAddHander)];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"消息";
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(newMassage:) name:@"HelloNotification" object:nil];
}
#pragma mark 用户选择标签，切换数据源
-(void)onClickSegmentedControl:(UISegmentedControl *)segmented
{
    [msgTableView reloadData];
}


-(void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    
}


-(void)newMassage:(NSNotification*)notification{
//    NSLog(notification.object);
    //真机才有效果
    AudioServicesPlaySystemSound(SOUNDID);
}

#pragma mark 右上角加号按钮处理事件
-(void)onClickAddHander{
    [[NSNotificationCenter defaultCenter]postNotificationName:@"HelloNotification" object:@"hello"];
    [ChatMassageService getUserFriends:^(id obj){
        NSLog(@"请求会拉啦");
    }failed:^(id obj) {
        NSLog(@"请求失败");
    }];
}


#pragma mark 创建Cell 并重用
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewMassageTableViewCell *chatCell = [tableView dequeueReusableCellWithIdentifier:MYCHATCELL];
    [chatCell setData:chatData[indexPath.row]];
    chatCell.selectionStyle = UITableViewCellSelectionStyleNone;
    return chatCell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(segmentedView.selectedSegmentIndex == 0){
        return chatData.count;
    }else{
        return phoneData.count;
    }
    return 0;
}
#pragma mark Cell高度计算，列表高度一致直接返回固定值
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

#pragma mark 选中某个Cell处理函数
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end
