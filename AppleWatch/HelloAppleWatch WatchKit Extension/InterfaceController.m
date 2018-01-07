//
//  InterfaceController.m
//  HelloAppleWatch WatchKit Extension
//
//  Created by Milo Chen on 2/6/15.
//  Copyright (c) 2015 Milo Chen. All rights reserved.
//

#import "InterfaceController.h"
#import "MultipeerMsgHelper.h"

@interface InterfaceController()
@property (strong, nonatomic) IBOutlet WKInterfaceLabel *mHelloLbl;

@property (strong, nonatomic) IBOutlet WKInterfaceButton *mSayHelloBtn;


@end


@implementation InterfaceController
@synthesize mHelloLbl;
@synthesize mBtnImage;
- (IBAction)clickToSayHello {
    static int time = 0;
    time = time + 1;
    [mHelloLbl setText:[NSString stringWithFormat:@"Hello %d",time]];
    

    
}

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
}
- (IBAction)clickToPowerOn {
    
    NSString * str = @"PowerOn";
    [self sendStringToApp:str];
    
    
//    [mBtnImage setImage:[UIImage imageNamed:@"JtBtn01Normal400x400.png"]];

    
 //   [[MultipeerMsgHelper sharedInstance] sendMessage:@"Turn On"];
}
- (IBAction)clickToToggle {
    [self sendStringToApp:@"Toggle"];
}

- (IBAction)clickToPowerOff {
    NSString * str = @"PowerOff";
    [self sendStringToApp:str];
 //   [[MultipeerMsgHelper sharedInstance] sendMessage:@"Turn Off"];
}

-(void) sendStringToApp:(NSString*) str {

    NSDictionary *applicationData = [[NSDictionary alloc] initWithObjects:@[str] forKeys:@[@"PowerStatus"]];
    
    //Handle reciever in app delegate of parent app
    [WKInterfaceController openParentApplication:applicationData reply:
     ^(NSDictionary *replyInfo, NSError *error) {
        NSLog(@"%@ %@",replyInfo, error);
    }];
    
    
    
}




- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    
    [mBtnImage setImageNamed:@"JtBtn01Normal400x400.png"];
    //[mBtnImage startAnimating];
    
    
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
    //[mBtnImage stopAnimating];
}

@end



