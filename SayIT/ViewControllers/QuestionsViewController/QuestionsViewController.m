//
//  ViewController.m
//  SayIT
//
//  Created by Devrepublic on 7/7/15.
//  Copyright (c) 2015 DevRepublic. All rights reserved.
//

#import "QuestionsViewController.h"

@implementation QuestionsViewController
@synthesize data;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardDidHideNotification object:nil];
    
    UIProgressView *progressView = [[UIProgressView alloc] init];
    progressView.backgroundColor = [UIColor whiteColor];
    progressView.progressTintColor = [UIColor lightGrayColor];
    progressView.progress = 0.4;
    progressView.layer.borderColor = [[UIColor blackColor] CGColor];
    progressView.layer.borderWidth = 0.15;
    progressView.progressViewStyle = UIProgressViewStyleBar;
    [progressView setFrame:CGRectMake(0, 40, 1024, 50)];
    [progressView setTransform:CGAffineTransformMakeScale(1.0, 11.0)];
    [self.view addSubview:progressView];
    [self.view bringSubviewToFront:progressView];
    
    index = 0;
    
    sectionData = [data.section_data objectAtIndex:index];
    
    NSString *imgName = [NSString stringWithFormat:@"%@",sectionData.image];
    
    NSString *url = [NSString stringWithFormat:@"http://devrepublic-projects.nl/development/say-it/public/uploads/images/sections/size1/%@",imgName];
    
    ivSection.imageURL = [NSURL URLWithString:url];
    
    [self getTypes];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField.superview.frame.origin.y >= 250) {
        isTop = NO;
    }else{
        isTop = YES;
    }
    
    if (!isTop)
    {
        isTop = YES;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.25];
        
        svQuestion.transform = CGAffineTransformMakeTranslation(0, -310);
        
        [UIView commitAnimations];
    }
}

-(void)keyboardWillHide:(NSNotification *)notificaiton
{
    isTop = NO;
    [UIView animateWithDuration:0.1f
                     animations:^{
                         svQuestion.transform = CGAffineTransformMakeTranslation(0, 0);
                     }
                     completion:^(BOOL finished){
                     }
     ];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.1f
                     animations:^{
                         [self.view setTransform:CGAffineTransformMakeTranslation(0, 0)];
                     }
                     completion:^(BOOL finished){
                     }
     ];
}

-(void)getTypes
{
    marrTypes = [[NSMutableArray alloc] init];
    [WebService getRequestWithUrl:@"question-types" WithParameter:nil GetResponse:^(id response)
     {
         if (response)
         {
             NSArray *arr = [response valueForKey:@"data"];
             [marrTypes addObjectsFromArray:arr];
         }
         [self loadQuestionData];
     }];
}

-(void)loadQuestionData
{
    sectionData = [data.section_data objectAtIndex:index];
    
    NSString *imgName = [NSString stringWithFormat:@"%@",sectionData.image];
    NSString *url;
    
    if (imgName.length != 0) {
        url = [NSString stringWithFormat:@"http://devrepublic-projects.nl/development/say-it/public/uploads/images/sections/size1/%@",imgName];
    }else{
        url = [NSString stringWithFormat:@"http://devrepublic-projects.nl/development/say-it/public/uploads/images/sections/size1/%@",data.campaign_data.image];
    }
    
    ivSection.imageURL = [NSURL URLWithString:url];
    
    lblSecTitle.text = [NSString stringWithFormat:@"%@",sectionData.title];
    [self loadAnswerTypeWithkind_id];
}

