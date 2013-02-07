//
//  DGSyncViewController.m
//  Sandbox
//
//  Created by Daniel Green on 11/12/2012.
//  Copyright (c) 2012 Daniel Green. All rights reserved.
//

#import "DGSyncViewController.h"

@interface DGSyncViewController ()

@end

@implementation DGSyncViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(syncSignInRequired) name:@"DGSignInRequired" object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(syncSignInSuccess) name:@"DGSignDismiss" object:nil];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)syncSignInRequired {
    NSLog(@"override syncSignInRequired the view controller to catch sign in request");
}
- (void)syncSignInSuccess {}

@end
