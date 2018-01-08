//
//  AboutViewController.m
//  CryptoEye
//
//  Created by Akshay on 08/01/18.
//  Copyright © 2018 Akshay. All rights reserved.
//

#import "AboutViewController.h"
@import MaterialComponents;
@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)copybtcadddratc:(id)sender {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = @"3NTPeXYfFe2cBM782jJcsh4bmAxCgD44uE";
    MDCSnackbarMessage *message = [[MDCSnackbarMessage alloc] init];
    message.text = @"Thanks for donating !";
    [MDCSnackbarManager showMessage:message];
}

- (IBAction)altcoindonate:(id)sender {
    NSURL* url = [[NSURL alloc] initWithString: @"https://shapeshift.io/shifty.html?destination=3NTPeXYfFe2cBM782jJcsh4bmAxCgD44uE&output=BTC"];
    MDCSnackbarMessage *message = [[MDCSnackbarMessage alloc] init];
    message.text = @"Thanks for donating !";
    [MDCSnackbarManager showMessage:message];
    [[UIApplication sharedApplication] openURL: url];
}
@end