-(void)loadAnswerTypeWithkind_id
{
    y = 0;
    for (UIView *vw in svQuestion.subviews)
    {
        [vw removeFromSuperview];
    }
    for (Question *quest in sectionData.questions)
    {
        for (NSDictionary *d in marrTypes)
        {
            if ([quest.kind_id intValue] == [[d valueForKey:@"id"] intValue])
            {
                if ([[d valueForKey:@"name"] isEqualToString:@"Enkele invoerregel"])
                {
                    ansType = 1;        // Single input line
                }
                else if ([[d valueForKey:@"name"] isEqualToString:@"Meerdere invoerregels"])
                {
                    ansType = 2;        // Multiple input lines
                }
                else if ([[d valueForKey:@"name"] isEqualToString:@"Schaal"])
                {
                    ansType = 3;        // scale
                }
                else if ([[d valueForKey:@"name"] isEqualToString:@"Meerdere antwoordkeuzes"])
                {
                    ansType = 4;        // Multiple answer choices
                }
                else if ([[d valueForKey:@"name"] isEqualToString:@"Meerdere enkele invoerregels"])
                {
                    ansType = 5;        // Multiple single import rules
                }
                else if ([[d valueForKey:@"name"] isEqualToString:@"Sub-title"])
                {
                    ansType = 6;
                }
                else if ([[d valueForKey:@"name"] isEqualToString:@"Texts"])
                {
                    ansType = 7;
                }
                else if ([[d valueForKey:@"name"] isEqualToString:@"Contact Form"])
                {
                    ansType = 8;
                }
            }
        }
        [self addAnswerViewWithType:ansType Question:quest];
    }
    [svQuestion setContentSize:CGSizeMake(0, y+60)];
}

//-(void)textFieldDidBeginEditing:(UITextField *)textField
//{
//    if (textField.superview.frame.origin.y >= 250) {
//        self.view.transform = CGAffineTransformMakeTranslation(0, -310);
//    }
//}

