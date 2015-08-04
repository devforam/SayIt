//
//  ViewController.h
//  SayIT
//
//  Created by Devrepublic on 7/7/15.
//  Copyright (c) 2015 DevRepublic. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebService.h"
#import "Data.h"
#import "MBProgressHUD.h"
#import "SingleInputLineView.h"
#import "MultipleInputLinesView.h"
#import "SliderView.h"
#import "MultipleAnsChoiceView.h"
#import "MultipleSingleImportRulesView.h"
#import "SubTitleView.h"
#import "TextsView.h"
#import "RespondentFormView.h"
#import "EndRestartView.h"
#import "AsyncImageView.h"

@interface QuestionsViewController : UIViewController <UITextFieldDelegate>
{
    int index, kind_id, ansType, y;
    BOOL isResForm, isTop, isMandatory;
    Section_Data *sectionData;
    NSMutableArray *marrTypes;
    
    IBOutlet UILabel *lblSecTitle;
    IBOutlet UIButton *btnBack, *btnNext;
    IBOutlet UIScrollView *svQuestion;
    IBOutlet AsyncImageView *ivSection;
    NSString *jsonString, *perSecString;
    
    RespondentFormView *respondentFormView;
}

@property (nonatomic, retain) Data *data;

@end

