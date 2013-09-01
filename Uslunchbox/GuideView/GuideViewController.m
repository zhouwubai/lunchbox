//
//  GuideViewController.m
//  Uslunchbox
//
//  Created by Wubai Zhou on 8/24/13.
//  Copyright (c) 2013 wubai zhou. All rights reserved.
//

#import "GuideViewController.h"
#import "LoginViewController.h"

@interface GuideViewController ()
@property BOOL pageControlBeingUsed;
-(IBAction)changePage;
@end

@implementation GuideViewController

@synthesize startButton = _startButton;
@synthesize pageControl = _pageControl; // Do not need set and get function, come from nib file
@synthesize pageScroll = _pageScroll;
@synthesize pageControlBeingUsed = _pageControlBeingUsed;

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
    self.pageControl.numberOfPages = numberOfPages;
    self.pageControl.currentPage = 0;
    
    self.pageScroll.delegate = self;
    self.pageScroll.contentSize = CGSizeMake(self.view.frame.size.width * numberOfPages,
                                        self.view.frame.size.height);
    self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
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



#pragma mark - scrollView Delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(!self.pageControlBeingUsed){
        CGFloat pageWidth = self.view.frame.size.width;
        int page = floor((scrollView.contentOffset.x - pageWidth/2) / pageWidth) + 1;
        self.pageControl.currentPage = page;
    }
}


#pragma mark - User Defined




-(IBAction)changePage{
    CGRect frame;
    frame.origin.x = self.pageScroll.frame.size.width * self.pageControl.currentPage;
    frame.origin.y = 0;
    frame.size = self.pageScroll.frame.size;
    [self.pageScroll scrollRectToVisible:frame animated:YES];
    
    self.pageControlBeingUsed = YES;
}

- (IBAction)goToMainView:(UIButton *)sender {
    
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch"];
    [self.startButton setHidden:YES];
    [self.pageScroll setHidden:YES];
    [self.pageControl setHidden:YES];
    
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil];
    NSLog(@"what is happending");
    UIViewController *chooseSiteVC = [sb instantiateViewControllerWithIdentifier:@"mainVavCV"];
    chooseSiteVC.modalPresentationStyle = UIModalTransitionStyleCoverVertical;
    [self presentViewController:chooseSiteVC animated:YES completion:NULL];
    
}
@end



































