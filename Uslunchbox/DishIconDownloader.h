//
//  DishIconDownloader.h
//  Uslunchbox
//
//  Created by Wubai Zhou on 9/2/13.
//  Copyright (c) 2013 wubai zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Dish;

@interface DishIconDownloader : NSObject <NSURLConnectionDelegate>

@property (nonatomic,strong) Dish *dish;
@property (nonatomic, copy) void (^completionHandler)(void);

-(void)startDownload;
-(void)cancelDownload;

@end
