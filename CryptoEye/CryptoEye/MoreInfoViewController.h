//
//  MoreInfoViewController.h
//  CryptoEye
//
//  Created by Akshay on 12/12/17.
//  Copyright © 2017 Akshay. All rights reserved.
//

#import "ViewController.h"
@interface MoreInfoViewController : ViewController<UIWebViewDelegate>
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
@end
