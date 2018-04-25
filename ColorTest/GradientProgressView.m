//
//  GradientProgressView.m
//  ColorTest
//
//  Created by hzc on 2018/4/25.
//  Copyright © 2018年 黄章成. All rights reserved.
//

#import "GradientProgressView.h"

@interface GradientProgressView()<CAAnimationDelegate>
@property (nonatomic, strong) CAGradientLayer *myLayer;
@property (nonatomic, strong) CALayer *maskLayer;
@property (nonatomic, assign) BOOL animated;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) CGFloat animatedProgress;
@end

@implementation GradientProgressView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        _myLayer = [CAGradientLayer layer];
        NSMutableArray *colors = [NSMutableArray array];
        for (int i = 0; i <= 360; i += 5) {
            UIColor *color = [UIColor colorWithHue:1.0 * i / 360 saturation:1.0 brightness:1.0 alpha:1.0];
            [colors addObject:(id)color.CGColor];
        }
        _myLayer.colors = colors;
//        _myLayer.colors = @[(id)[UIColor yellowColor].CGColor,(id)[UIColor greenColor].CGColor,(id)[UIColor redColor].CGColor];
        _myLayer.startPoint = CGPointMake(0.0, 0.5);
        _myLayer.endPoint = CGPointMake(1.0, 0.5);
        _myLayer.frame = self.bounds;
        [self.layer addSublayer:_myLayer];
        
        _maskLayer = [CALayer layer];
        _maskLayer.frame = CGRectMake(0, 0, 0, frame.size.height);
        _maskLayer.backgroundColor = [UIColor whiteColor].CGColor;
        _myLayer.mask = _maskLayer;
        
        
        // 如果实现了+ (Class)layerClass 方法，就用下面的也可以
//        CAGradientLayer *layer = (id)[self layer];
//        [layer setStartPoint:CGPointMake(0.0, 0.5)];
//        [layer setEndPoint:CGPointMake(1.0, 0.5)];
//
//        // Create the gradient colors using hues in 5 degree increments
//
//        NSMutableArray *colors = [NSMutableArray array];
//        for (NSInteger deg = 0; deg <= 360; deg += 5) {
//
//            UIColor *color;
//            color = [UIColor colorWithHue:1.0 * deg / 360.0
//                               saturation:1.0
//                               brightness:1.0
//                                    alpha:1.0];
//            [colors addObject:(id)[color CGColor]];
//        }
//        [layer setColors:[NSArray arrayWithArray:colors]];
    }
    return self;
    
}

// 也可以直接指定当前view的layer为CAGradientLayer，这样就不用再拥有一个CAGradientLayer *myLayer了。
//+ (Class)layerClass {
//    return [CAGradientLayer class];
//}

- (NSArray *)dealWithColors:(NSArray *)colors {
    
    NSMutableArray *muColors = [NSMutableArray arrayWithArray:colors];
    id lastColor = [muColors lastObject];
    [muColors removeLastObject];
    [muColors insertObject:lastColor atIndex:0];
    return muColors;
}

- (NSArray *)shiftColors:(NSArray *)colors {
    
    // Moves the last item in the array to the front
    // shifting all the other elements.
    
    NSMutableArray *mutable = [colors mutableCopy];
    id last = [mutable lastObject];
    [mutable removeLastObject];
    [mutable insertObject:last atIndex:0];
    return [NSArray arrayWithArray:mutable];
}

- (void)startAmimation {
    
    NSArray *fromColors = _myLayer.colors;
    NSArray *toColors = [self dealWithColors:_myLayer.colors];
    _myLayer.colors = toColors;
    
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"colors"];
    anim.fromValue = fromColors;
    anim.toValue = toColors;
    anim.fillMode = kCAFillModeForwards;
    anim.removedOnCompletion = YES;
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];;
    anim.duration = 0.06;
    anim.delegate = self;
    [_myLayer addAnimation:anim forKey:@"animateGradient"];
    
    
//    CAGradientLayer *layer = (id)[self layer];
//    NSArray *fromColors = [layer colors];
//    NSArray *toColors = [self shiftColors:fromColors];
//    [layer setColors:toColors];
    
//    CABasicAnimation *animation;
//    animation = [CABasicAnimation animationWithKeyPath:@"colors"];
//    [animation setFromValue:fromColors];
//    [animation setToValue:toColors];
//    [animation setDuration:0.08];
//    [animation setRemovedOnCompletion:YES];
//    [animation setFillMode:kCAFillModeForwards];
//    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
//    [animation setDelegate:self];
    
    // Add the animation to our layer
    
//    [layer addAnimation:animation forKey:@"animateGradient"];
}
- (void)animationDidStop:(CAAnimation *)animation finished:(BOOL)flag {
    
        [self startAmimation];
}

- (void)setProgress:(CGFloat)progress {
    
    _progress = progress;
    
    [self setNeedsLayout];
    
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated {
    
    _progress = progress;
    
    _animated = animated;
    
    if (animated) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.2 repeats:YES block:^(NSTimer * _Nonnull timer) {
            _animatedProgress += 0.1 ;
            if (_animatedProgress <= _progress) {
                [self setNeedsLayout];
            }else{
                _animatedProgress = _progress;
                [_timer invalidate];
            }
        }];
    }else{
        [self setNeedsLayout];
    }
}

- (void)layoutSubviews {
        
    CGRect maskFrame = _maskLayer.frame;
    maskFrame.size.width = CGRectGetWidth(self.bounds) * (_animated ? _animatedProgress : _progress);
    _maskLayer.frame = maskFrame;
    

}


@end
