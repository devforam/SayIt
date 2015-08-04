//
//  BottomView.m
//  DivorceApp
//
//  Created by Devrepublic on 4/29/14.
//  Copyright (c) 2014 DevRepublic. All rights reserved.
//

#import "MultipleAnsChoiceView.h"
#import "AppDelegate.h"
#import "UIButton+WebCache.h"

@implementation MultipleAnsChoiceView

-(void)loadAnswersWithID:(Question *)ques
{
    max_allowed_answers = [ques.max_allowed_answers intValue];
    
    ques.marrAns = [NSMutableArray array];
    
    self.question = ques;
    
    marrAnswers = [[NSMutableArray alloc] init];
    
    if ([ques.multi_ans_type intValue] == 3)
    {
        NSString *url = @"http://devrepublic-projects.nl/development/say-it/public/APIs/answer-options";
        
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:ques.id,@"question_id",nil];
        marrButtons = [[NSMutableArray alloc] init];
        [WebService requestWithUrl:url andParameters:dict response:^(id response, NSError *error)
         {
             int y = 0;
             NSArray *arr = [response valueForKey:@"data"];
             int tag = 0;
             for (NSDictionary *dAns in arr)
             {
                 UIView *vw = [[UIView alloc] initWithFrame:CGRectMake(10, y, 200, 35)];
                 [vw setTag:tag];
                 UIButton *btn = [[UIButton alloc] initWithFrame:vw.bounds];
                 [btn setTag:12];
                 [btn setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, 0)];
                 [btn setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 10)];
                 [btn setTitleColor:[UIColor darkGrayColor] forState:0];
                 [btn setImage:[UIImage imageNamed:@"radio0.png"] forState:0];
                 [btn setImage:[UIImage imageNamed:@"radio1.png"] forState:UIControlStateSelected];
                 [btn setTitle:[dAns valueForKey:@"options"] forState:0];
                 [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
                 [btn addTarget:self action:@selector(btnRadioPressed:) forControlEvents:UIControlEventTouchUpInside];
                 [vw addSubview:btn];
                 y += 30;
                 [self.svAnswers addSubview:vw];
                 tag++;
                 [marrAnswers addObject:dAns];
             }
             CGRect rect = [self.svAnswers frame];
             rect.size.height = y;
             [self.svAnswers setFrame:rect];
             
             rect = [self frame];
             rect.size.height = y+40;
             [self setFrame:rect];
             
         }];
    }
    else
    {
        NSString *url = @"http://devrepublic-projects.nl/development/say-it/public/APIs/answer-options";
        
        NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:ques.id,@"question_id",nil];
        marrButtons = [[NSMutableArray alloc] init];
        [WebService requestWithUrl:url andParameters:dict response:^(id response, NSError *error)
         {
             NSArray *arr = [response valueForKey:@"data"];
             int x = 0;
             int tag = 0;
             for (NSDictionary *dAns in arr)
             {
                 UIView *vw = [[UIView alloc] initWithFrame:CGRectMake(x, 0, 120, 155)];
                 [vw setTag:tag];
                 UIButton *btn = [[UIButton alloc] initWithFrame:vw.bounds];
                 
                 [btn setTag:99];
                 
                 if ([dAns valueForKey:@"question_icon"])
                 {
                     [btn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
                     [vw addSubview:btn];
                     
                     NSDictionary *dQues = [dAns valueForKey:@"question_icon"];
                     [btn sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",@"http://www.devrepublic-projects.nl/development/say-it/public/uploads/images/questionicons/icon/",[dQues valueForKey:@"icon_file"]]] forState:0];
                     [btn.layer setBorderWidth:0];
                     [btn.layer setBorderColor:[UIColor clearColor].CGColor];
                     [btn.layer setCornerRadius:3.0];
                     [btn.layer setMasksToBounds:YES];
                 }
                 else
                 {
                     [btn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 35, 0)];
                     [btn addTarget:self action:@selector(btnMultiplePressed:) forControlEvents:UIControlEventTouchUpInside];
                     [vw addSubview:btn];
                     
                     [btn sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",@"http://devrepublic-projects.nl/development/say-it/public/uploads/images/questions/icon/",[dAns valueForKey:@"options"]]] forState:0];
                     [btn setBackgroundColor:[UIColor clearColor]];
                     
                     UIImageView *ivCheck = [[UIImageView alloc] initWithFrame:CGRectMake(0, 125, 30, 30)];
                     [ivCheck setImage:[UIImage imageNamed:@"checkbox0.png"]];
                     [ivCheck setTag:17];
                     [vw addSubview:ivCheck];
                 }
                 [marrAnswers addObject:dAns];
                 tag++;
                 x += 135;
                 [self.svAnswers addSubview:vw];
             }
             [self.svAnswers setContentSize:CGSizeMake(x, 0)];
         }];
    }
}

