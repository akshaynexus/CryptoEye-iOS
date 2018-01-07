//
//  MoreInfoViewController.h
//  CryptoEye
//
//  Created by Akshay on 12/12/17.
//  Copyright © 2017 Akshay. All rights reserved.
//
@import drCharts;
@import GoogleMobileAds;
#import "ViewController.h"
@interface MoreInfoViewController : ViewController<UIWebViewDelegate,MultiLineGraphViewDelegate,MultiLineGraphViewDataSource>
@property (strong, nonatomic) IBOutlet UIImageView *coinimage;
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UILabel *idlabel;
@property (strong, nonatomic) IBOutlet UILabel *coinlabel;
@property (strong, nonatomic) IBOutlet UILabel *pricelabel;
@property (strong, nonatomic) IBOutlet UILabel *marketcaplabel;
@property (strong, nonatomic) IBOutlet UILabel *cirsupplylabel;
@property (strong, nonatomic) IBOutlet UILabel *twentyfourvolabel;
@property (strong, nonatomic) IBOutlet UILabel *onehrperlabel;
@property (strong, nonatomic) IBOutlet UILabel *twentyfourhrperlabel;
@property (strong, nonatomic) IBOutlet UILabel *sevendayperlabel;
@property (nonatomic, strong) NSString *coinLabelStr;
@property (nonatomic, strong) NSString *idstr;
@property (nonatomic, strong) NSString *coinshrt;
@property (nonatomic, strong) NSString *imageName;
@property (strong, nonatomic) IBOutlet UIView *refView4Chart;
@property (nonatomic,strong) NSNumber *intt;
@property (nonatomic,strong) NSDateFormatter *formatter;
- (IBAction)daybtn:(id)sender;
- (IBAction)day7btn:(id)sender;
- (IBAction)month1btn:(id)sender;
- (IBAction)month3btn:(id)sender;
- (IBAction)month6btn:(id)sender;
- (IBAction)year1btn:(id)sender;
- (IBAction)alldatabtn:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btn1;
@property (strong, nonatomic) IBOutlet UIButton *btn2;
@property (strong, nonatomic) IBOutlet UIButton *btn3;
@property (strong, nonatomic) IBOutlet UIButton *btn4;
@property (strong, nonatomic) IBOutlet UIButton *btn5;
@property (strong, nonatomic) IBOutlet UIButton *btn6;
@property (strong, nonatomic) IBOutlet UIButton *btn7;
@property (strong, nonatomic) IBOutlet GADBannerView *bannerView;
@property(nonatomic, strong) GADInterstitial*interstitial;



@end
