//
//  LoginViewController.m
//  Uslunchbox
//
//  Created by wubai zhou on 7/4/13.
//  Copyright (c) 2013 wubai zhou. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *emailLabel;
@property (weak, nonatomic) IBOutlet UITextField *passwdLabel;


@end

@implementation LoginViewController



#pragma mark - Properties

@synthesize email = _email;
@synthesize password = _password;




#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(![self.emailLabel.text length]){
        [self.emailLabel becomeFirstResponder];
        return NO;
    }
    if(![self.passwdLabel.text length]){
        [self.passwdLabel becomeFirstResponder];
        return NO;
    }
    [textField resignFirstResponder];
    return YES;
}




#pragma mark - View Controller LifeCycle

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
    self.emailLabel.placeholder = @"email";
    self.passwdLabel.placeholder = @"password";
    self.emailLabel.delegate = self;
    self.passwdLabel.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)loginClicked:(UIButton *)sender {
    
}
@end
