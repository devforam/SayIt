//
//  BottomView.h
//  DivorceApp
//
//  Created by Devrepublic on 4/29/14.
//  Copyright (c) 2014 DevRepublic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MultipleAnsChoiceView : UIView
{
    NSMutableArray *marrButtons;
    int max_allowed_answers;
    NSMutableArray *marrAnswers;
    //1 single selection with checkbox
    //2 single selection with border
}
@property (nonatomic, retain) Question *question;
@property (nonatomic, retain)  IBOutlet UILabel *lblQuestion;
@property (nonatomic, retain)  IBOutlet UIScrollView *svAnswers;

-(void)loadAnswersWithID:(Question *)ques;
@end
