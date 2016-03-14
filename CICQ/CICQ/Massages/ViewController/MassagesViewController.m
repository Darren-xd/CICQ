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
#define NIB_NAME @"NewMassageTableViewCell"
#define TITLE @"消息"
#define MASSAGE @"消息"
#define PHONE @"电话"
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
        msgModel.msgCount = 2;
        msgModel.time = @"20:00";
        [chatData addObject:msgModel];
        
        NewMassageModel *phoneModel = [[NewMassageModel alloc]init];
        phoneModel.head = [NSString stringWithFormat:@"%d.jpg",i];
        phoneModel.userName = [NSString stringWithFormat:@"谷子%d",i];
        phoneModel.content = [NSString stringWithFormat:@"☎️ 16-03-14"];
        phoneModel.time = @"8:00";
        [phoneData addObject:phoneModel];
    }
    
    msgTableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    msgTableView.delegate = self;
    msgTableView.dataSource = self;
    msgTableView.backgroundColor = [UIColor clearColor];
    msgTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshHeader)];
    msgTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(refreshFooter)];
    [msgTableView registerNib:[UINib nibWithNibName:NIB_NAME bundle:nil] forCellReuseIdentifier:MYCHATCELL];
    [self.view addSubview:msgTableView];
    
    _searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
    _searchController.delegate = self;
    _searchController.dimsBackgroundDuringPresentation = false;
    [_searchController.searchBar sizeToFit];
    _searchController.searchResultsUpdater = self;
    msgTableView.tableHeaderView = _searchController.searchBar;
    
    NSArray *titles = [NSArray arrayWithObjects:MASSAGE,PHONE, nil];
    segmentedView = [[UISegmentedControl alloc]initWithItems:titles];
    segmentedView.frame = CGRectMake(60, 0, 150, 30);
    segmentedView.selectedSegmentIndex = 0;
    
    [segmentedView addTarget:self action:@selector(onClickSegmentedControl:) forControlEvents:UIControlEventValueChanged];
    
    self.navigationItem.titleView = segmentedView;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(onClickAddHander)];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = TITLE;
    
    [NSTimer scheduledTimerWithTimeInterval:2.0f target:self selector:@selector(addNewMassage) userInfo:nil repeats:YES];
}

#pragma mark 添加新消息
-(void)addNewMassage
{
//    NSString *nowTime = [NSString stringWithFormat:@"%l",(long)[NSDate timeIntervalSinceReferenceDate]]
//    time_t *t = time(NULL);
    
    
    //如果消息列表中的数量大于20 则从20个消息中随机继续添加消息数量
    NewMassageModel *msgModel = [[NewMassageModel alloc]init];
    msgModel.head = [NSString stringWithFormat:@"%d.jpg",(1+arc4random()%10)];
    msgModel.userName = [NSString stringWithFormat:@"abc我滴老家"];
    msgModel.content = [NSString stringWithFormat:@"我的家在东北松花江上，么么哒"];
    msgModel.msgCount = 12;
    msgModel.userId = 10000;
    msgModel.time = @"20:00";
    
//    [chatData addObject:msgModel];
    [chatData insertObject:msgModel atIndex:0];
    [msgTableView reloadData];
    [self updateUnreadMessagesNumber];
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

-(void)updateUnreadMessagesNumber
{
    NewMassageModel *model;
    int count = 0;
    for (int i = 0; i < chatData.count; i++) {
        model = chatData[i];
        count += model.msgCount;
    }
    NSString *newCount = nil;
    if (count >= 99) {
        newCount = @"99+";
    }else{
        newCount = [NSString stringWithFormat:@"%d",count];
    }
    AudioServicesPlaySystemSound(SOUNDID);
    [[NSNotificationCenter defaultCenter]postNotificationName:UPDATE_MASSAGE_COUNT object:newCount];
    
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

#pragma mark 右上角加号按钮处理事件
-(void)onClickAddHander{

    
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
    NewMassageModel *model;
    if (segmentedView.selectedSegmentIndex == 0) {
        model = chatData[indexPath.row];
    }else{
        model = phoneData[indexPath.row];
    }
    
    NSLog(@"Click %@ massage",model.userName);
}


//-(void)viewWillAppear:(BOOL)animated
//{
//    NSLog(@"11111");
//    [self searchBarCancelButtonClicked:self.searchController.searchBar];
//}


@end
