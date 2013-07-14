//
//  LoginViewController.m
//  Uslunchbox
//
//  Created by wubai zhou on 7/4/13.
//  Copyright (c) 2013 wubai zhou. All rights reserved.
//

#import "LoginViewController.h"
#import <CommonCrypto/CommonCrypto.h>
#import "SHA1.h"


@interface LoginViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *emailLabel;
@property (weak, nonatomic) IBOutlet UITextField *passwdLabel;
@property  (nonatomic,strong) SHA1 *crypto;


@end

@implementation LoginViewController



#pragma mark - Properties

@synthesize email = _email;
@synthesize password = _password;
@synthesize crypto = _crypto;

-(SHA1 *)crypto{
    if(!_crypto)
        _crypto = [[SHA1 alloc] init];
    return _crypto;
}



-(void) alertStatus:(NSString *)msg : (NSString *)title
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:msg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}


- (IBAction)loginClicked:(UIButton *)sender {
    @try {
        if([self.emailLabel.text isEqualToString:@""] || [self.passwdLabel.text isEqualToString:@""]){
            [self alertStatus:@"Please enter both email and password" :@"Login Failed!"];
        }else{
            
            NSString *sha1 = [self.crypto stringToSha1:[self.passwdLabel text]];
            NSString *post = [[NSString alloc] initWithFormat:@"email=%@&password=%@",[self.emailLabel text],sha1];
            NSLog(@"PostData: %@",post);
            
            NSURL *url = [NSURL URLWithString:@"http://uslunchbox.com/uslunchbox/MemberLoginServlet"];
            NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
            NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
            
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
            [request setURL:url];
            [request setHTTPMethod:@"post"];
            [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
            [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
            [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
            [request setHTTPBody:postData];
            
            
            NSError *error = [[NSError alloc] init];
            NSHTTPURLResponse *response = nil;
            NSData *urlData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
            
            NSLog(@"Response code: %d", [response statusCode]);
            if([response statusCode] >= 200 && [response statusCode] < 300)
            {
            
            }else{
                
            }
            
        }
    }
    @catch (NSException *exception) {
        NSLog(@"Exception: %@",exception);
        [self alertStatus:@"Connection Failed" :@"Login Failed"];
    }
}


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
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    gestureRecognizer.cancelsTouchesInView = FALSE;
    [self.view addGestureRecognizer:gestureRecognizer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}


#pragma mark - User Defined methods

-(void)hideKeyboard{
    [self.view endEditing:YES];
}



@end
