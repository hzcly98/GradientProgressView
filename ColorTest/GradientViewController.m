//
//  GradientViewController.m
//  ColorTest
//
//  Created by hzc on 2018/4/25.
//  Copyright © 2018年 黄章成. All rights reserved.
//

#import "GradientViewController.h"
#import "GradientProgressView.h"

@interface GradientViewController ()
@property (nonatomic, strong) GradientProgressView *progressView;
@end

@implementation GradientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _progressView = [[GradientProgressView alloc] initWithFrame:CGRectMake(20, 100, self.view.bounds.size.width - 40, 20)];
    _progressView.backgroundColor = [UIColor lightGrayColor];
//    _progressView.progress = 0.7;
//    [_progressView setProgress:0.7];
    [_progressView setProgress:0.8 animated:YES];
    [self.view addSubview:_progressView];
    
//    [_progressView startAmimation];

}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [_progressView startAmimation];
}

@end
