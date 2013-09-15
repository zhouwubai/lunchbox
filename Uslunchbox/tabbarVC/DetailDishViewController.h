//
//  DetailDishViewController.h
//  Uslunchbox
//
//  Created by Wubai Zhou on 9/2/13.
//  Copyright (c) 2013 wubai zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Dish.h"
#import "DishOrder.h"

@interface DetailDishViewController : UIViewController

@property (nonatomic,strong) Dish *dish;
@property (nonatomic,strong) UIManagedDocument *dishOrderDatabase;

- (IBAction)addOrderToCart:(UIBarButtonItem *)sender;

@end
