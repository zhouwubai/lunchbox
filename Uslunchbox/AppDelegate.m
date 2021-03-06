//
//  AppDelegate.m
//  Uslunchbox
//
//  Created by wubai zhou on 7/4/13.
//  Copyright (c) 2013 wubai zhou. All rights reserved.
//

#import "AppDelegate.h"

#import "GuideViewController.h"
#import "LoginViewController.h"

@implementation AppDelegate


@synthesize window = _window;
@synthesize guideViewController = _guideViewController;




- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    //设置系统参数，用于判断是否第一次启动应用
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"hasEverLaunched"]){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"hasEverLaunched"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
    }
    
    
    //display GuideViewController
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]){
        GuideViewController *appGuideViewController = [[GuideViewController alloc] init];
        self.window.rootViewController = appGuideViewController;
    }else{
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
        NSLog(@"what is happening");
        UIViewController *chooseSiteVC = [sb instantiateViewControllerWithIdentifier:@"mainVavCV"];
        chooseSiteVC.modalPresentationStyle = UIModalTransitionStyleCoverVertical;
        self.window.rootViewController = chooseSiteVC;
    }
    
    [self.window makeKeyAndVisible];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
