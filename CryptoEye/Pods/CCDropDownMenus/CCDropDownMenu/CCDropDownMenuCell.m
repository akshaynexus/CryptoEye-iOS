//
//  CCDropDownMenuCell.m
//  CCDropDownMenu
//
//  Created by Kelvin on 7/8/16.
//  Copyright © 2016 Cokile. All rights reserved.
//

#import "CCDropDownMenuCell.h"

@interface CCDropDownMenuCell ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UIColor *originalColor;
@property (nonatomic, strong) CALayer *borderLayer;

@end

@implementation CCDropDownMenuCell

#pragma mark - Cunstom accessorys
- (void)setImage:(UIImage *)image {
    _image = image;
    
    self.imageView.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
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
- (void)setText:(NSString *)text {
    _text = text;
    
    self.textLabel.text = text;
    self.textLabel.textColor = [UIColor whiteColor];
}

- (void)setActiveColor:(UIColor *)activeColor {
    _activeColor = activeColor;
    
    [self updateForColor:activeColor];
}

- (void)setInactiveColor:(UIColor *)inactiveColor {
    _inactiveColor = inactiveColor;
    
    [self updateForColor:inactiveColor];
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    _borderWidth = borderWidth;
    
    self.borderLayer.borderWidth = borderWidth;
}

- (void)setTextAligment:(NSTextAlignment)textAligment {
    _textAligment = textAligment;
    
    self.textLabel.textAlignment = textAligment;
}

#pragma mark - Lifecycle
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.imageView = [[UIImageView alloc] init];
        self.borderLayer = [[CALayer alloc] init];
        
        self.textLabel = [[UILabel alloc] init];
        self.textLabel.textAlignment = NSTextAlignmentLeft;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeOriginalColor:) name:@"cellBackgroundColorChanged" object:self];
    }
    
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Overridden methods
- (void)drawRect:(CGRect)rect {
    CGFloat length = CGRectGetHeight(self.frame);
    
    [self removeAllSubviews];
    
    self.borderLayer.frame = CGRectMake(8, CGRectGetHeight(self.frame)-0.5, CGRectGetWidth(self.frame)-16, 0.5);
    self.borderLayer.borderColor = [UIColor colorWithRed:0.8667 green:0.8667 blue:0.8667 alpha:1.0].CGColor;
    [self.layer addSublayer:self.borderLayer];
    
    if (self.image) {
        self.imageView.frame = CGRectInset(CGRectMake(0, 0, length, length), length*0.2, length*0.2);
        [self addSubview:self.imageView];
        
        self.textLabel.frame = CGRectMake(length+8, 0, CGRectGetWidth(rect)-length-8, length);
        [self addSubview:self.textLabel];
    } else {
        self.textLabel.frame = CGRectMake(8, 0, CGRectGetWidth(rect)-16, length);
        [self addSubview:self.textLabel];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.backgroundColor = self.activeColor;
    [self updateForColor:self.originalColor];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {    
    self.backgroundColor = self.originalColor;
    [self updateForColor:self.inactiveColor];
    
    NSDictionary *userInfo = @{@"index": @(self.index),
                               @"cell": self};
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CCDropDownMenuCellTapped" object:self userInfo:userInfo];
}

#pragma mark - Private methods
- (void)updateForColor:(UIColor *)color {
    self.textLabel.textColor = color;
    self.imageView.tintColor = color;
}

- (void)removeAllSubviews {
    for (UIView *subView in self.subviews) {
        [subView removeFromSuperview];
    }
    
    [self.borderLayer removeFromSuperlayer];
}

- (void)changeOriginalColor:(NSNotification *)notification {
    self.originalColor = [(CCDropDownMenuCell *)notification.object backgroundColor];
}

@end
