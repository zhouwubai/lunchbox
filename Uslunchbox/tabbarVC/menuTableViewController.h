//
//  menuTableViewController.h
//  Uslunchbox
//
//  Created by Wubai Zhou on 9/1/13.
//  Copyright (c) 2013 wubai zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface menuTableViewController : UITableViewController

@property (nonatomic,strong) NSDate *date;
@property (nonatomic,strong) NSString *dateStr;
@property (nonatomic,strong) NSMutableArray *dishes;


@end