-(void)addAnswerViewWithType:(int)AnsType Question:(Question *)que
{
    switch (AnsType)
    {
        case 1:
        {
            SingleInputLineView *singleInputLineView = [[[NSBundle mainBundle] loadNibNamed:@"SingleInputLineView" owner:self options:nil] objectAtIndex:0];
            [singleInputLineView setFrame:CGRectMake(25, y, 974, 85)];
            
            if ([que.is_mandatory intValue] == 1) {
                NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@*",que.question_lbl]];
                [text addAttribute: NSForegroundColorAttributeName value: [UIColor redColor] range: NSMakeRange(0, text.length)];
                [text addAttribute: NSForegroundColorAttributeName value: [UIColor blackColor] range: NSMakeRange(0, text.length-1)];
                [singleInputLineView.lblQuestion setAttributedText: text];
                
            }else{
                singleInputLineView.lblQuestion.text = [NSString stringWithFormat:@"%@",que.question_lbl];
            }
            
            singleInputLineView.question = que;
            
            singleInputLineView.txtAns.text = que.answer;
            
            [svQuestion addSubview:singleInputLineView];
            y += 90;
            break;
        }
        case 2:
        {
            MultipleInputLinesView *multipleInputLinesView = [[[NSBundle mainBundle] loadNibNamed:@"MultipleInputLinesView" owner:self options:nil] objectAtIndex:0];
            [multipleInputLinesView setFrame:CGRectMake(25, y, 974, 80)];
            
            if ([que.is_mandatory intValue] == 1) {
                NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@*",que.question_lbl]];
                [text addAttribute: NSForegroundColorAttributeName value: [UIColor redColor] range: NSMakeRange(0, text.length)];
                [text addAttribute: NSForegroundColorAttributeName value: [UIColor blackColor] range: NSMakeRange(0, text.length-1)];
                [multipleInputLinesView.lblQuestion setAttributedText: text];
                
            }else{
                multipleInputLinesView.lblQuestion.text = [NSString stringWithFormat:@"%@",que.question_lbl];
            }
            
            [svQuestion addSubview:multipleInputLinesView];
            
            y+=85;
            
            break;
        }
        case 3:
        {
            SliderView *sliderView = [[[NSBundle mainBundle] loadNibNamed:@"SliderView" owner:self options:nil] objectAtIndex:0];
            [sliderView setFrame:CGRectMake(25, y, 974, 130)];
            
            if ([que.is_mandatory intValue] == 1) {
                NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@*",que.question_lbl]];
                [text addAttribute: NSForegroundColorAttributeName value: [UIColor redColor] range: NSMakeRange(0, text.length)];
                [text addAttribute: NSForegroundColorAttributeName value: [UIColor blackColor] range: NSMakeRange(0, text.length-1)];
                [sliderView.lblQuestion setAttributedText: text];
                
            }else{
                sliderView.lblQuestion.text = [NSString stringWithFormat:@"%@",que.question_lbl];
            }
            
            sliderView.slider.maximumTrackTintColor = [UIColor whiteColor];
            sliderView.slider.minimumValue = [que.min_scale intValue];
            sliderView.slider.maximumValue = [que.max_scale intValue];
            sliderView.lblMin.text = que.left_slide_lbl;
            sliderView.lblMax.text = que.right_slide_lbl;
            
            sliderView.question = que;
            NSLog(@"value = %f", [que.answer floatValue]);
            sliderView.slider.value = [que.answer floatValue];
            [sliderView.slider showPopoverAnimated:YES];
            
            sliderView.slider.popover.textLabel.text = [NSString stringWithFormat:@"%.2f", [que.answer floatValue]];
            [sliderView setStepperBtnWithMinValue:[que.min_scale intValue] andMaxValue:[que.max_scale intValue] steps:[que.scale_steps intValue] WithStepSize:[que.step_size intValue]];
            [svQuestion addSubview:sliderView];
            
            y += 135;
            
            break;
        }
        case 4:
        {
            MultipleAnsChoiceView *multipleAnsChoiceView = [[[NSBundle mainBundle] loadNibNamed:@"MultipleAnsChoiceView" owner:self options:nil] objectAtIndex:0];
            [multipleAnsChoiceView setFrame:CGRectMake(25, y, 974, 195)];
            
            if ([que.is_mandatory intValue] == 1) {
                NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@*",que.question_lbl]];
                [text addAttribute: NSForegroundColorAttributeName value: [UIColor redColor] range: NSMakeRange(0, text.length)];
                [text addAttribute: NSForegroundColorAttributeName value: [UIColor blackColor] range: NSMakeRange(0, text.length-1)];
                [multipleAnsChoiceView.lblQuestion setAttributedText: text];
                
            }else{
                multipleAnsChoiceView.lblQuestion.text = [NSString stringWithFormat:@"%@",que.question_lbl];
            }
            
//            multipleAnsChoiceView.question = que;
//            
//            NSLog(@"ans = %@", que.marrAns);
//            
//            if ([que.marrAns count] != 0) {
//                
//                if ([que.multi_ans_type intValue] == 3)
//                {
//                    // radio
//                }
//                else
//                {
//                    if ([[que.marrAns objectAtIndex:0]intValue]) {
//                        // selction
//                        
//                        for (int i = 0;i<[que.marrAns count];i++)
//                        {
//                            NSDictionary *d = [que.marrAns objectAtIndex:i];
//                            
//                            UIView *vw = (UIView *)[multipleAnsChoiceView.svAnswers viewWithTag:i];
//                            
//                            UIButton *btn = (UIButton *)[vw viewWithTag:99];
//                            
//                            if ([que.marrAns containsObject:[d valueForKey:@"id"]])
//                            {
//                                [btn.layer setBorderWidth:1.0];
//                                [btn.layer setBorderColor:[UIColor blackColor].CGColor];
//                            }
//                            else
//                            {
//                                [btn.layer setBorderWidth:0.0];
//                                [btn.layer setBorderColor:[UIColor clearColor].CGColor];
//                            }
//                        }
//                        
//                    }else{
//                        // checkbox
//                        
//                    }
//                }
//            }
            
            [multipleAnsChoiceView loadAnswersWithID:que];
            [svQuestion addSubview:multipleAnsChoiceView];
            
            //  y += multipleAnsChoiceView.frame.size.height+5;
            y += 200;
            
            break;
        }
        case 5:
        {
            MultipleSingleImportRulesView *multipleSingleImportRulesView = [[[NSBundle mainBundle] loadNibNamed:@"MultipleSingleImportRulesView" owner:self options:nil] objectAtIndex:0];
            [multipleSingleImportRulesView setFrame:CGRectMake(25, y, 974, 80)];
            
            if ([que.is_mandatory intValue] == 1) {
                NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@*",que.question_lbl]];
                [text addAttribute: NSForegroundColorAttributeName value: [UIColor redColor] range: NSMakeRange(0, text.length)];
                [text addAttribute: NSForegroundColorAttributeName value: [UIColor blackColor] range: NSMakeRange(0, text.length-1)];
                [multipleSingleImportRulesView.lblQuestion setAttributedText: text];
                
            }else{
                multipleSingleImportRulesView.lblQuestion.text = [NSString stringWithFormat:@"%@",que.question_lbl];
            }
            
            [svQuestion addSubview:multipleSingleImportRulesView];
            
            y += 85;
            break;
        }
        case 6:
        {
            SubTitleView *subTitle = [[[NSBundle mainBundle] loadNibNamed:@"SubTitleView" owner:self options:nil] objectAtIndex:0];
            [subTitle setFrame:CGRectMake(25, y, 974, 35)];
            
            if ([que.is_mandatory intValue] == 1) {
                NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@*",que.question_lbl]];
                [text addAttribute: NSForegroundColorAttributeName value: [UIColor redColor] range: NSMakeRange(0, text.length)];
                [text addAttribute: NSForegroundColorAttributeName value: [UIColor blackColor] range: NSMakeRange(0, text.length-1)];
                [subTitle.lblQuestion setAttributedText: text];
                
            }else{
                subTitle.lblQuestion.text = [NSString stringWithFormat:@"%@",que.question_lbl];
            }
            
            subTitle.lblQuestion.text = [subTitle.lblQuestion.text stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
            subTitle.lblQuestion.text = [subTitle.lblQuestion.text stringByReplacingOccurrencesOfString:@"</p>" withString:@""];
            subTitle.lblSubTitle.text = [NSString stringWithFormat:@""];
            [svQuestion addSubview:subTitle];
            
            y += 40;
            break;
        }
        case 7:
        {
            TextsView *textsView = [[[NSBundle mainBundle] loadNibNamed:@"TextsView" owner:self options:nil] objectAtIndex:0];
            [textsView setFrame:CGRectMake(25, y, 974, 40)];
            
            textsView.lblQuestion.text = [NSString stringWithFormat:@"%@",que.question_lbl];
            textsView.lblQuestion.text = [textsView.lblQuestion.text stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
            textsView.lblQuestion.text = [textsView.lblQuestion.text stringByReplacingOccurrencesOfString:@"</p>" withString:@""];
            if ([que.is_mandatory intValue] == 1) {
                NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:textsView.lblQuestion.text];
                [text addAttribute: NSForegroundColorAttributeName value: [UIColor redColor] range: NSMakeRange(0, text.length)];
                [text addAttribute: NSForegroundColorAttributeName value: [UIColor blackColor] range: NSMakeRange(0, text.length-1)];
                [textsView.lblQuestion setAttributedText: text];
                
            }else{
                textsView.lblQuestion.text = [NSString stringWithFormat:@"%@",que.question_lbl];
                textsView.lblQuestion.text = [textsView.lblQuestion.text stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
                textsView.lblQuestion.text = [textsView.lblQuestion.text stringByReplacingOccurrencesOfString:@"</p>" withString:@""];
            }
            
            textsView.tvAnswer.text = [NSString stringWithFormat:@""];
            [svQuestion addSubview:textsView];
            
            CGSize maximumLabelSize = CGSizeMake(974, CGFLOAT_MAX);
            
            CGRect textRect = [textsView.lblQuestion.text boundingRectWithSize:maximumLabelSize
                                                                       options:NSStringDrawingUsesLineFragmentOrigin
                                                                    attributes:@{NSFontAttributeName:textsView.lblQuestion.font}
                                                                       context:nil];
            
            CGRect rect = textsView.lblQuestion.frame;
            rect.size.height = textRect.size.height;
            [textsView.lblQuestion setFrame:rect];
            
            if (textRect.size.height > 35)
            {
                rect = textsView.frame;
                rect.size.height = textRect.size.height+35;
                [textsView setFrame:rect];
                
                y += (rect.size.height+5);
            }
            else
            {
                y += 45;
            }
            break;
        }
        case 8:
        {
            respondentFormView = [[[NSBundle mainBundle] loadNibNamed:@"RespondentFormView" owner:self options:nil] objectAtIndex:0];
            [respondentFormView setFrame:CGRectMake(25, y, 974, 600)];
            
            if ([que.is_mandatory intValue] == 1) {
                NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@*",que.question_lbl]];
                [text addAttribute: NSForegroundColorAttributeName value: [UIColor redColor] range: NSMakeRange(0, text.length)];
                [text addAttribute: NSForegroundColorAttributeName value: [UIColor blackColor] range: NSMakeRange(0, text.length-1)];
                [respondentFormView.lblQuestion setAttributedText: text];
                
            }else{
                respondentFormView.lblQuestion.text = [NSString stringWithFormat:@"%@",que.question_lbl];
            }
            
            [respondentFormView loadRespondentFormWithID:data.campaign_data.id];
            [svQuestion addSubview:respondentFormView];
            isResForm = YES;
            
            y += 605;
            
            break;
        }
    }
}

-(void)wrongCode
{
    DisplayAlertWithTitle(AppName, @"Ongelide code ingevoerd. Probeer het nog eens.")
}

-(IBAction)btnBackClicked:(id)sender
{
    if (index > 0)
    {
        index--;
        [btnNext setTitle:@"Next" forState:0];
        if (index == 0) {
            btnBack.hidden = YES;
        }
        [self loadQuestionData];
        [btnNext setEnabled:YES];
    }
    else
    {
        btnBack.enabled = NO;
        btnBack.hidden = YES;
    }
}

-(IBAction)btnNextClicked:(id)sender
{
    [self.view setTransform:CGAffineTransformMakeTranslation(0, 0)];
    [svQuestion setContentOffset:CGPointZero];
    [svQuestion setFrame:CGRectMake(0, 120, 1024, svQuestion.frame.size.height)];
    
    for (Question *quest in sectionData.questions)
    {
        NSLog(@"manditory = %@", quest.is_mandatory);
        if ([quest.is_mandatory intValue] == 1)
        {
            NSLog(@"ANS = %d || %d", [quest.marrAns count], [quest.answer length]);
            if ([quest.marrAns count] == 0 && [quest.answer length] == 0)
            {
                DisplayAlertWithTitle(AppName, @"Deze vraag is verplicht om te beantwoorden.")
                return;
            }
        }
    }
    
    if (index < [data.section_data count]-1)
    {
        if ([data.campaign_data.save_during_campaign intValue] == 1) {
            [self savePerSection];
        }
        
        index++;
        
        if (index == [data.section_data count]-1)
        {
            [btnNext setTitle:@"Finish" forState:0];
        }
        
        [self loadQuestionData];
        
        btnBack.hidden = NO;
        btnBack.enabled = YES;
    }
    else
    {
        btnNext.enabled = NO;
        btnBack.enabled = NO;
        
        EndRestartView *endRestartView = [[[NSBundle mainBundle] loadNibNamed:@"EndRestartView" owner:self options:nil] objectAtIndex:0];
        
        [endRestartView setFrame:CGRectMake(759, 67, 245, 187)];
        endRestartView.layer.borderColor = [[UIColor redColor]CGColor];
        endRestartView.layer.borderWidth = 2;
        endRestartView.layer.cornerRadius = 5;
        
        [endRestartView loadView];
        [self.view addSubview:endRestartView];
        
        if ([data.campaign_data.save_during_campaign intValue] == 1) {
            [self savePerSection];
        }else if ([data.campaign_data.save_during_campaign intValue] == 0) {
            [self finish];
        }
    }
    
    if (isResForm)
    {
        [self postRequestForSaveRespondent];
    }
}

-(void)savePerSection
{
    NSMutableArray *marrAnswers = [NSMutableArray array];
    
    NSMutableDictionary *mDictSection = [NSMutableDictionary dictionary];
    
    NSMutableArray *marrQuestions = [NSMutableArray array];
    
    mDictSection[@"section_id"] = sectionData.id;
    
    for (Question *quest in sectionData.questions)
    {
        NSMutableDictionary *mDictQuesAns = [NSMutableDictionary dictionary];
        mDictQuesAns[@"question_id"] = quest.id;
        
        if (quest.marrAns)
        {
            mDictQuesAns[@"answers"] = [NSMutableArray arrayWithArray:quest.marrAns];
        }else{
            NSLog(@"123 = %@",quest.answer);
            if (quest.answer)
            {
                mDictQuesAns[@"answers"] = [NSMutableArray arrayWithObject:quest.answer];
            }else{
                //                        if (quest.is_mandatory) {
                //                            DisplayAlertWithTitle(AppName, @"Deze vraag is verplicht om te beantwoorden.")
                //                        }
                mDictQuesAns[@"answers"] = [NSMutableArray arrayWithObject:@""];
            }
        }
        
        [marrQuestions addObject:mDictQuesAns];
    }
    mDictSection[@"questions"] = marrQuestions;
    
    [marrAnswers addObject:mDictSection];
    
    NSMutableDictionary *mDictMain = [NSMutableDictionary dictionary];
    NSMutableDictionary *mDictData = [NSMutableDictionary dictionary];
    mDictData[@"sections"] = marrAnswers;
    mDictMain[@"data"] = mDictData;
    NSLog(@"aa %@",mDictMain);
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:mDictMain
                                                       options:0
                                                         error:&error];
    perSecString = nil;
    if (!jsonData)
    {
        perSecString = @"";
    }
    else
    {
        perSecString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSLog(@"perSecString %@",perSecString);
    
    
    NSString *res_id = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"respondentId"]];
    NSString *url = @"http://devrepublic-projects.nl/development/say-it/public/APIs/save-answers";
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:perSecString,@"respondent_ans",data.campaign_data.id,@"campaign_id",data.campaign_data.account_id,@"account_id",res_id,@"respondent_id",nil];
    
    [WebService requestWithUrl:url andParameters:dict response:^(id response, NSError *error)
     {
         if ([[NSString stringWithFormat:@"%@",[response valueForKey:@"status"]] isEqualToString:@"1"])
         {
             NSLog(@"Success!");
         }
     }];
}

