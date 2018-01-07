//
//  AppDelegate.m
//  HelloAppleWatch
//
//  Created by Milo Chen on 2/6/15.
//  Copyright (c) 2015 Milo Chen. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "MultipeerMsgHelper.h"

@interface AppDelegate ()
@property ViewController *mFirstViewController;

@end

@implementation AppDelegate
@synthesize mFirstViewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[MultipeerMsgHelper sharedInstance] doRunningWithDisplayName:@"Watch"];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void)application:(UIApplication *)application handleWatchKitExtensionRequest:(NSDictionary *)userInfo reply:(void (^)(NSDictionary *))reply {
    
    NSString * replyStr = @"replyStr";
    NSLog(@"handleWatchKitExtensionRequest is called");
    NSString * powerStatus = [userInfo objectForKey:@"PowerStatus"];

    
    if(powerStatus == nil ) {
        replyStr = @"powerStatus == nil";
        NSLog(@"PowerStatus is nil");
        if(mFirstViewController != nil && mFirstViewController.mPowerStatusLbl != nil) {
                    replyStr = @"powerStatus == nil and mFirstViewController ok";
            dispatch_async(dispatch_get_main_queue(),^{
                [mFirstViewController.mPowerStatusLbl setText:@"nil"];
            });
        }
        
    }
    else {
                replyStr = @"powerStatus != nil";
        if(mFirstViewController == nil) {
//            [[UIStoryboard storyboardWithName:@"MainStoryboard_iPhone" bundle:nil] instantiateViewControllerWithIdentifier:@"secondVCSrorybradID"];
            mFirstViewController = (ViewController*)[UIApplication sharedApplication].keyWindow.rootViewController;
            
        }
        
        if(mFirstViewController != nil && mFirstViewController.mPowerStatusLbl != nil) {
                    replyStr = @"powerStatus != nil and mFirstViewController ok";
            
            dispatch_async(dispatch_get_main_queue(),^{
                [mFirstViewController.mPowerStatusLbl setText:powerStatus];
                
                if([powerStatus isEqualToString:@"PowerOn"]) {
                    [[MultipeerMsgHelper sharedInstance] sendMessage:@"Lock"];
                } else if([powerStatus isEqualToString:@"PowerOff"]) {
                    [[MultipeerMsgHelper sharedInstance] sendMessage:@"Unlock"];
                } else if([powerStatus isEqualToString:@"Toggle"]) {
                    [[MultipeerMsgHelper sharedInstance] sendMessage:@"Toggle"];
                }
            });
            
        }
        NSLog(@"PowerStatus is %@", powerStatus);
    }


    
     //reply(@{@"handleWatchKitExtensionRequest":@(1)});
    reply(@{@"handleWatchKitExtensionRequest":replyStr});
}


@end
