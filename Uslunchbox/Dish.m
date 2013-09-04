//
//  Dish.m
//  Uslunchbox
//
//  Created by Wubai Zhou on 9/1/13.
//  Copyright (c) 2013 wubai zhou. All rights reserved.
//

#import "Dish.h"

@implementation Dish
//@dynamic dishID;
//@dynamic dishPrice;
//@dynamic dishName;

@synthesize dishID = _dishID;
@synthesize dishName = _dishName;
@synthesize dishPrice = _dishPrice;
@synthesize dishIcon = _dishIcon;
@synthesize dishOriginalImage = _dishOriginalImage;



#pragma mark - user defined
-(NSString *)buildImageUrl
{
    return [NSString stringWithFormat:@"http://uslunchbox.com/uslunchbox/newresources/images/foodimages/food_%d.jpg",self.dishID];
}




#pragma mark - class method

+ (NSDictionary *)executeDishFetch:(NSString *)query withSiteID:(int)siteID withCategory:(int)cID inDay:(NSString *)dateStr
{
    query = [NSString stringWithFormat:@"%@?siteid=%d&date=%@&categoryid=%d",query,siteID,dateStr,cID];
    query = [query stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    // NSLog(@"[%@ %@] sent %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), query);
    NSData *jsonData = [[NSString stringWithContentsOfURL:[NSURL URLWithString:query] encoding:NSUTF8StringEncoding error:nil] dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSDictionary *results = jsonData ? [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:&error] : nil;
    if (error) NSLog(@"[%@ %@] JSON error: %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), error.localizedDescription);
    // NSLog(@"[%@ %@] received %@", NSStringFromClass([self class]), NSStringFromSelector(_cmd), results);
//    NSLog(@"%@",results);
    return results;
}


+(NSString *)returnDishOnlineOrderScheduleUrl
{
    return @"http://uslunchbox.com/uslunchbox/OnlineOrderScheduleServlet";
}



@end
