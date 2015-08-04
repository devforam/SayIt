//
//  BottomView.h
//  DivorceApp
//
//  Created by Devrepublic on 4/29/14.
//  Copyright (c) 2014 DevRepublic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NYSliderPopover.h"

@interface SliderView : UIView 
{
   
}

@property (nonatomic, retain) Question *question;
@property (nonatomic, retain)  IBOutlet UILabel *lblQuestion, *lblMin, *lblMax;
@property (nonatomic, retain)  IBOutlet UIView *vwStepper;
@property (nonatomic, retain)  IBOutlet NYSliderPopover *slider;

-(void)setStepperBtnWithMinValue:(float)min andMaxValue:(float)max steps:(int)steps WithStepSize:(int)width;

@end
