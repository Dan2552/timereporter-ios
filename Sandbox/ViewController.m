//
//  ViewController.m
//  Sandbox
//
//  Created by Daniel Green on 15/11/2012.
//  Copyright (c) 2012 Daniel Green. All rights reserved.
//

#import "ViewController.h"
#import "Models.h"

#import "DGObjectMapper.h"


#import "LoginViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //[User get:@"sign_in"];
    [TimeEntry getIndex];
}

- (void)syncSignInRequired {
    
    [self performSegueWithIdentifier:@"loginSegue" sender:self];
    //[self.navigationController pushViewController:[[LoginViewController alloc] init] animated:YES];
    //[self.navigationController performSegueWithIdentifier:@"loginSegue" sender:self];
    //NSLog(@"%@", self.navigationController);
}
- (IBAction)buttonTapped:(id)sender {
    MyClass *myClass = MyClass.new;
    myClass.dynamicOne = @"one";
    [myClass save];
    myClass.dynamicOne = @"oneupdated";
    myClass.dynamicTwo = @"two";
    [myClass save];
    
    TimeEntry *entry = TimeEntry.new;
    [entry post:@""];
}

@end
