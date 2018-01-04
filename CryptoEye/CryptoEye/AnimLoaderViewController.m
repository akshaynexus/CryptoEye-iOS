//
//  AnimLoaderViewController.m
//  CryptoEye
//
//  Created by Akshay on 14/12/17.
//  Copyright © 2017 Akshay. All rights reserved.
//

#import "AnimLoaderViewController.h"
@import Lottie;
@interface AnimLoaderViewController ()

@end

@implementation AnimLoaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
      self.modalPresentationStyle = UIModalPresentationCurrentContext;
    // Do any additional setup after loading the view.
}
-(void)viewDidAppear:(BOOL)animated{
    LOTAnimationView *animation = [LOTAnimationView animationNamed:@"Lottie"];
    [self.view addSubview:animation];
    [animation playWithCompletion:^(BOOL animationFinished) {
        // Do Something
    }];
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

@end
