//
//  LoginViewController.h
//  Uslunchbox
//
//  Created by wubai zhou on 7/4/13.
//  Copyright (c) 2013 wubai zhou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController

@property(nonatomic, copy) NSString *email;
@property(nonatomic, copy) NSString *password;

- (IBAction)loginClicked:(UIButton *)sender;


@end