-(void)finish
{
    NSMutableArray *marrAnswers = [NSMutableArray array];
    
    for (Section_Data *section in data.section_data)
    {
        NSMutableDictionary *mDictSection = [NSMutableDictionary dictionary];
        
        NSMutableArray *marrQuestions = [NSMutableArray array];
        
        mDictSection[@"section_id"] = section.id;
        
        for (Question *quest in section.questions)
        {
            NSMutableDictionary *mDictQuesAns = [NSMutableDictionary dictionary];
            mDictQuesAns[@"question_id"] = quest.id;
            
            if (quest.marrAns)
            {
                mDictQuesAns[@"answers"] = [NSMutableArray arrayWithArray:quest.marrAns];
            }else{
                if (quest.answer)
                {
                    mDictQuesAns[@"answers"] = [NSMutableArray arrayWithObject:quest.answer];
                }else{
                    mDictQuesAns[@"answers"] = [NSMutableArray arrayWithObject:@""];
                }
            }
            
            [marrQuestions addObject:mDictQuesAns];
        }
        mDictSection[@"questions"] = marrQuestions;
        
        [marrAnswers addObject:mDictSection];
    }
    NSMutableDictionary *mDictMain = [NSMutableDictionary dictionary];
    NSMutableDictionary *mDictData = [NSMutableDictionary dictionary];
    mDictData[@"sections"] = marrAnswers;
    mDictMain[@"data"] = mDictData;
    NSLog(@"aa %@",mDictMain);
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:mDictMain
                                                       options:0
                                                         error:&error];
    jsonString = nil;
    if (!jsonData)
    {
        jsonString = @"";
    }
    else
    {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSLog(@"jsonString %@",jsonString);
    [self performSelector:@selector(postRequestForSaveAnswer) withObject:nil afterDelay:0.1];
}

