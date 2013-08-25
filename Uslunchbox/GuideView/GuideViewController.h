//
//  GuideViewController.h
//  Uslunchbox
//
//  Created by Wubai Zhou on 8/24/13.
//  Copyright (c) 2013 wubai zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GuideViewController : UIViewController <UIScrollViewDelegate>


@property (weak, nonatomic) IBOutlet UIScrollView *pageScroll;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (nonatomic,weak) UIView *leftView;
@property (nonatomic,weak) UIView *rightView;

@property (weak, nonatomic) IBOutlet UIButton *startButton;


- (IBAction)goToMainView:(UIButton *)sender;

@end
