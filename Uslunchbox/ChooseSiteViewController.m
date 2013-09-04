//
//  ChooseSiteViewController.m
//  Uslunchbox
//
//  Created by Wubai Zhou on 9/4/13.
//  Copyright (c) 2013 wubai zhou. All rights reserved.
//

#import "ChooseSiteViewController.h"
#import "MainLunchTabBarController.h"

@interface ChooseSiteViewController ()

@end

@implementation ChooseSiteViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"FIU MMC"])
    {
        [(MainLunchTabBarController *)[segue destinationViewController] setSiteID:1];
    }
}

@end
