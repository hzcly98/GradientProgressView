//
//  GradientProgressView.h
//  ColorTest
//
//  Created by hzc on 2018/4/25.
//  Copyright © 2018年 黄章成. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GradientProgressView : UIView

@property (nonatomic, assign) CGFloat progress;

- (void)startAmimation;

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated;

@end
