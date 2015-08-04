//
//  BottomView.h
//  DivorceApp
//
//  Created by Devrepublic on 4/29/14.
//  Copyright (c) 2014 DevRepublic. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RespondentFormView : UIView <UITextFieldDelegate>
{
    int y;
    BOOL isTop;
}

@property (nonatomic, retain) NSMutableDictionary *mDictAnswer;
@property (nonatomic, retain)  IBOutlet UILabel *lblQuestion;
@property (nonatomic, retain)  IBOutlet UIScrollView *svQuestion;

-(void)loadRespondentFormWithID:(NSString *)campaignId;

@end
