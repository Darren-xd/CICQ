//
//  MassagesViewController.h
//  CICQ
//
//  Created by Darren on 16/3/9.
//  Copyright © 2016年 darren. All rights reserved.
//

#import "BaseViewController.h"

#define UPDATE_MASSAGE_COUNT @"UpdateMassageCountNotification"

@interface MassagesViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate,UISearchControllerDelegate,UISearchResultsUpdating,UISearchBarDelegate>

@end
