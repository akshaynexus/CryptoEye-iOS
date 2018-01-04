//
//  ViewController.h
//  CryptoEye
//
//  Created by Akshay on 11/12/17.
//  Copyright © 2017 Akshay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDelegate,UISearchBarDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tableCvi;
- (IBAction)refDataBtn:(id)sender;


@end

