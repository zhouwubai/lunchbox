//
//  Dish.h
//  Uslunchbox
//
//  Created by Wubai Zhou on 9/1/13.
//  Copyright (c) 2013 wubai zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Dish : NSObject
@property (nonatomic) int dishID;
@property (nonatomic) double dishPrice;
@property (nonatomic,retain) NSString *dishName;

+ (NSDictionary *)executeDishFetch:(NSString *)query withSiteID:(int)siteID withCategory:(int)cID inDay:(NSString *)dateStr;
@end
