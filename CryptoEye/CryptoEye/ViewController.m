//
//  ViewController.m
//  CryptoEye
//
//  Created by Akshay on 11/12/17.
//  Copyright © 2017 Akshay. All rights reserved.
//
#import "Reachability.h"
#import "ViewController.h"
@import SCLAlertView_Objective_C;
#import "CryptoTableViewCell.h"
#import "MoreInfoViewController.h"
#import "AnimLoaderViewController.h"
@import Lottie;
#import <tgmath.h>
#import "AboutViewController.h"

@interface ViewController (){
    NSArray *jsonArray;
    NSMutableArray *rank;
NSMutableArray *shrt_form;
    NSMutableArray *priceusd;
    NSMutableArray *perctday;
    NSMutableArray *name;
    NSString *iconfm;
    NSString *coinnamepush;
    NSString *idpush;
    UIView* coverView;
    NSInteger *i ;
   int ii;
    LOTAnimationView *animation;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    i  = 0;
    ii=0;

    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated{
    self.interstitial =[self createAndLoadInterstitial];


    GADRequest *request = [GADRequest request];
    [self.interstitial loadRequest:request];
      self.bannerView.rootViewController = self;
    self.bannerView.adUnitID = @"ca-app-pub-9656245162764779/9445807500";
  
    [self.bannerView loadRequest:[GADRequest request]];


    if(i>=0){
        [self showloader];
    }
    else{
       
       
      [self.tableCvi reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
         i++;
      
    }
    
    
   
        
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
   if ([segue.identifier isEqualToString:@"morecrypinfo"]) {
        MoreInfoViewController *controller = (MoreInfoViewController *)segue.destinationViewController;
        controller.coinimage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[iconfm lowercaseString]]];
        controller.coinLabelStr = coinnamepush;
       controller.coinshrt = iconfm;
       controller.idstr = idpush;
       
   }
   else if ([segue.identifier isEqualToString:@"showinfo"]){
       //add data to segue before showing about
       AboutViewController *controller = (
       AboutViewController*)segue.destinationViewController;
       
   }
    
}
-(UIColor*)colorWithHexString:(NSString*)hex
{
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) return [UIColor grayColor];
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    
    if ([cString length] != 6) return  [UIColor grayColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    ///NSLog(@"%lu", (unsigned long)jsonArray.count);
    return [jsonArray count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    [coverView removeFromSuperview];
    CryptoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.coinname.text  = name[indexPath.row];
    cell.shrtform.text  = shrt_form[indexPath.row];
    cell.pricelabel.text  =  cell.fluclabel.text = [@"$"
                                                    stringByAppendingString:priceusd[indexPath.row]];
  
    if ([perctday[indexPath.row] rangeOfString:@"-"].location == NSNotFound) {
       [cell.fluclabel setTextColor:[UIColor greenColor]];
        cell.fluclabel.text = [@"+"
                               stringByAppendingString:perctday[indexPath.row]];
    } else {
        [cell.fluclabel setTextColor:[UIColor redColor]];
        cell.fluclabel.text = perctday[indexPath.row];
    }
   

    iconfm =  shrt_form[indexPath.row];
cell.coinicon.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[iconfm lowercaseString]]];
    cell.idlabel.text = rank[indexPath.row];
    cell.backgroundColor =[self colorWithHexString:@"37474f"];
    
    return cell;
}
- (GADInterstitial *)createAndLoadInterstitial {
    GADInterstitial *interstitial =
    [[GADInterstitial alloc] initWithAdUnitID:@"ca-app-pub-9656245162764779/8774711901"];
    interstitial.delegate = self;
    [interstitial loadRequest:[GADRequest request]];
    return interstitial;
}

- (void)interstitialDidDismissScreen:(GADInterstitial *)interstitial {
    self.interstitial = [self createAndLoadInterstitial];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ++ii;
    if (ii%3 == 0){
        if (self.interstitial.isReady) {
            [self.interstitial presentFromRootViewController:self];
        } else {
            NSLog(@"Ad wasn't ready");
        }

    }
iconfm =  shrt_form[indexPath.row];
    coinnamepush =  name[indexPath.row];
    idpush = rank[indexPath.row];
    [self performSegueWithIdentifier:@"morecrypinfo" sender:self];
    
}
-(void)stoploader{
    animation.loopAnimation = false;
//        [coverView removeFromSuperview];
}
-(void)showloader{
    // get your window screen size
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    //create a new view with the same size
    coverView = [[UIView alloc] initWithFrame:screenRect];
    animation = [LOTAnimationView animationNamed:@"loader_ring"];
    animation.contentMode = UIViewContentModeScaleAspectFit;
    animation.center = self.view.center;
    animation.loopAnimation = TRUE;
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        //no internet connection
        SCLAlertView *alert = [[SCLAlertView alloc] init];
        NSLog(@"There IS NO internet connection");
        [alert showError:self title:@"No Internet Connection" subTitle:@"Check your internet connection and try again." closeButtonTitle:@"OK" duration:0.0f]; // Error
    } else {
         [coverView addSubview:animation];
            [self getdatatable];
        // change the background color to black and the opacity to 0.6
        coverView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        // add this new view to your main view
        [self.view addSubview:coverView];
        //We have internet conn
        [animation playWithCompletion:^(BOOL animationFinished) {
            [UIView animateWithDuration:1.0f animations:^{
                  [self.tableCvi reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
            }];
            
            
        }];
    
      
    }
  
   
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getdatatable{
    NSString *url = @"https://api.coinmarketcap.com/v1/ticker/?limit=500";
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:url]];
    NSError *error = nil;
    NSHTTPURLResponse *responseCode = nil;
    
    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
    if([responseCode statusCode] != 200){
        NSLog(@"Error getting %@, HTTP status code %li", url, (long)[responseCode statusCode]);
        
    }
    
    NSString *data = [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
    
    NSData *jsonData = [data dataUsingEncoding:NSUTF8StringEncoding];
    
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    
    if (error) {
        NSLog(@"Error parsing JSON: %@", error);
    }
    else
    {
        [self stoploader];
        if ([jsonObject isKindOfClass:[NSArray class]])
        {
            //NSLog(@"it is an array!");
            jsonArray = (NSArray *)jsonObject;
            // NSLog(@"jsonArray - %@",jsonArray);
            // NSLog(@"%lu", (unsigned long)jsonArray.count);
            //NSLog(@"%@", [jsonArray valueForKey:@"MAC"]);
            
            
            
            name  =[jsonArray valueForKey: @"name"];
            
            rank  =[jsonArray valueForKey: @"rank"];
            priceusd = [jsonArray valueForKey:@"price_usd"];
            perctday = [jsonArray valueForKey:@"percent_change_24h"];
            
            shrt_form = [jsonArray valueForKey:@"symbol"];
            
            
        }
        else {
            //NSLog(@"it is a dictionary");
            NSDictionary *jsonDictionary = (NSDictionary *)jsonObject;
            NSLog(@"jsonDictionary - %@",jsonDictionary);
        }
}
}


- (IBAction)showInfo:(id)sender {
      [self performSegueWithIdentifier:@"showinfo" sender:self];
}

- (IBAction)refDataBtn:(id)sender {
    [self.tableCvi reloadData];
}
@end
