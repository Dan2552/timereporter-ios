//
//  LoginViewController.h
//  Sandbox
//
//  Created by Daniel Green on 14/12/2012.
//  Copyright (c) 2012 Daniel Green. All rights reserved.
//

#import "DGSyncViewController.h"

@class User;

@interface LoginViewController : DGSyncViewController
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (strong, nonatomic) User *user;

@end
