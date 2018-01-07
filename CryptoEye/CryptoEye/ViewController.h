//
//  ViewController.h
//  CryptoEye
//
//  Created by Akshay on 11/12/17.
//  Copyright © 2017 Akshay. All rights reserved.
//
@import GoogleMobileAds;
#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate,UISearchBarDelegate,UITableViewDataSource,GADBannerViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableCvi;


@property(nonatomic, strong) GADInterstitial*interstitial;

- (IBAction)refDataBtn:(id)sender;


@end

