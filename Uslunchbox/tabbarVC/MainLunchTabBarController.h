//
//  MainLunchTabBarController.h
//  Uslunchbox
//
//  Created by Wubai Zhou on 9/3/13.
//  Copyright (c) 2013 wubai zhou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UslunchboxUser.h"
#import <CoreData/CoreData.h>

@interface MainLunchTabBarController : UITabBarController <UINavigationControllerDelegate>


@property (nonatomic) int siteID;

@property (nonatomic,strong) UslunchboxUser *user;
@property (nonatomic,strong) UIManagedDocument *dishOrderDatabase;
@property (nonatomic,strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic,strong) NSManagedObjectModel *managedObjectModel;
@end
