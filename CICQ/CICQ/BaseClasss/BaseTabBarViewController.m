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

@end

@implementation BaseTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MassagesViewController *massagesView        = [[MassagesViewController alloc]init];
    ContactsViewController *contactsView        = [[ContactsViewController alloc]init];
    DynamicViewController *dynamicView          = [[DynamicViewController alloc]init];
    
    UINavigationController *massagesNavigation  = [[UINavigationController alloc]initWithRootViewController:massagesView];
    UINavigationController *contactsNavigation  = [[UINavigationController alloc]initWithRootViewController:contactsView];
    UINavigationController *dynamicNavigation   = [[UINavigationController alloc]initWithRootViewController:dynamicView];
    
    contactsNavigation.title                    = @"联系人";
    massagesNavigation.title                    = @"消息";
    dynamicNavigation.title                     = @"动态";
    
    self.viewControllers = @[massagesNavigation,contactsNavigation,dynamicNavigation];
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
