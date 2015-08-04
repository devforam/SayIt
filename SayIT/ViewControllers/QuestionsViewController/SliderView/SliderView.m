//
//  BottomView.m
//  DivorceApp
//
//  Created by Devrepublic on 4/29/14.
//  Copyright (c) 2014 DevRepublic. All rights reserved.
//

#import "SliderView.h"
#import "AppDelegate.h"

@implementation SliderView
@synthesize slider,vwStepper;

-(void)setSliderValues
{
    
}

-(IBAction)sliderAction:(UISlider *)sender
{
    float value = slider.value;
    slider.value = value;
    
    slider.popover.textLabel.text = [NSString stringWithFormat:@"%.2f", self.slider.value];
    
    self.question.answer = [NSString stringWithFormat:@"%f",slider.value];
}

-(void)setStepperBtnWithMinValue:(float)min andMaxValue:(float)max steps:(int)steps WithStepSize:(int)width
{
    int x = 0, y = 5, w = width;
    UIButton *btn;
    
    for (int i = 0; i < steps; i++) {
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame: CGRectMake(x, y, 100, 10)];
        [btn setTitle:@"|" forState:0];
        [btn setBackgroundColor:[UIColor grayColor]];
        [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 90, 0, 0)];
        [btn setTitleColor:[UIColor blackColor] forState:0];
        [btn setTag:i];
        [btn addTarget:self action:@selector(btnclick) forControlEvents:UIControlEventTouchUpInside];
        
        [vwStepper addSubview:btn];
        x += 105;
    }
}

-(void)btnclick
{
    NSLog(@"btn pressed");
}

@end
