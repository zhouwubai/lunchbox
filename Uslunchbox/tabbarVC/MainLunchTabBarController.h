//
//  MainLunchTabBarController.h
//  Uslunchbox
//
//  Created by Wubai Zhou on 9/3/13.
//  Copyright (c) 2013 wubai zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UslunchboxUser.h"

@interface MainLunchTabBarController : UITabBarController <UINavigationControllerDelegate>


@property (nonatomic) int siteID;

@property (nonatomic,strong) UslunchboxUser *user;


@end
