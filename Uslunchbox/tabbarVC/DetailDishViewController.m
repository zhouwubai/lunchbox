//
//  DetailDishViewController.m
//  Uslunchbox
//
//  Created by Wubai Zhou on 9/2/13.
//  Copyright (c) 2013 wubai zhou. All rights reserved.
//

#import "DetailDishViewController.h"

#define DISH_IMAGE_WIDTH      188
#define DISH_IMAGE_HEIGHT     142

@interface DetailDishViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *dishImageView;

@property (weak, nonatomic) IBOutlet UILabel *dishInfoLabel;

@end

@implementation DetailDishViewController

@synthesize dish = _dish;
@synthesize dishImageView = _dishImageView;
@synthesize dishInfoLabel = _dishInfoLabel;


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
    self.title = [self.dish dishName];
    [self setupDishImage];
    [self setupDishInfoLabel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





#pragma mark - user defined

-(void)setupDishImage
{
    UIImage *image = [self.dish dishOriginalImage];
    
    if(image.size.width != DISH_IMAGE_WIDTH || image.size.height != DISH_IMAGE_WIDTH)
    {
        CGSize itemSize = CGSizeMake(DISH_IMAGE_WIDTH, DISH_IMAGE_HEIGHT);
        UIGraphicsBeginImageContextWithOptions(itemSize, NO, 0.0f);
        CGRect imageRect = CGRectMake(0.0, 0.0, itemSize.width, itemSize.height);
        [image drawInRect:imageRect];
        [self.dishImageView setImage:UIGraphicsGetImageFromCurrentImageContext()];
    }
    else
    {
        [self.dishImageView setImage:image];
    }
}




-(void)setupDishInfoLabel
{
//    NSString *lineBreak = @"\n";
    NSString *labelText = [NSString stringWithFormat:@" %@\n price: $ %.01f",[self.dish dishName],[self.dish dishPrice]];
    
    [self.dishInfoLabel setNumberOfLines:0];
//    [self.dishInfoLabel ]
    [self.dishInfoLabel setText:labelText];
}























@end
