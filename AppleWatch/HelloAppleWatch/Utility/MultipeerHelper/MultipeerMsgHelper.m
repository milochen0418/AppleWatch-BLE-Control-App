//
//  MultipeerMsgHelper.m
//  MultipeerGroupChat
//
//  Created by Milo Chen on 3/16/15.
//  Copyright (c) 2015 Apple, Inc. All rights reserved.
//

#import "MultipeerMsgHelper.h"
#import "SessionContainer.h"
#import "Transcript.h"



@interface MultipeerMsgHelper()<SessionContainerDelegate,MCBrowserViewControllerDelegate>


-(void) setDisplayName:(NSString*) displayName;

@property (nonatomic,strong) NSString * mDisplayName;
@property (nonatomic,copy) void (^mDataRecvListener)(NSString* sentFrom, NSString* recvStr);
@property (strong, nonatomic) NSString *mServiceType;
// MC Session for managing peer state and send/receive data between peers
@property (strong, nonatomic) SessionContainer *mSessionContainer;
// TableView Data source for managing sent/received messagesz
@property (strong, nonatomic) NSMutableArray *transcripts;

@property (nonatomic) BOOL mIsRunning;
@end


@implementation MultipeerMsgHelper
@synthesize mDisplayName,mDataRecvListener;
@synthesize mSessionContainer,mServiceType;
@synthesize mIsRunning;

-(NSString*) getDisplayName {
    return mDisplayName;
}
-(void) sendMessage:(NSString*)msgStr {
    [mSessionContainer sendMessage:msgStr];
    
}

+(MultipeerMsgHelper*) sharedInstance {
    static MultipeerMsgHelper* sMultipeerMsgHelper = nil;
    if( sMultipeerMsgHelper == nil) {
        sMultipeerMsgHelper = [[MultipeerMsgHelper alloc] init];
    }
    return sMultipeerMsgHelper;
}



-(void) doRunningWithDisplayName:(NSString*) displayName {
    if(mIsRunning) {
        NSLog(@"");
        return;
    }
    mDisplayName = displayName;
    mServiceType = @"r";
    mIsRunning = YES;
    [self initMultiPeerConnectivity];
}


-(void)initMultiPeerConnectivity {
    self.mSessionContainer = [[SessionContainer alloc] initWithDisplayName:mDisplayName serviceType:mServiceType];
    mSessionContainer.delegate = self;
}


-(void) setPeersWithCurrentVC:(UIViewController*) currentVC  {
    MCBrowserViewController *browserViewController = [[MCBrowserViewController alloc] initWithServiceType:self.mServiceType session:self.mSessionContainer.session];
    browserViewController.delegate = self;
    browserViewController.minimumNumberOfPeers = kMCSessionMinimumNumberOfPeers;
    browserViewController.maximumNumberOfPeers = kMCSessionMaximumNumberOfPeers;
    //[self presentViewController:browserViewController animated:YES completion:nil];
    [currentVC presentViewController:browserViewController animated:YES completion:nil];
}

-(void) setRecvListener:(void(^)(NSString* sentFrom, NSString* recvStr))listener {
    mDataRecvListener = listener;
}



-(void)  openMCBrowserViewController:(UIViewController*) currentVC {
    
    MCBrowserViewController *browserViewController = [[MCBrowserViewController alloc] initWithServiceType:self.mServiceType session:self.mSessionContainer.session];
    browserViewController.delegate = self;
    browserViewController.minimumNumberOfPeers = kMCSessionMinimumNumberOfPeers;
    browserViewController.maximumNumberOfPeers = kMCSessionMaximumNumberOfPeers;
    
    //[self presentViewController:browserViewController animated:YES completion:nil];
    [currentVC presentViewController:browserViewController animated:YES completion:nil];
    
}

#pragma mark - MCBrowserViewControllerDelegate methods
// Override this method to filter out peers based on application specific needs
- (BOOL)browserViewController:(MCBrowserViewController *)browserViewController shouldPresentNearbyPeer:(MCPeerID *)peerID withDiscoveryInfo:(NSDictionary *)info
{
    return YES;
}

// Override this to know when the user has pressed the "done" button in the MCBrowserViewController
- (void)browserViewControllerDidFinish:(MCBrowserViewController *)browserViewController
{
    [browserViewController dismissViewControllerAnimated:YES completion:nil];
}

// Override this to know when the user has pressed the "cancel" button in the MCBrowserViewController
- (void)browserViewControllerWasCancelled:(MCBrowserViewController *)browserViewController
{
    [browserViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - SessionContainerDelegate

- (void)receivedTranscript:(Transcript *)transcript
{
    // Add to table view data source and update on main thread
    dispatch_async(dispatch_get_main_queue(), ^{
        //[self insertTranscript:transcript];
        NSLog(@"receivedTranscript is called");
        NSLog(@"peerID.displayName = %@ , recvMsg = %@",transcript.peerID.displayName, transcript.message);
        NSString * str = [NSString stringWithFormat:@"%@: %@", transcript.peerID.displayName, transcript.message];
        if(mDataRecvListener != nil) {
            mDataRecvListener(transcript.peerID.displayName, transcript.message );
        }
        //[[[[iToast makeText:NSLocalizedString(str, @"")] setGravity:iToastGravityBottom] setDuration:iToastDurationShort ] show];
    });
}



@end
