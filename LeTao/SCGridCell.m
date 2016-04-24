//
//  SCGridCell.m
//  demo
//
//  Created by 罗思成 on 16/2/26.
//  Copyright © 2016年 罗思成. All rights reserved.
//

#import "SCGridCell.h"

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@implementation SCGridCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
                       column:(NSArray *)column {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        NSMutableArray *tmpLabels = [[NSMutableArray alloc] init];
        for (NSString *columnName in column) {
            UILabel *column = [[UILabel alloc] initWithFrame:CGRectZero];
            column.text = columnName;
            column.font = [UIFont systemFontOfSize:14];
            column.adjustsFontSizeToFitWidth = YES;
            column.minimumScaleFactor = 0.5;
            column.numberOfLines = 0;
            column.lineBreakMode = NSLineBreakByCharWrapping;
            column.textAlignment = NSTextAlignmentLeft;
            
            [tmpLabels addObject:column];
        }
        
        self.labels = [tmpLabels copy];
    }
    
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
                       column:(NSArray *)column
                        ratio:(NSArray *)ratio {
    self.ratio = ratio;
    
    return [self initWithStyle:style reuseIdentifier:reuseIdentifier column:column];
}

#pragma - UI Work

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat startPosition = 0;
    CGFloat columnWidth = CGRectGetWidth(self.contentView.frame) / [self.labels count];
    CGFloat columnHeight = 50;
    
    NSInteger index = 0;
    for (UILabel *column in self.labels) {
        if (self.ratio) {
            columnWidth = [self.ratio[index] doubleValue] * CGRectGetWidth(self.contentView.frame);
            index++;
        }
        
        column.frame = CGRectMake(startPosition + 6, 6, columnWidth - 12, columnHeight - 12);
        
        UIImageView *border = [[UIImageView alloc] initWithFrame:CGRectMake(startPosition, 0, 1, columnHeight)];
        [border setImage:[self imageFromColor:UIColorFromRGB(0xdddddd)]];
        [self addSubview:border];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(actionTap:)];
        [column setUserInteractionEnabled:YES];
        [column addGestureRecognizer:tap];
        
        [self.contentView addSubview:column];
        startPosition += columnWidth;
    }
   
    UIImageView *border = [[UIImageView alloc] initWithFrame:CGRectMake(startPosition, 0, 1, columnHeight)];
    [border setImage:[self imageFromColor:UIColorFromRGB(0xdddddd)]];
    [self addSubview:border];
    
    UIImageView *topBorder = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.contentView.frame), 0.5)];
    UIImageView *bottomBorder = [[UIImageView alloc] initWithFrame:CGRectMake(0, columnHeight, CGRectGetWidth(self.contentView.frame), 0.5)];
    [topBorder setImage:[self imageFromColor:UIColorFromRGB(0xdddddd)]];
    [bottomBorder setImage:[self imageFromColor:UIColorFromRGB(0xdddddd)]];
    [self.contentView addSubview:topBorder];
    [self.contentView addSubview:bottomBorder];
}

#pragma - Touch Action

- (void)actionTap:(UITapGestureRecognizer *)tap {
    NSString *tapValue = ((UILabel *)tap.view).text;
    if ([self.delegate respondsToSelector:@selector(clickWithText:)]) {
        [self.delegate clickWithText:tapValue];
    }
}

#pragma - Image Work

- (UIImage *)imageFromColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
