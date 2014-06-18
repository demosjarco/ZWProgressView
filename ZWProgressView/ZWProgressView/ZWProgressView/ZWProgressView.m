//
//  ZWProgressView.m
//  
//
//  Created by Tech Genius on 6/17/14.
//
//

#import "ZWProgressView.h"

@implementation ZWProgressView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initView];
        [self addAllConstraints];
    }
    return self;
}

- (void)initView {
    self.layer.cornerRadius = 2.0f;
    self.backgroundColor = [UIColor colorWithRed:0.85f green:0.85f blue:0.85f alpha:1.0f];
    
    self.container = [[UIView alloc] init];
    self.container.layer.borderWidth = 1.0;
    self.container.layer.borderColor = [UIColor grayColor].CGColor;
    self.container.backgroundColor = [UIColor whiteColor];
    self.normalTextColor = [UIColor blackColor];
    self.container.layer.cornerRadius = 3.0;
    self.container.clipsToBounds = YES;
    
    self.progressBar = [[UIView alloc] init];
    self.progressBar.backgroundColor = [UIColor blueColor];
    self.maskedTextColor = [UIColor whiteColor];
    
    self.progressLabel = [[UILabel alloc] init];
    self.progressLabel.font = [UIFont fontWithName:@"Arial-BoldMT" size:30];
    self.progressLabel.textAlignment = NSTextAlignmentCenter;
    self.progressLabel.textColor = self.normalTextColor;
    self.progressLabel.clipsToBounds = YES;
    
    self.maskedProgressLabel = [[UILabel alloc] init];
    self.maskedProgressLabel.font = self.progressLabel.font;
    self.maskedProgressLabel.textAlignment = self.progressLabel.textAlignment;
    self.maskedProgressLabel.textColor = self.maskedTextColor;
    self.maskedProgressLabel.clipsToBounds = YES;
    
    self.mask = [[UIView alloc] init];
    
    [self.container addSubview:self.progressBar];
    [self.container addSubview:self.progressLabel];
    [self.container addSubview:self.maskedProgressLabel];
    [self.container addSubview:self.mask];
    
    [self addSubview:self.container];
}

- (void)addAllConstraints {
    self.container.translatesAutoresizingMaskIntoConstraints = NO;
    self.progressBar.translatesAutoresizingMaskIntoConstraints = NO;
    self.progressLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.maskedProgressLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.mask.translatesAutoresizingMaskIntoConstraints = NO;
    
    id views = @{@"container": self.container, @"progressBar": self.progressBar, @"progressLabel": self.progressLabel, @"maskedProgressLabel": self.maskedProgressLabel, @"mask": self.mask};
    
    // container constraint
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[container]-5-|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[container]-5-|" options:0 metrics:nil views:views]];
    
    // progressBar constraint
    
    [self.container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[progressBar]" options:0 metrics:nil views:views]];
    
    progressBarWidthConstraint = [NSLayoutConstraint constraintWithItem:self.progressBar attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0];
    
    [self.container addConstraint:progressBarWidthConstraint];
    
    [self.container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[progressBar]|" options:0 metrics:nil views:views]];
    
    // progressLabel constraint
    
    [self.container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[progressLabel]|" options:0 metrics:nil views:views]];
    [self.container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[progressLabel]|" options:0 metrics:nil views:views]];
    
    // maskedProgressLabel constraint
    [self.container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[maskedProgressLabel]|" options:0 metrics:nil views:views]];
    [self.container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[maskedProgressLabel]|" options:0 metrics:nil views:views]];
    
    // mask constraint
    [self.container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[mask]" options:0 metrics:nil views:views]];
    [self.container addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[mask]|" options:0 metrics:nil views:views]];
    
    progressBarMaskWidthConstraint = [NSLayoutConstraint constraintWithItem:self.mask attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0];
    
    [self.container addConstraint:progressBarMaskWidthConstraint];
}

- (void)setProgress:(CGFloat)progress {
    float percentage = progress * 100;
    
    NSString *strProgress = [[NSString alloc] initWithFormat:@"%.f%%", percentage];
    
    self.progressLabel.text = strProgress;
    self.maskedProgressLabel.text = strProgress;
    
    // ------------------------------------------------------------------
    // subtracting 10 pixel for the |-5-[progressBar]-5-| padding in
    // the constraint for the progresBar
    // ------------------------------------------------------------------
    progressBarWidthConstraint.constant = progress * (self.bounds.size.width - 10.0);
    progressBarMaskWidthConstraint.constant = progressBarWidthConstraint.constant;
    
    [self layoutIfNeeded];
    
    [self updateMask];
}

- (void)updateMask {
    // ------------------------------------------------------------------------
    // Masking code taken from:
    //
    // http://stackoverflow.com/questions/11391058/simply-mask-a-uiview-with-a-rectangle
    // ------------------------------------------------------------------------
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    CGRect maskRect = CGRectMake(0, 0, progressBarMaskWidthConstraint.constant, self.mask.bounds.size.height);
    
    CGPathRef path = CGPathCreateWithRect(maskRect, NULL);
    
    maskLayer.path = path;
    
    CGPathRelease(path);
    
    self.maskedProgressLabel.layer.mask = maskLayer;
}

- (void)setContainerBackgroundColor:(UIColor *)backgroundColor {
    self.container.backgroundColor = backgroundColor;
    @autoreleasepool {
        CGFloat r;
        CGFloat g;
        CGFloat b;
        CGFloat a;
        [self.container.backgroundColor getRed:&r green:&g blue:&b alpha:&a];
        if (r > 0.6f || g > 0.6f || b > 0.6f) {
            self.normalTextColor = [UIColor blackColor];
        } else {
            self.normalTextColor = [UIColor whiteColor];
        }
    }
}

- (void)setProgressBarFillColor:(UIColor *)fillColor {
    self.progressBar.backgroundColor = fillColor;
    @autoreleasepool {
        CGFloat r;
        CGFloat g;
        CGFloat b;
        CGFloat a;
        [self.progressBar.backgroundColor getRed:&r green:&g blue:&b alpha:&a];
        if (r > 0.6f || g > 0.6f || b > 0.6f) {
            self.maskedTextColor = [UIColor blackColor];
        } else {
            self.maskedTextColor = [UIColor whiteColor];
        }
    }
}

@end