//
//  DishOrder.h
//  Uslunchbox
//
//  Created by Wubai Zhou on 9/14/13.
//  Copyright (c) 2013 wubai zhou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface DishOrder : NSManagedObject

@property (nonatomic, retain) NSNumber * dishID;
@property (nonatomic, retain) NSString * dishName;
@property (nonatomic, retain) NSNumber * dishPrice;
@property (nonatomic, retain) NSNumber * quantity;
@property (nonatomic, retain) NSDate * dishDate;

@end
