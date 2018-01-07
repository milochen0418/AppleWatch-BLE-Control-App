//
//  MultipeerMsgHelper.h
//  MultipeerGroupChat
//
//  Created by Milo Chen on 3/16/15.
//  Copyright (c) 2015 Apple, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface MultipeerMsgHelper : NSObject


-(void) doRunningWithDisplayName:(NSString*) displayName ;
-(void) setPeersWithCurrentVC:(UIViewController*) currentVC ;
-(void) setRecvListener:(void(^)(NSString* sentFrom, NSString* recvStr))listener;

-(void) sendMessage:(NSString*)msgStr;
-(NSString*) getDisplayName;
+(MultipeerMsgHelper*) sharedInstance;





@end
