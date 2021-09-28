//
//  AppDelegate.m
//  Library Management
//
//  Created by Udasi, Sagar on 24/09/2021.
//

#import "AppDelegate.h"

@import Firebase;
@import UIKit;

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [FIRApp configure];
    return YES;
}

@end
