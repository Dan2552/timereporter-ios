//
//  LoginViewController.m
//  Sandbox
//
//  Created by Daniel Green on 14/12/2012.
//  Copyright (c) 2012 Daniel Green. All rights reserved.
//

#import "LoginViewController.h"
#import "User.h"
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    self.user = [User first];
    if (self.user) {
        self.emailField.text = self.user.email;
        self.passwordField.text = self.user.password;
    }
}

- (IBAction)signInButton {
    self.user = User.new;
    self.user.email = self.emailField.text;
    self.user.password = self.passwordField.text;
    
    [self.user post:@"sign_in"];
}

- (void)syncSignInSuccess {
    [self.user save];
    [NSURLCredential credentialWithUser:self.user.email password:self.user.password persistence:NSURLCredentialPersistencePermanent];
                     

    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
