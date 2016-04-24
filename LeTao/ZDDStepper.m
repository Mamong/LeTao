//
//  ZDDStepper.m
//  LeTao
//
//  Created by marco on 4/9/16.
//  Copyright © 2016 ZDD. All rights reserved.
//

#import "ZDDStepper.h"

static const float kButtonWidth = 22.0f;

@implementation ZDDStepper

#pragma mark initialization
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        [self commonInit];
    }
    return self;
}

- (void)commonInit
{
    _value = 0.0f;
    _stepInterval = 1.0f;
    _minimum = 0.0f;
    _maximum = 100.0f;
    _hidesDecrementWhenMinimum = NO;
    _hidesIncrementWhenMaximum = NO;
    _buttonWidth = kButtonWidth;
    
    self.clipsToBounds = YES;
    [self setBorderWidth:1.0f];
    [self setCornerRadius:3.0];
    
    self.countField = [[UITextField alloc] init];
    self.countField.textAlignment = NSTextAlignmentCenter;
    self.countField.layer.borderWidth = 1.0f;
    [self.countField addTarget:self action:@selector(textFieldDidEndChanged:) forControlEvents:UIControlEventEditingChanged];
    self.countField.keyboardType = UIKeyboardTypeNumberPad;
    self.countField.text = @"1";
    [self addSubview:self.countField];
    
    self.incrementButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.incrementButton setTitle:@"+" forState:UIControlStateNormal];
    [self.incrementButton addTarget:self action:@selector(incrementButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.incrementButton];
    
    self.decrementButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.decrementButton setTitle:@"-" forState:UIControlStateNormal];
    [self.decrementButton addTarget:self action:@selector(decrementButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.decrementButton];
    
    UIColor *defaultColor = [UIColor colorWithRed:(79/255.0) green:(161/255.0) blue:(210/255.0) alpha:1.0];
    [self setBorderColor:defaultColor];
    [self setLabelTextColor:defaultColor];
    [self setButtonTextColor:defaultColor forState:UIControlStateNormal];
    
    [self setLabelFont:[UIFont fontWithName:@"Avernir-Roman" size:14.0f]];
    [self setButtonFont:[UIFont fontWithName:@"Avenir-Black" size:24.0f]];
}


#pragma mark render
- (void)layoutSubviews
{
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    
    self.countField.frame = CGRectMake(self.buttonWidth, 0, width - (self.buttonWidth * 2), height);
    self.incrementButton.frame = CGRectMake(width - self.buttonWidth, 0, self.buttonWidth, height);
    self.decrementButton.frame = CGRectMake(0, 0, self.buttonWidth, height);
    
    self.incrementButton.hidden = (self.hidesIncrementWhenMaximum && [self isMaximum]);
    self.decrementButton.hidden = (self.hidesDecrementWhenMinimum && [self isMinimum]);
}

- (CGSize)sizeThatFits:(CGSize)size
{
    if (CGSizeEqualToSize(size, CGSizeZero))
    {
        // if CGSizeZero, return ideal size
        CGSize labelSize = [self.countField sizeThatFits:size];
        return CGSizeMake(labelSize.width + (self.buttonWidth * 2), labelSize.height);
    }
    return size;
}


#pragma mark view customization
- (void)setBorderColor:(UIColor *)color
{
    self.layer.borderColor = color.CGColor;
    self.countField.layer.borderColor = color.CGColor;
}

- (void)setBorderWidth:(CGFloat)width
{
    self.layer.borderWidth = width;
}

- (void)setCornerRadius:(CGFloat)radius
{
    self.layer.cornerRadius = radius;
}

- (void)setLabelTextColor:(UIColor *)color
{
    self.countField.textColor = color;
}

- (void)setLabelFont:(UIFont *)font
{
    self.countField.font = font;
}

- (void)setButtonTextColor:(UIColor *)color forState:(UIControlState)state
{
    [self.incrementButton setTitleColor:color forState:state];
    [self.decrementButton setTitleColor:color forState:state];
}

- (void)setButtonFont:(UIFont *)font
{
    self.incrementButton.titleLabel.font = font;
    self.decrementButton.titleLabel.font = font;
}


#pragma mark setter
- (void)setValue:(float)value
{
    if (_value != value) {
        _value = value;
        self.countField.text = [NSString stringWithFormat:@"%d",(int)_value];
        if (self.hidesDecrementWhenMinimum)
        {
            self.decrementButton.hidden = [self isMinimum];
        }
        
        if (self.hidesIncrementWhenMaximum)
        {
            self.incrementButton.hidden = [self isMaximum];
        }
        
        //    if (self.valueChangedCallback)
        //    {
        //        self.valueChangedCallback(self, _value);
        //    }
        [self sendActionsForControlEvents:UIControlEventValueChanged];
    }
}


#pragma mark event handler
- (void)incrementButtonTapped:(id)sender
{
    if (self.value < self.maximum)
    {
        self.value += self.stepInterval;
//        if (self.incrementCallback)
//        {
//            self.incrementCallback(self, self.value);
//        }
    }
}

- (void)decrementButtonTapped:(id)sender
{
    if (self.value > self.minimum)
    {
        self.value -= self.stepInterval;
//        if (self.decrementCallback)
//        {
//            self.decrementCallback(self, self.value);
//        }
    }
}

#pragma mark UITextField Delegate
- (void)textFieldDidEndChanged:(UITextField *)textField
{
    self.value = textField.text.intValue;
}

#pragma mark private helpers
- (BOOL)isMinimum
{
    return self.value == self.minimum;
}

- (BOOL)isMaximum
{
    return self.value == self.maximum;
}

@end
