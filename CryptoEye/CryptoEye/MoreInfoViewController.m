//
//  MoreInfoViewController.m
//  CryptoEye
//
//  Created by Akshay on 12/12/17.
//  Copyright © 2017 Akshay. All rights reserved.
//

#import "MoreInfoViewController.h"
@import Lottie;
@import Charts;
#import "DateValueFormatter.h"
@import GoogleMobileAds;
@import MaterialComponents;
#define SECS_PER_DAY (86400)
@interface MoreInfoViewController ()
{
    NSArray *jsonArray;
     NSArray *jsonArray2;
    NSMutableArray *coinid;
    NSMutableArray *onedayvol;
    NSString *graphapi;
NSMutableArray *marketcap;
    BOOL error2;
    NSMutableArray *values;
    NSMutableArray *xVals;
    NSMutableArray *yVals;
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

    LOTAnimationView *animation;
}

@end

@implementation MoreInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
  

 

}
-(void)viewWillDisappear:(BOOL)animated{
    if (self.isMovingFromParentViewController) {
        NSLog(@"Going back now");
    }
}
-(void)viewDidAppear:(BOOL)animated{
    //Setting admob stuff
    self.bannerView.rootViewController = self;
    self.bannerView.adUnitID = @"ca-app-pub-9656245162764779/3080451969";
    [self.bannerView loadRequest:[GADRequest request]];
    self.webView.delegate = self;
 //showing preloader
   [self showloader];
    
    //seting the data api
    tickerapi = @"https://api.coinmarketcap.com/v1/ticker/";
    //setting data recived from tableview
    self.coinlabel.text = [NSString stringWithFormat:@"%@ (%@)",self.coinLabelStr,self.coinshrt];
    self.coinimage.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png",[_coinshrt lowercaseString]]];
    self.idlabel.text = self.idstr;
    //setting data from the recived vals from tableview
      [self getid4api];
    //init graph
   //graph = [[MultiLineGraphView alloc] initWithFrame:self.refView4Chart.frame];
    // Do any additional setup after loading the view.
    
}
-(void)getgraphdata:(NSString*)his_dur{
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        if([his_dur isEqualToString:@"1day"]){
            graphapi = [NSString stringWithFormat:@"http://www.coincap.io/history/1day/%@",self.coinshrt];
        }
        else if ([his_dur isEqualToString:@"7day"]){
            graphapi = [NSString stringWithFormat:@"http://www.coincap.io/history/7day/%@",self.coinshrt];
        }
        else if ([his_dur isEqualToString:@"30day"]){
            graphapi = [NSString stringWithFormat:@"http://www.coincap.io/history/30day/%@",self.coinshrt];
        }
        else if ([his_dur isEqualToString:@"90day"]){
            graphapi = [NSString stringWithFormat:@"http://www.coincap.io/history/90day/%@",self.coinshrt];
        }
        else if ([his_dur isEqualToString:@"180day"]){
            graphapi = [NSString stringWithFormat:@"http://www.coincap.io/history/180day/%@",self.coinshrt];
        }
        else if ([his_dur isEqualToString:@"360day"]){
            graphapi = [NSString stringWithFormat:@"http://www.coincap.io/history/360day/%@",self.coinshrt];
        }
        else {
            graphapi = [NSString stringWithFormat:@"http://www.coincap.io/history/1day/%@",self.coinshrt];
        }
        
        
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
            
            //parsing json data
            NSString *data = [[NSString alloc] initWithData:oResponseData encoding:NSUTF8StringEncoding];
            NSData *jsonData = [data dataUsingEncoding:NSUTF8StringEncoding];
            id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
            if (error) {
                error2 = YES;
                //handle if no graph is available for the particular coin
                UILabel *label = [[UILabel alloc]initWithFrame:self.refView4Chart.frame];
                label.textColor = [UIColor whiteColor];
                label.text = [NSString stringWithFormat:@"No graph data for %@",self.coinlabel.text];
                label.textAlignment = NSTextAlignmentCenter;
                
                [self.view addSubview:label];
                MDCSnackbarMessage *message = [[MDCSnackbarMessage alloc] init];
                message.text = label.text;
                [MDCSnackbarManager showMessage:message];
                self.btn1.hidden = YES;
                self.btn2.hidden = YES;
                self.btn3.hidden = YES;
                self.btn4.hidden = YES;
                self.btn5.hidden = YES;
                self.btn6.hidden = YES;
                self.btn7.hidden = YES;
                
            }
            else
            {
                //            self.btn1.hidden = NO;
                //            self.btn2.hidden = NO;
                //            self.btn3.hidden = NO;
                //            self.btn4.hidden = NO;
                //            self.btn5.hidden = NO;
                //            self.btn6.hidden = NO;
                //            self.btn7.hidden = NO;
                //  self.refView4Chart.hidden = NO;
                
                //setting graph data
                price4graphdata = [[NSMutableArray alloc] init];
                time4graph = [[NSMutableArray alloc] init];
                self.intt = 0;
                jsonArray2 = (NSArray *)jsonObject;
                price4rmapi =[jsonArray2 valueForKey: @"price"];
                //sperating data to diffrent arrays
                    values = [[NSMutableArray alloc]init];
                xVals = [[NSMutableArray alloc] init];
                yVals = [[NSMutableArray alloc] init];
                
                for (NSMutableArray *tempObject in price4rmapi) {
                    [time4graph addObject:[tempObject objectAtIndex:0]];
                    [price4graphdata addObject:[tempObject objectAtIndex:1]];
                    [values addObject:[[ChartDataEntry alloc] initWithX:[[tempObject objectAtIndex:0]doubleValue] y:[[tempObject objectAtIndex:1]doubleValue]]];
                  
                }
                xVals = time4graph;
                yVals = price4graphdata;
                self.formatter = [[NSDateFormatter alloc] init];
                [self.formatter setDateFormat:[NSDateFormatter dateFormatFromTemplate:@"yyyyMMMd" options:0 locale:[NSLocale currentLocale]]];
               
            }
        }
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
            if(error2 == YES){
                [self stoploader];
            }
            else{
                 [self stoploader];
                [self createlinegrph];
                
            }
            //Run UI Updates
     
        });
    });
    //pretty self explanatory
    
  
}
-(UIColor *)averageColorOfImage:(UIImage*)image{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    unsigned char rgba[4];
    CGContextRef context = CGBitmapContextCreate(rgba, 1, 1, 8, 4, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGContextDrawImage(context, CGRectMake(0, 0, 1, 1), image.CGImage);
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(context);
    if(rgba[3] > 0) {
        CGFloat alpha = ((CGFloat)rgba[3])/255.0;
        CGFloat multiplier = alpha/255.0;
        return [UIColor colorWithRed:((CGFloat)rgba[0])*multiplier
                               green:((CGFloat)rgba[1])*multiplier
                                blue:((CGFloat)rgba[2])*multiplier
                               alpha:alpha];
    }else {
        return [UIColor colorWithRed:((CGFloat)rgba[0])/255.0
                               green:((CGFloat)rgba[1])/255.0
                                blue:((CGFloat)rgba[2])/255.0
                               alpha:((CGFloat)rgba[3])/255.0];
    }
}
-(void)createlinegrph{
    LineChartView *linechart =[[LineChartView alloc] initWithFrame:self.refView4Chart.frame];
    
    LineChartDataSet *dataset = (LineChartDataSet *)linechart.data.dataSets[0];
    dataset = [[LineChartDataSet alloc] initWithValues:values label:@"DataSet 1"];
    dataset.values = values;
    dataset.drawValuesEnabled = FALSE;
    dataset.drawCirclesEnabled = FALSE;
    dataset.fillColor = [UIColor greenColor];
    dataset.highlightColor = [UIColor whiteColor];
    linechart.noDataTextColor = [UIColor whiteColor];
    [dataset setColor:[UIColor greenColor]];
    linechart.xAxis.labelPosition = XAxisLabelPositionBottom;
    linechart.xAxis.labelTextColor = [UIColor whiteColor];
    linechart.leftAxis.labelTextColor = [UIColor whiteColor];
    [linechart.rightAxis setEnabled:NO];
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    [dataSets addObject:dataset];
    linechart.delegate = self;

    LineChartData *data = [[LineChartData alloc] initWithDataSets:dataSets];
//    [linechart.xAxis setLabelCount:arraytt.count force:TRUE];
    DateValueFormatter *formatter2;
    formatter2 = [[DateValueFormatter alloc] init];
    linechart.xAxis.valueFormatter = formatter2;
    linechart.xAxis.granularity = 10;
   
    linechart.xAxis.granularityEnabled = true;
    linechart.drawMarkers = true;
    linechart.xAxis.avoidFirstLastClippingEnabled = false;
    linechart.xAxis.drawLabelsEnabled = TRUE;
    linechart.data = data;
    [self.view addSubview:linechart];
}
-(void)stoploader{
    //pretty self explanatory
    animation.loopAnimation = false;
    [animation removeFromSuperview];
}
- (void)chartValueSelected:(ChartViewBase * __nonnull)chartView entry:(ChartDataEntry * __nonnull)entry highlight:(ChartHighlight * __nonnull)highlight
{
    
    NSLog(@"%f",entry.y);
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
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
        //bg thread
        //gts the data that is displayed other than graph data
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
                    
                    [self getgraphdata:@"30day"];
                    
                    
                    
                }
                else {
                    //this situation never arises,just left it there just in case
                    [self stoploader];
                    
                    
                    NSLog(@"it is a dictionary");
                    NSDictionary *jsonDictionary = (NSDictionary *)jsonObject;
                    NSLog(@"jsonDictionary - %@",jsonDictionary);
                }
            }
            
        }
        dispatch_async(dispatch_get_main_queue(), ^(void){
            //Run UI Updates
            NSNumberFormatter * formatter = [NSNumberFormatter new];
            [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
            [formatter setMaximumFractionDigits:1]; // Set this if you need 1 digits
            
            NSString *tempstr =  [formatter stringFromNumber:[NSNumber numberWithFloat:[price[0] floatValue]]];
            self.pricelabel.text = [NSString localizedStringWithFormat:@"$%@",price[0]];
            tempstr =[formatter stringFromNumber:[NSNumber numberWithFloat:[marketcap[0] floatValue]]];
            self.marketcaplabel.text = [NSString localizedStringWithFormat:@"$%@",tempstr];
            tempstr =[formatter stringFromNumber:[NSNumber numberWithFloat:[cirsupply[0] floatValue]]];
            self.cirsupplylabel.text = [NSString localizedStringWithFormat:@"%@ %@",tempstr,self.coinshrt];
            tempstr =[formatter stringFromNumber:[NSNumber numberWithFloat:[onedayvol[0] floatValue]]];
            self.twentyfourvolabel.text = [NSString localizedStringWithFormat:@"$%@",tempstr];
            //setting colors and all to signify fluctuation percentages
            
            if ([per24hr[0] rangeOfString:@"-"].location == NSNotFound) {
                //doesnt contain
                self.twentyfourhrperlabel.textColor = [UIColor greenColor];
                self.twentyfourhrperlabel.text = [NSString stringWithFormat:@"+%@",per24hr [0]];
            } else {
                self.twentyfourhrperlabel.textColor = [UIColor redColor];
                self.twentyfourhrperlabel.text = [NSString stringWithFormat:@"%@",per24hr [0]];
                //does contain
                
            }
            if ([per7d[0] rangeOfString:@"-"].location == NSNotFound) {
                //doesnt contain
                self.sevendayperlabel.textColor = [UIColor greenColor];
                self.sevendayperlabel.text =[NSString stringWithFormat:@"+%@",per7d [0]];
            } else {
                self.sevendayperlabel.textColor = [UIColor redColor];
                self.sevendayperlabel.text = [NSString stringWithFormat:@"%@",per7d [0]];
                //does contain
                
            }
            if ([per1hr[0] rangeOfString:@"-"].location == NSNotFound) {
                //doesnt contain
                self.onehrperlabel.textColor = [UIColor greenColor];
                self.onehrperlabel.text = [NSString stringWithFormat:@"+%@",per1hr [0]];
            } else {
                self.onehrperlabel.textColor = [UIColor redColor];
                self.onehrperlabel.text = [NSString stringWithFormat:@"%@",per1hr [0]];
                //does contain
                
            }
        });
    });

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
    tickerapi = [NSString stringWithFormat:@"%@%@",tickerapi,self.coinid4api];
        [self performSelectorInBackground:@selector(getcoins) withObject:NULL];
    }



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)daybtn:(id)sender {
//    BOOL doesContain = [self.view.subviews containsObject:graph];
//    if(doesContain){
//        [graph removeFromSuperview];
//    }
//     [self performSelectorInBackground:@selector(getgraphdata:) withObject:@"1day"];
//       // [graph reloadGraph];
}

