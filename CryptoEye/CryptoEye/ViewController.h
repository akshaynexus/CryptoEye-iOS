//
//  ViewController.h
//  CryptoEye
//
//  Created by Akshay on 11/12/17.
//  Copyright © 2017 Akshay. All rights reserved.
//
@import GoogleMobileAds;
#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate,UISearchBarDelegate,UITableViewDataSource,GADBannerViewDelegate,UISearchBarDelegate,UISearchDisplayDelegate,UISearchControllerDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableCvi;
@property (strong, nonatomic) IBOutlet GADBannerView *bannerView;


@property(nonatomic, strong) GADInterstitial*interstitial;
- (IBAction)showInfo:(id)sender;

- (IBAction)refDataBtn:(id)sender;


@end

