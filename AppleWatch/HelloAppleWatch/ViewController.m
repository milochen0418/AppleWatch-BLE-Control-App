//
//  ViewController.m
//  HelloAppleWatch
//
//  Created by Milo Chen on 2/6/15.
//  Copyright (c) 2015 Milo Chen. All rights reserved.
//

#import "ViewController.h"
#import "MultipeerMsgHelper.h"
@interface ViewController ()


@end

@implementation ViewController
@synthesize mPowerStatusLbl;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}
- (IBAction)clickToSendData:(id)sender {
    [[MultipeerMsgHelper sharedInstance] sendMessage:@"testSendData"];
}
- (IBAction)clickToPeer:(id)sender {
    
    [[MultipeerMsgHelper sharedInstance] setPeersWithCurrentVC:self];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)clickToTestButton:(id)sender {
    NSLog(@"clickToTestButton is called");
}

@end
