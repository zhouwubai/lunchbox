//
//  orderTableViewController.h
//  Uslunchbox
//
//  Created by Wubai Zhou on 8/31/13.
//  Copyright (c) 2013 wubai zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataTableViewController.h"

@interface orderTableViewController : CoreDataTableViewController

@property (nonatomic,strong) UIManagedDocument *dishOrderDatabase;

@end
