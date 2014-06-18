//
//  ViewController.m
//  ZWProgressView
//
//  Created by Victor Ilisei on 6/17/14.
//  Copyright (c) 2014 Tech Genius. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    ZWProgressView *progressView = [[ZWProgressView alloc] initWithFrame:CGRectMake((self.view.bounds.size.width - 200) / 2.0f, (self.view.bounds.size.height - 50) / 2.0f, 200, 50) progressColor:[UIColor colorWithRed:0.0f green:0.0f blue:0.5f alpha:1.0f]];
    progressView.progress = 0.47f;
    
    [self.view addSubview:progressView];
}

@end