-(void)btnPressed:(UIButton *)sender
{
    [self.question.marrAns removeAllObjects];
    NSDictionary *d = [marrAnswers objectAtIndex:sender.superview.tag];
    [self.question.marrAns addObject:[d valueForKey:@"id"]];
    
    for (int i = 0;i<[marrAnswers count];i++)
    {
        NSDictionary *d = [marrAnswers objectAtIndex:i];
        
        UIView *vw = (UIView *)[self.svAnswers viewWithTag:i];
        
        UIButton *btn = (UIButton *)[vw viewWithTag:99];
        
        if ([self.question.marrAns containsObject:[d valueForKey:@"id"]])
        {
            [btn.layer setBorderWidth:1.0];
            [btn.layer setBorderColor:[UIColor blackColor].CGColor];
        }
        else
        {
            [btn.layer setBorderWidth:0.0];
            [btn.layer setBorderColor:[UIColor clearColor].CGColor];
        }
    }
    
    NSLog(@"ans = %@", self.question.marrAns);
}

-(void)btnMultiplePressed:(UIButton *)sender
{
    UIView *vw = [sender superview];
    if ([[sender titleForState:UIControlStateApplication] isEqualToString:@"1"])
    {
        UIImageView *ivCheck = (UIImageView *)[vw viewWithTag:17];
        [ivCheck setImage:[UIImage imageNamed:@"checkbox0.png"]];
        [sender setTitle:@"0" forState:UIControlStateApplication];
        
        NSDictionary *d = [marrAnswers objectAtIndex:vw.tag];
        [self.question.marrAns removeObject:[d valueForKey:@"id"]];
    }
    else
    {
        if ([marrButtons count] >= max_allowed_answers)
        {
            UIImageView *ivCheck = (UIImageView *)[vw viewWithTag:17];
            [ivCheck setImage:[UIImage imageNamed:@"checkbox1.png"]];
            [sender setTitle:@"1" forState:UIControlStateApplication];
            
            UIButton *btn = [marrButtons firstObject];
            UIView *vw1 = [btn superview];
            UIImageView *ivCheck1 = (UIImageView *)[vw1 viewWithTag:17];
            [ivCheck1 setImage:[UIImage imageNamed:@"checkbox0.png"]];
            [btn setTitle:@"0" forState:UIControlStateApplication];
            
            
            [self.question.marrAns removeObjectAtIndex:0];
            
            NSDictionary *d = [marrAnswers objectAtIndex:vw.tag];
            [self.question.marrAns addObject:[d valueForKey:@"id"]];
            
            [marrButtons removeObjectAtIndex:0];
            [marrButtons addObject:sender];
        }
        else
        {
            UIImageView *ivCheck = (UIImageView *)[vw viewWithTag:17];
            [ivCheck setImage:[UIImage imageNamed:@"checkbox1.png"]];
            [sender setTitle:@"1" forState:UIControlStateApplication];
            [marrButtons addObject:sender];
            NSDictionary *d = [marrAnswers objectAtIndex:vw.tag];
            [self.question.marrAns addObject:[d valueForKey:@"id"]];
        }
    }
}

-(void)btnRadioPressed:(UIButton *)sender
{
    [self.question.marrAns removeAllObjects];
    for (UIView *vw in self.svAnswers.subviews)
    {
        UIButton *btn = (UIButton *)[vw viewWithTag:12];
        if ([btn isKindOfClass:[UIButton class]])
        {
            [btn setSelected:NO];
        }
    }
    UIView *vw = [sender superview];
    NSDictionary *d = [marrAnswers objectAtIndex:vw.tag];
    [self.question.marrAns addObject:[d valueForKey:@"id"]];
    [sender setSelected:YES];
}

@end
