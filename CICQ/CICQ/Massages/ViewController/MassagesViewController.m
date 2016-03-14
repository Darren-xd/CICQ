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
#import "NewMassageModel.h"
#import "CICQUserGroupModel.h"
#import "MJRefresh.h"


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
    NSMutableArray *filterData;
//    UISearchController *searchController;
    
}

@property(nonatomic,strong)UISearchController *searchController;

@end

@implementation MassagesViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    chatData = [[NSMutableArray alloc]init];
    phoneData = [[NSMutableArray alloc]init];
    filterData = [[NSMutableArray alloc]init];
    
    for (int i=1; i<=10; i++) {
        NewMassageModel *msgModel = [[NewMassageModel alloc]init];
        msgModel.head = [NSString stringWithFormat:@"%d.jpg",i];
        msgModel.userName = [NSString stringWithFormat:@"abc我滴老家%d",i];
        msgModel.content = [NSString stringWithFormat:@"%d我的家在东北松花江上，么么哒",i];
        msgModel.time = @"20:00";
        [chatData addObject:msgModel];
        
        NewMassageModel *phoneModel = [[NewMassageModel alloc]init];
        phoneModel.head = [NSString stringWithFormat:@"%d.jpg",i];
        phoneModel.userName = [NSString stringWithFormat:@"efg%d",i];
        phoneModel.content = [NSString stringWithFormat:@"%d山上的山花开呀，我才到山上来，原来你也是上山才到山上来",i];
        phoneModel.time = @"8:00";
        [phoneData addObject:phoneModel];
    }
    
    msgTableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    msgTableView.delegate = self;
    msgTableView.dataSource = self;
    msgTableView.backgroundColor = [UIColor clearColor];
    msgTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshHeader)];
    msgTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshFooter)];
    [msgTableView registerNib:[UINib nibWithNibName:@"NewMassageTableViewCell" bundle:nil] forCellReuseIdentifier:MYCHATCELL];
    [self.view addSubview:msgTableView];
    
    _searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
    _searchController.delegate = self;
    _searchController.dimsBackgroundDuringPresentation = false;
    [_searchController.searchBar sizeToFit];
    _searchController.searchResultsUpdater = self;
    msgTableView.tableHeaderView = _searchController.searchBar;
    
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

-(void)refreshHeader
{
    [msgTableView.mj_header endRefreshing];
}

-(void)refreshFooter
{
    [msgTableView.mj_footer endRefreshing];
//    [msgTableView.mj_footer noticeNoMoreData];
}


#pragma mark 用户选择标签，切换数据源
-(void)onClickSegmentedControl:(UISegmentedControl *)segmented
{
    [msgTableView reloadData];
}

#pragma mark searchController 代理方法
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    NSString *searchString = searchController.searchBar.text;
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"userName contains[c] %@", searchString];
    
    if (filterData != nil) {
        [filterData removeAllObjects];
    }
    
    if (segmentedView.selectedSegmentIndex == 0)
    {
        filterData = [NSMutableArray arrayWithArray:[chatData filteredArrayUsingPredicate:preicate]];
    }else
    {
        filterData = [NSMutableArray arrayWithArray:[phoneData filteredArrayUsingPredicate:preicate]];
    }
    [msgTableView reloadData];
}


-(void)newMassage:(NSNotification*)notification{
//    NSLog(notification.object);
    //真机才有效果
    AudioServicesPlaySystemSound(SOUNDID);
}

#pragma mark 右上角加号按钮处理事件
-(void)onClickAddHander{

    [[NSNotificationCenter defaultCenter]postNotificationName:@"HelloNotification" object:@"hello"];
}


#pragma mark 创建Cell 并重用
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewMassageTableViewCell *chatCell = [tableView dequeueReusableCellWithIdentifier:MYCHATCELL];
    chatCell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (_searchController.active) {
        [chatCell setData:filterData[indexPath.row]];
    }else{
        if (segmentedView.selectedSegmentIndex == 0) {
            [chatCell setData:chatData[indexPath.row]];
        }else{
            [chatCell setData:phoneData[indexPath.row]];
        }
    }
    return chatCell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //如果搜索为激活状态则显示过滤数据条数
    if (_searchController.active) {
        return filterData.count;
    }else{
        if(segmentedView.selectedSegmentIndex == 0){
            return chatData.count;
        }else{
            return phoneData.count;
        }
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


//-(void)viewWillAppear:(BOOL)animated
//{
//    NSLog(@"11111");
//    [self searchBarCancelButtonClicked:self.searchController.searchBar];
//}


@end
