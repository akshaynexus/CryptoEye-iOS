//
//  MoreInfoViewController.m
//  CryptoEye
//
//  Created by Akshay on 12/12/17.
//  Copyright © 2017 Akshay. All rights reserved.
//

#import "MoreInfoViewController.h"
@import Lottie;
#import "LCLineChartView.h"
#define SECS_PER_DAY (86400)
@interface MoreInfoViewController ()
{
    NSArray *jsonArray;
     NSArray *jsonArray2;
    NSMutableArray *coinid;
    NSMutableArray *onedayvol;
NSMutableArray *marketcap;
    NSMutableArray *price;
    NSMutableArray *cirsupply;
    NSMutableArray *per24hr;
    NSString *y;
    NSMutableArray *per1hr;
    NSMutableArray *per7d;
    NSMutableArray *temparr;
    NSMutableArray *symbol;
    NSString *id4api;
    NSString *init;
    NSString *tickerapi;
    UIView* coverView;
    NSMutableArray *price4rmapi;
    NSMutableArray *price4graphdata;
    NSMutableArray *time4graph;
    NSInteger *i ;
    LCLineChartData *d;
    LOTAnimationView *animation;
}

@end

@implementation MoreInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}
-(void)viewDidAppear:(BOOL)animated{
    self.webView.delegate = self;
   
    tickerapi = @"https://api.coinmarketcap.com/v1/ticker/";
    self.coinlabel.text = [NSString stringWithFormat:@"%@ (%@)",self.coinLabelStr,self.coinshrt];
    self.coinimage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[_coinshrt lowercaseString]]];
    self.idlabel.text = self.idstr;
    //setting data from the recived vals from tableview
      [self getid4api];
  
    // Do any additional setup after loading the view.
    
}
-(void)getgraphdata{
    NSString *graphapi = [NSString stringWithFormat:@"http://www.coincap.io/history/1day/%@",self.coinshrt];
    NSString *url = graphapi;
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:url]];
    NSError *error = nil;
    NSHTTPURLResponse *responseCode = nil;
    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    if(!([responseCode statusCode] == 200)){
        NSLog(@"Error getting %@, HTTP status code %li", url, (long)[responseCode statusCode]);
        
    }
    else{
        NSString *data = [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
        NSData *jsonData = [data dataUsingEncoding:NSUTF8StringEncoding];
        id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
        if (error) {
            NSLog(@"Error parsing JSON: %@", error);
        }
        else
        {
            price4graphdata = [[NSMutableArray alloc] init];
                  time4graph = [[NSMutableArray alloc] init];
            self.intt = 0;
             jsonArray2 = (NSArray *)jsonObject;
                           price4rmapi =[jsonArray2 valueForKey: @"price"];
            //sperating data to diffrent arrays
            
            for (NSMutableArray *tempObject in price4rmapi) {
                   [time4graph addObject:[tempObject objectAtIndex:0]];
                [price4graphdata addObject:[tempObject objectAtIndex:1]];
            }
            self.formatter = [[NSDateFormatter alloc] init];
            [self.formatter setDateFormat:[NSDateFormatter dateFormatFromTemplate:@"yyyyMMMd" options:0 locale:[NSLocale currentLocale]]];
      
}
    }
}

