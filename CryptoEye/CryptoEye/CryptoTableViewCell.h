//
//  CryptoTableViewCell.h
//  CryptoEye
//
//  Created by Akshay on 11/12/17.
//  Copyright © 2017 Akshay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CryptoTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *coinname;
@property (strong, nonatomic) IBOutlet UILabel *shrtform;
@property (strong, nonatomic) IBOutlet UILabel *pricelabel;
@property (strong, nonatomic) IBOutlet UILabel *fluclabel;
@property (strong, nonatomic) IBOutlet UILabel *idlabel;
@property (strong, nonatomic) IBOutlet UIImageView *coinicon;

@end