-(void)postRequestForSaveRespondent
{
    NSString *res_id = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"respondentId"]];
    NSString *url = @"http://devrepublic-projects.nl/development/say-it/public/APIs/save-respondent";
    
    respondentFormView.mDictAnswer[@"campaign_id"] = data.campaign_data.id;
    respondentFormView.mDictAnswer[@"account_id"] = data.campaign_data.account_id;
    respondentFormView.mDictAnswer[@"respondent_id"] = res_id;
    NSLog(@"a %@",respondentFormView.mDictAnswer);
    
    [WebService requestWithUrl:url andParameters:respondentFormView.mDictAnswer response:^(id response, NSError *error)
     {
         if ([[NSString stringWithFormat:@"%@",[response valueForKey:@"status"]] isEqualToString:@"1"])
         {
             NSLog(@"Success!");
         }
     }];
}

-(void)postRequestForSaveAnswer
{
    NSString *res_id = [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"respondentId"]];
    NSString *url = @"http://devrepublic-projects.nl/development/say-it/public/APIs/save-answers";
    
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:jsonString,@"respondent_ans",data.campaign_data.id,@"campaign_id",data.campaign_data.account_id,@"account_id",res_id,@"respondent_id",nil];
    
    [WebService requestWithUrl:url andParameters:dict response:^(id response, NSError *error)
     {
         if ([[NSString stringWithFormat:@"%@",[response valueForKey:@"status"]] isEqualToString:@"1"])
         {
             NSLog(@"Success!");
         }
     }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
