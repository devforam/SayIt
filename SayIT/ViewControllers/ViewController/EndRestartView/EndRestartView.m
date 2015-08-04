//
//  BottomView.m
//  DivorceApp
//
//  Created by Devrepublic on 4/29/14.
//  Copyright (c) 2014 DevRepublic. All rights reserved.
//

#import "EndRestartView.h"
#import "AppDelegate.h"

@implementation EndRestartView
@synthesize btnRestart;

-(void)loadView
{
    btnRestart.layer.cornerRadius = 3;
    currentValue = 60;
    shouldStopCountDown = NO;
    
    self.percentageDoughnut.textStyle               = MCPercentageDoughnutViewTextStyleUserDefined;
    self.percentageDoughnut.percentage              = 1;
    self.percentageDoughnut.linePercentage          = 0.15;
    self.percentageDoughnut.animationDuration       = 1;
    self.percentageDoughnut.showTextLabel           = YES;
    self.percentageDoughnut.animatesBegining        = YES;
    self.percentageDoughnut.textLabel.textColor     = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    self.percentageDoughnut.textLabel.text          = [NSString stringWithFormat:@"%d \n sec", currentValue];
    self.percentageDoughnut.textLabel.font          = [UIFont systemFontOfSize:1];
    self.percentageDoughnut.adjustsFontSizeAutomatically = YES;
    self.percentageDoughnut.fillColor = [UIColor redColor];
    
    [self startAutomaticCountDown:self];
}

- (void)startAutomaticCountDown:(id)sender
{
    shouldStopCountDown = NO;
    
    [MCUtil runOnAuxiliaryQueue:^{
        while (currentValue > 0 && !shouldStopCountDown)
        {
            [MCUtil runOnMainQueue:^{
                [self countDown:nil];
            }];
            [NSThread sleepForTimeInterval:1];
        }
    }];
}

- (void)countDown:(id)sender
{
    currentValue -= 1;
    self.percentageDoughnut.textLabel.numberOfLines = 3;
    self.percentageDoughnut.textLabel.text = [NSString stringWithFormat:@"%d \n sec", currentValue];
    self.percentageDoughnut.percentage = (float)currentValue/60.0;
    
    if (currentValue == 0) {
        [self btnRestartClicked:self];
    }
}

- (void)stopAutomaticCountDown:(id)sender
{
    shouldStopCountDown = YES;
}

-(IBAction)btnRestartClicked:(id)sender
{
   [[NSNotificationCenter defaultCenter] postNotificationName:@"popViewController" object:nil];
}

@end
