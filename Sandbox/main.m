//
//  main.m
//  Sandbox
//
//  Created by Daniel Green on 15/11/2012.
//  Copyright (c) 2012 Daniel Green. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"

int main(int argc, char *argv[])
{
    @autoreleasepool {
        [NUISettings init];
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
