//
//  TWTAppDelegate.m
//  CarouselScrollView
//
//  Created by Duncan Lewis on 5/30/13.
//  Copyright (c) 2013 TwoToasters. All rights reserved.
//

#import "TWTAppDelegate.h"

#import "TWTViewController.h"

@implementation TWTAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.viewController = [[TWTViewController alloc] initWithNibName:@"TWTViewController" bundle:nil];
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
