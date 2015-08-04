//
//  BottomView.h
//  DivorceApp
//
//  Created by Devrepublic on 4/29/14.
//  Copyright (c) 2014 DevRepublic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCPercentageDoughnutView.h"
#import "HomeViewController.h"

@interface EndRestartView : UIView
{
    int currentValue;
    bool shouldStopCountDown;
}

@property (weak, nonatomic) IBOutlet MCPercentageDoughnutView *percentageDoughnut;
@property (nonatomic, retain)  IBOutlet UIButton *btnRestart;

-(void)loadView;

@end
