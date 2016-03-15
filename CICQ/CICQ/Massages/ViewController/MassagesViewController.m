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
#import "DBHelp.h"


#define SOUNDID  1109
#define MYCHATCELL @"myNewCell"
#define NIB_NAME @"NewMassageTableViewCell"
#define TITLE @"消息"
#define MASSAGE @"消息"
#define PHONE @"电话"
#define NEW_MASSAGE_TYPE_CHAT 0
#define NEW_MASSAGE_TYPE_PHONE 1

@interface MassagesViewController ()
{
    UITableView *msgTableView;
    UISegmentedControl *segmentedView;
    NSMutableArray *chatData;
    NSMutableArray *phoneData;
    NSMutableArray *filterData;
    int pageIndex;
    int endIndex;
//    UISearchController *searchController;
    
}

@property(nonatomic,strong)UISearchController *searchController;

@end

@implementation MassagesViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    pageIndex = 1;
    chatData = [[NSMutableArray alloc]init];
    phoneData = [[NSMutableArray alloc]init];
    filterData = [[NSMutableArray alloc]init];
    
    for (int i=1; i<20; i++) {
        NewMassageModel *m = [[NewMassageModel alloc]init];
        m.userId = 1;
        m.userName =[NSString stringWithFormat:@"谷子%d",i];
        m.content = @"Hello，大家好，我是谷子";
        m.time = @"20:00";
        m.head = [NSString stringWithFormat:@"%d.jpg",arc4random() % 10 +1];
        m.type = NEW_MASSAGE_TYPE_PHONE;
        
        [phoneData addObject:m];
    }

    FMResultSet *result = [DBHelp selectDataBase:@"select count(*) from massageList"];
    while ([result next]) {
       endIndex = [result intForColumnIndex:0];
    }
    
    [self initReadDataBaseList];
    
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
    //设置每10秒钟发送一次消息
    [NSTimer scheduledTimerWithTimeInterval:10.0f target:self selector:@selector(addNewMassage) userInfo:nil repeats:YES];
}

#pragma mark 加载历史数据
-(void)initReadDataBaseList
{
    //查询前10条数据
    FMResultSet *result = [DBHelp selectDataBase:@"select * from massageList limit 0,10"];
    [self readResultData:result];
    [msgTableView reloadData];
}

#pragma mark 读取数据
-(BOOL)readResultData:(FMResultSet *)result
{
    BOOL bo = YES;
    while ([result next]) {
        NewMassageModel *model = [[NewMassageModel alloc]init];
        model.userId = [result intForColumn:@"user_Id"];
        model.userName = [result stringForColumn:@"user_Name"];
        model.content = [result stringForColumn:@"content"];
        model.time = [result stringForColumn:@"time"];
        model.head = [result stringForColumn:@"head"];
        model.msgCount = [result intForColumn:@"msg_count"];
        model.type = [result intForColumn:@"type"];
        
        if (model.type == NEW_MASSAGE_TYPE_CHAT) {
            [chatData addObject:model];
        }else if(model.type == NEW_MASSAGE_TYPE_PHONE){
            [phoneData addObject:model];
        }
        bo = NO;
    }
    return bo;
}


#pragma mark 添加新消息
-(void)addNewMassage
{
    NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSInteger randomH = 0xA1 + arc4random()%(0xFE - 0xA1 + 1);
    NSInteger randomL = 0xB0 + arc4random()%(0xF7 - 0xB0 + 1);
    NSInteger number = (randomH <<  8)+randomL;
    NSData *data = [NSData dataWithBytes:&number length:2];
    NSString *name = [[NSString alloc]initWithData:data encoding:gbkEncoding];
    
    
    NewMassageModel *msgModel = [[NewMassageModel alloc]init];
    msgModel.head = [NSString stringWithFormat:@"%d.jpg",(1+arc4random()%10)];
    msgModel.userName = name;
    msgModel.content = [NSString stringWithFormat:@"我的家在东北松花江上，么么哒"];
    msgModel.msgCount = 1;
    msgModel.userId = (endIndex++);
    msgModel.time = @"20:00";
    msgModel.type = NEW_MASSAGE_TYPE_CHAT;
    //插入数据库
    [DBHelp addNewMassageModel:msgModel];
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
    NSString *str = [self getExistedList];
    //下拉加载下一页数据,要过滤到列表中已经存在的
    NSString *sql = [NSString stringWithFormat:@"select * from massageList where user_Id not in(%@) limit 0,%d",str,endIndex*10];
    FMResultSet *result = [DBHelp selectDataBase:sql];
    BOOL bo = [self readResultData:result];
    if (bo) {
        pageIndex ++;
    }
    [msgTableView reloadData];
    [msgTableView.mj_footer endRefreshing];
}


-(NSString *)getExistedList
{
    NSMutableArray *arr = [[NSMutableArray alloc]init];
    for (int i = 0; i < chatData.count; i++) {
        NewMassageModel *model = chatData[i];
        [arr addObject:[NSString stringWithFormat:@"%d",model.userId]];
    }
    return [arr componentsJoinedByString:@","];;
}




#pragma mark 用户选择标签，切换数据源
-(void)onClickSegmentedControl:(UISegmentedControl *)segmented
{
    //切换标签的时候重新加载数据源
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
-(void)onClickAddHander
{
    //删除表数据
    BOOL bo = [DBHelp insertDataBase:@"delete from massageList"];
    if (bo) {
        [chatData removeAllObjects];
        [phoneData removeAllObjects];
        [msgTableView reloadData];
    }
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

@end