- (IBAction)day7btn:(id)sender {
//    BOOL doesContain = [self.view.subviews containsObject:graph];
//    if(doesContain){
//        [graph removeFromSuperview];
//    }
//     [self performSelectorInBackground:@selector(getgraphdata:) withObject:@"7day"];
//     //   [graph reloadGraph];
}

- (IBAction)month1btn:(id)sender {
//   // BOOL doesContain = [self.view.subviews containsObject:graph];
//    if(doesContain  == YES){
//       // [graph removeFromSuperview];
//    }
//    [self performSelectorInBackground:@selector(getgraphdata:) withObject:@"30day"];
//   //  [graph reloadGraph];
    }


- (IBAction)month3btn:(id)sender {
//    //BOOL doesContain = [self.view.subviews containsObject:graph];
//    if(doesContain){
//        //[graph removeFromSuperview];
//       // [graph setHidden:YES];
//       // [self.view sendSubviewToBack:graph];
//    }
//     [self performSelectorInBackground:@selector(getgraphdata:) withObject:@"90day"];
//      //  [graph reloadGraph];
}

- (IBAction)month6btn:(id)sender {
//BOOL doesContain = [self.view.subviews containsObject:];
//    if(doesContain){
//        //[graph removeFromSuperview];
//    }
//     [self performSelectorInBackground:@selector(getgraphdata:) withObject:@"180day"];
//       //  [graph reloadGraph];
}

- (IBAction)year1btn:(id)sender {
//   // BOOL doesContain = [self.view.subviews containsObject:graph];
//    if(doesContain){
//       // [graph removeFromSuperview];
//    }
//     [self performSelectorInBackground:@selector(getgraphdata:) withObject:@"360day"];
//      //  [graph reloadGraph];
}
- (IBAction)alldatabtn:(id)sender {
}
@end
