//
//  ZWProgressView.h
//  
//
//  Created by Tech Genius on 6/17/14.
//
//

#import <UIKit/UIKit.h>

@interface ZWProgressView : UIView {
    NSLayoutConstraint *progressBarWidthConstraint;
    NSLayoutConstraint *progressBarMaskWidthConstraint;
}

@property (nonatomic, assign) CGFloat progress;
@property (nonatomic, strong) UIColor *normalTextColor;
@property (nonatomic, strong) UIColor *maskedTextColor;

@property (nonatomic, strong) UIView *container;
@property (nonatomic, strong) UIView *progressBar;
@property (nonatomic, strong) UILabel *progressLabel;
@property (nonatomic, strong) UILabel *maskedProgressLabel;
@property (nonatomic, strong) UIView *mask;

- (instancetype)initWithFrame:(CGRect)frame progressColor:(UIColor *)progressColor;
- (void)initViewWithProgressColor:(UIColor *)progressBarFillColor;
- (void)addAllConstraints;
- (void)setProgress:(CGFloat)progress;
- (void)updateMask;

@end