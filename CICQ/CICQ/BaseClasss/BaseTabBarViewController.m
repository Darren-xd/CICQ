//
//  BaseTabBarViewController.m
//  CICQ
//
//  Created by Darren on 16/3/9.
//  Copyright © 2016年 darren. All rights reserved.
//

#import "BaseTabBarViewController.h"
#import "MassagesViewController.h"
#import "ContactsViewController.h"
#import "DynamicViewController.h"

@interface BaseTabBarViewController ()

@property(nonatomic,strong)UINavigationController *massagesNavigation;
@property(nonatomic,strong)UINavigationController *contactsNavigation;
@property(nonatomic,strong)UINavigationController *dynamicNavigation;

@end

@implementation BaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MassagesViewController *massagesView        = [[MassagesViewController alloc]init];
    ContactsViewController *contactsView        = [[ContactsViewController alloc]init];
    DynamicViewController *dynamicView          = [[DynamicViewController alloc]init];
    
    _massagesNavigation  = [[UINavigationController alloc]initWithRootViewController:massagesView];
    _contactsNavigation  = [[UINavigationController alloc]initWithRootViewController:contactsView];
    _dynamicNavigation   = [[UINavigationController alloc]initWithRootViewController:dynamicView];
    
    _contactsNavigation.title                    = @"联系人";
    _massagesNavigation.title                    = @"消息";
    _dynamicNavigation.title                     = @"动态";
    
    
    

    
    self.viewControllers = @[_massagesNavigation,_contactsNavigation,_dynamicNavigation];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateMassageCount:) name:UPDATE_MASSAGE_COUNT object:nil];
}

#pragma mark 更新消息数量
-(void)updateMassageCount:(NSNotification*)notification{
    NSString *count = (NSString *)notification.object;
        _massagesNavigation.tabBarItem.badgeValue = count;
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
