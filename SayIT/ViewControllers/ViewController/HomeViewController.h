//
//  ViewController.h
//  SayIT
//
//  Created by Devrepublic on 7/7/15.
//  Copyright (c) 2015 DevRepublic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebService.h"
#import "QuestionsViewController.h"
#import "MBProgressHUD.h"
#import "AppDelegate.h"
#import "Data.h"

@interface HomeViewController : UIViewController
{
    IBOutlet UIView *vwCampaignCode;
    IBOutlet UITextField *t1,*t2,*t3,*t4,*t5,*t6;
    NSString *strCampaignCode;
    MBProgressHUD *Hud;
    QuestionsViewController *qVC;
    BOOL isTop;
    
    Data *data;
}

@end

