//
//  BottomView.h
//  DivorceApp
//
//  Created by Devrepublic on 4/29/14.
//  Copyright (c) 2014 DevRepublic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SingleInputLineView : UIView <UITextFieldDelegate>
{
   BOOL isTop;
}

@property (nonatomic, retain) Question *question;
@property (nonatomic, retain) IBOutlet UILabel *lblQuestion;
@property (nonatomic, retain) IBOutlet UITextField *txtAns;

@end