-(void)showgraph{
    

}
-(void)stoploader{
    animation.loopAnimation = false;
}
-(void)showloader{
    // get your window screen size
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    //create a new view with the same size
    coverView = [[UIView alloc] initWithFrame:screenRect];
    animation = [LOTAnimationView animationNamed:@"preloader"];
    animation.contentMode = UIViewContentModeScaleAspectFit;
    animation.center = self.view.center;
    animation.loopAnimation = TRUE;
    [animation playWithCompletion:^(BOOL animationFinished) {
        [UIView animateWithDuration:1.0f animations:^{
            [coverView removeFromSuperview];
        }];
        
       
    }];
    [coverView addSubview:animation];
    // change the background color to black and the opacity to 0.6
    coverView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
    // add this new view to your main view
    [self.view addSubview:coverView];
}
-(void)getcoins {
    NSString *url = tickerapi;
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:url]];
    NSError *error = nil;
    NSHTTPURLResponse *responseCode = nil;
    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    if(!([responseCode statusCode] == 200)){
        NSLog(@"Error getting %@, HTTP status code %li", url, (long)[responseCode statusCode]);
        
    }
    
    else{
    NSString *data = [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
    NSData *jsonData = [data dataUsingEncoding:NSUTF8StringEncoding];
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    if (error) {
        NSLog(@"Error parsing JSON: %@", error);
    }
    else
    {
        if ([jsonObject isKindOfClass:[NSArray class]])
        {
            [self stoploader];
           
            jsonArray = (NSArray *)jsonObject;
            //setting individual array data
            coinid  =[jsonArray valueForKey: @"id"];
            onedayvol =[jsonArray valueForKey: @"24h_volume_usd"];
            marketcap =[jsonArray valueForKey: @"market_cap_usd"];
            price = [jsonArray valueForKey: @"price_usd"];
            cirsupply = [jsonArray valueForKey: @"total_supply"];
            per24hr = [jsonArray valueForKey: @"percent_change_24h"];
            per1hr = [jsonArray valueForKey: @"percent_change_1h"];
            per7d = [jsonArray valueForKey: @"percent_change_7d"];
            symbol = [jsonArray valueForKey: @"symbol"];
           
               [self getgraphdata];
            
            self.pricelabel.text = [NSString stringWithFormat:@"$%@",price[0]];
            self.marketcaplabel.text = [NSString stringWithFormat:@"$%@",marketcap[0]];
            self.cirsupplylabel.text = [NSString stringWithFormat:@"%@",cirsupply[0]];
            self.twentyfourvolabel.text = [NSString stringWithFormat:@"$%@",onedayvol[0]];
            if ([per24hr[0] rangeOfString:@"-"].location == NSNotFound) {
                //doesnt contain
                self.twentyfourhrperlabel.textColor = [UIColor greenColor];
                self.twentyfourhrperlabel.text = per24hr [0];
            } else {
                self.twentyfourhrperlabel.textColor = [UIColor redColor];
                self.twentyfourhrperlabel.text = per24hr[0];
                //does contain
                
            }
            if ([per7d[0] rangeOfString:@"-"].location == NSNotFound) {
                //doesnt contain
                self.sevendayperlabel.textColor = [UIColor greenColor];
                self.sevendayperlabel.text = per7d[0];
            } else {
                self.sevendayperlabel.textColor = [UIColor redColor];
                self.sevendayperlabel.text = per7d [0];
                //does contain
                
            }
            if ([per1hr[0] rangeOfString:@"-"].location == NSNotFound) {
                //doesnt contain
                self.onehrperlabel.textColor = [UIColor greenColor];
                self.onehrperlabel.text = per1hr [0];
            } else {
                self.onehrperlabel.textColor = [UIColor redColor];
                self.onehrperlabel.text = per1hr [0];
                //does contain
                
            }
        
        
        }
        else {
            [self stoploader];
      
         
            NSLog(@"it is a dictionary");
            NSDictionary *jsonDictionary = (NSDictionary *)jsonObject;
            NSLog(@"jsonDictionary - %@",jsonDictionary);
        }
    }
    
}
}
- (NSString *) getDataFrom:(NSString *)url{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setHTTPMethod:@"GET"];
    [request setURL:[NSURL URLWithString:url]];
    
    NSError *error = nil;
    NSHTTPURLResponse *responseCode = nil;
    
    NSData *oResponseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&responseCode error:&error];
    
    if([responseCode statusCode] != 200){
        NSLog(@"Error getting %@, HTTP status code %li", url, (long)[responseCode statusCode]);
        return nil;
    }
    
    return [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
}
-(void)getid4api{
    NSString *url2 = [NSString stringWithFormat:@"http://139.59.11.43/api-getid.php?coin=%@",self.coinshrt];
   
    NSURL *url = [NSURL URLWithString:url2];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
   
    [self.webView loadRequest:requestObj];
    [self showloader];

    NSString *str = [self getDataFrom:url2];
    str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"%@",str);
    tickerapi = [NSString stringWithFormat:@"%@%@",tickerapi,str];
    [self getcoins];
    }



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
