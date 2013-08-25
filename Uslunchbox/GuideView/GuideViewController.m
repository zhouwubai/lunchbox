//
//  GuideViewController.m
//  Uslunchbox
//
//  Created by Wubai Zhou on 8/24/13.
//  Copyright (c) 2013 wubai zhou. All rights reserved.
//

#import "GuideViewController.h"

@interface GuideViewController ()

@end

@implementation GuideViewController

@synthesize startButton = _startButton;
@synthesize leftView = _leftView;
@synthesize rightView = _rightView;
@synthesize pageControl; // Do not need set and get function, come from nib file
@synthesize pageScroll;


#pragma mark - View lifecycle


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization,test for github rsa setup
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSInteger numberOfPages = 2;
    pageControl.numberOfPages = numberOfPages;
    pageControl.currentPage = 0;
    
    pageScroll.delegate = self;
    pageScroll.contentSize = CGSizeMake(self.view.frame.size.width * numberOfPages,
                                        self.view.frame.size.height);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return (toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


#pragma mark - User Defined


- (IBAction)goToMainView:(UIButton *)sender {
}


@end
