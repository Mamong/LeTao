//
//  ZDDStepper.h
//  LeTao
//
//  Created by marco on 4/9/16.
//  Copyright © 2016 ZDD. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface ZDDStepper : UIControl<UITextFieldDelegate>

@property(nonatomic, strong) UITextField *countField;
@property(nonatomic, strong) UIColor *labelColor;
@property(nonatomic, strong) UIButton *incrementButton;
@property(nonatomic, strong) UIButton *decrementButton;
//@property(nonatomic, assign) int *format;


@property(nonatomic) float value; // default: 0.0
@property(nonatomic) float stepInterval; // default: 1.0
@property(nonatomic) float minimum; // default: 0.0
@property(nonatomic) float maximum; // default: 100.0
@property(nonatomic) BOOL hidesDecrementWhenMinimum; // default: NO
@property(nonatomic) BOOL hidesIncrementWhenMaximum; // default: NO
@property(nonatomic) CGFloat buttonWidth; // default: 44.0f




@end
