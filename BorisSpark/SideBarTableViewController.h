//
//  SideBarTableViewController.h
//  BorisSpark
//
//  Created by Brett Nishikawa on 2014-03-27.
//  Copyright (c) 2014 Gellert. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SideBarTableViewController : UITableViewController

@property (nonatomic, strong) NSArray *menuItems;
@property (weak, nonatomic) IBOutlet UITableViewCell *firstCell;
@property int temp;

@end
