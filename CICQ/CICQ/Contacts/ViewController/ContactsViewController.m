//
//  ContactsViewController.m
//  CICQ
//
//  Created by Darren on 16/3/9.
//  Copyright © 2016年 darren. All rights reserved.
//

#import "ContactsViewController.h"
#import "ChatMassageService.h"
#import "CICQUserGroupModel.h"
#import "ContactsTableViewCell.h"
#import "ContactsHeaderTableViewCell.h"


@interface ContactsViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchControllerDelegate,UISearchResultsUpdating,CICQContactsHeadTableViewCellDetegate>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *contactsData;
@property(nonatomic,strong)UISearchController *searchController;


@end

@implementation ContactsViewController

#pragma mark 自定义代理方法
-(void)CICQtablehData:(ContactsHeaderTableViewCell *)headerCell
{
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:headerCell.tag];
    [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"联系人";
    NSLog(@"init contasts");
    
    _contactsData = [[NSMutableArray alloc]init];
    
    _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.sectionHeaderHeight = 30;
    
    [_tableView registerNib:[UINib nibWithNibName:@"ContactsTableViewCell" bundle:nil] forCellReuseIdentifier:@"myCellID"];
    [_tableView registerNib:[UINib nibWithNibName:HEND_CELL_NIB bundle:nil] forHeaderFooterViewReuseIdentifier:HEAD_CELL_IDENTIFIER];
    
    _searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
    _searchController.delegate = self;
    _searchController.dimsBackgroundDuringPresentation = false;
    [_searchController.searchBar sizeToFit];
    _searchController.searchResultsUpdater = self;
    _tableView.tableHeaderView = _searchController.searchBar;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(onClickAddHander)];
    
    [self.view addSubview:_tableView];
    [self onClickAddHander];
}

-(void)onClickAddHander{
    [ChatMassageService getUserFriends:^(id obj){
        [_contactsData removeAllObjects];
        NSDictionary* dictData = obj;
        for (NSDictionary *dic in dictData) {
            CICQUserGroupModel *model = [[CICQUserGroupModel alloc]initWithDictionary:dic];
            [_contactsData addObject:model];
        }
        [_tableView reloadData];
        
    }failed:^(id obj) {
        NSLog(@"请求失败");
    }];

}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ContactsHeaderTableViewCell *cell = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HEAD_CELL_IDENTIFIER];
    cell.detegate = self;
    [cell setData:_contactsData[section]];
    cell.tag = section;
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _contactsData.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContactsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCellID"];
    CICQUserGroupModel *model = _contactsData[indexPath.section];
    CICQAuthor *author = model.authors[indexPath.row];
    [cell setData:author];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    CICQUserGroupModel *model = _contactsData[section];
    //判断折叠状态
    if (!model.status) {
        return 0;
    }else{
        return model.authors.count;
    }
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
