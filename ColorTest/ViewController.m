//
//  ViewController.m
//  ColorTest
//
//  Created by hzc on 2017/10/26.
//  Copyright © 2017年 黄章成. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *colorView;
@property (weak, nonatomic) IBOutlet UISlider *hueSlider;
@property (weak, nonatomic) IBOutlet UISlider *saturationSlider;
@property (weak, nonatomic) IBOutlet UISlider *brightnessSlider;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _colorView.backgroundColor = [UIColor colorWithHue:_hueSlider.value saturation:_saturationSlider.value brightness:_brightnessSlider.value alpha:1.0];
    
}

- (IBAction)hueChanged:(UISlider *)sender {
    _colorView.backgroundColor = [UIColor colorWithHue:sender.value saturation:_saturationSlider.value brightness:_brightnessSlider.value alpha:1.0];
}
- (IBAction)saturationChanged:(UISlider *)sender {
    _colorView.backgroundColor = [UIColor colorWithHue:_hueSlider.value saturation:sender.value brightness:_brightnessSlider.value alpha:1.0];
}
- (IBAction)brightnessChanged:(UISlider *)sender {
    _colorView.backgroundColor = [UIColor colorWithHue:_hueSlider.value saturation:_saturationSlider.value brightness:sender.value alpha:1.0];
}


@end
