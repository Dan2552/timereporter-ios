//
//  DGSyncViewController.h
//  Sandbox
//
//  Created by Daniel Green on 11/12/2012.
//  Copyright (c) 2012 Daniel Green. All rights reserved.
//


@interface DGSyncViewController : UIViewController

//Override this method to handle sign in request from the sync server
- (void)syncSignInRequired;
- (void)syncSignInSuccess;
@end
