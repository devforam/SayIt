//
//  ViewController.m
//  SayIT
//
//  Created by Devrepublic on 7/7/15.
//  Copyright (c) 2015 DevRepublic. All rights reserved.
//

#import "HomeViewController.h"

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    vwCampaignCode.layer.cornerRadius = 20;
    vwCampaignCode.layer.borderColor = [[UIColor blackColor] CGColor];
    vwCampaignCode.layer.borderWidth = 2;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardDidHideNotification object:nil];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popViewController) name:@"popViewController" object:nil];
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    if ([string length] == 0)
    {
        return YES;
    }
    else if((range.length + range.location > newString.length) || newString.length > 1)
    {
        return NO;
    }
    
    if (textField == t1) {
        t1.text = newString;
        [t2 becomeFirstResponder];
    }
    
    if (textField == t2) {
        t2.text = newString;
        [t3 becomeFirstResponder];
    }
    
    if (textField == t3) {
        t3.text = newString;
        [t4 becomeFirstResponder];
    }
    
    if (textField == t4) {
        t4.text = newString;
        [t5 becomeFirstResponder];
    }
    
    if (textField == t5) {
        t5.text = newString;
        [t6 becomeFirstResponder];
    }
    
    if (textField == t6) {
        t6.text = newString;
    }
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return (newLength > 1) ? NO : YES;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //  [textField resignFirstResponder];
    
    if (textField == t6) {
        strCampaignCode = [[[[[t1.text stringByAppendingString:t2.text]stringByAppendingString:t3.text]stringByAppendingString:t4.text]stringByAppendingString:t5.text]stringByAppendingString:t6.text];
    }
    
    [self postRequestForCampaignCode];
    
    //    [UIView beginAnimations:nil context:NULL];
    //    [UIView setAnimationDelegate:self];
    //    [UIView setAnimationDuration:0.5];
    
    //_VVlogin.transform = CGAffineTransformMakeTranslation(0, 0);
    
    //    [UIView commitAnimations];
    
    return YES;
}
 
-(void)postRequestForCampaignCode
{
    strCampaignCode = [[[[[t1.text stringByAppendingString:t2.text]stringByAppendingString:t3.text]stringByAppendingString:t4.text]stringByAppendingString:t5.text]stringByAppendingString:t6.text];
    
    strCampaignCode = @"xxxyyy";
    
    NSString *url = @"http://devrepublic-projects.nl/development/say-it/public/APIs/campaign";
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:strCampaignCode,@"campaign_code",nil];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [WebService requestWithUrl:url andParameters:dict response:^(id response, NSError *error)
     {
         if ([[NSString stringWithFormat:@"%@",[response valueForKey:@"status"]] isEqualToString:@"1"])
         {
             NSLog(@"Success!");
             
             NSDictionary *dData = [response valueForKey:@"data"];
             data = [[Data alloc] initWithDictionary:dData];
             
             NSDateFormatter *FormatDate = [[NSDateFormatter alloc] init];
             [FormatDate setLocale: [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] ];
             [FormatDate setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
             NSDate *date_from = [FormatDate dateFromString:data.campaign_data.date_from];
             NSDate *date_to = [FormatDate dateFromString:data.campaign_data.date_to];
             NSDate *currentDate = [NSDate date];
            
//             if (([date_from compare:currentDate] == NSOrderedAscending || [date_from compare:currentDate] == NSOrderedSame) && ([date_to compare:currentDate] == NSOrderedDescending || [date_to compare:currentDate] == NSOrderedSame))
//             {
                 [self postRequestForRespondent_id];
                 qVC = [storyboard instantiateViewControllerWithIdentifier:@"QuestionsViewController"];
                 qVC.data = data;
                 [self.navigationController pushViewController:qVC animated:YES];
//             }
//             else
//             {
//                 if ([date_from compare:currentDate] == NSOrderedDescending) {
//                    DisplayAlertWithTitle(AppName, @"This Campaign is not started yet!")
//                 }
//                 if ([date_to compare:currentDate] == NSOrderedAscending) {
//                     DisplayAlertWithTitle(AppName, @"This Campaign is already finished!")
//                 }
//                 t1.text = nil;
//                 t2.text = nil;
//                 t3.text = nil;
//                 t4.text = nil;
//                 t5.text = nil;
//                 t6.text = nil;
//             }
         }else{
             
             CABasicAnimation *animation =
             [CABasicAnimation animationWithKeyPath:@"position"];
             [animation setDuration:0.05];
             [animation setRepeatCount:5];
             [animation setAutoreverses:YES];
             [animation setFromValue:[NSValue valueWithCGPoint:
                                      CGPointMake([vwCampaignCode center].x - 20.0f, [vwCampaignCode center].y)]];
             [animation setToValue:[NSValue valueWithCGPoint:
                                    CGPointMake([vwCampaignCode center].x + 20.0f, [vwCampaignCode center].y)]];
             [[vwCampaignCode layer] addAnimation:animation forKey:@"position"];
             
             [self performSelector:@selector(wrongCode) withObject:nil afterDelay:0.5];
         }
         [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
     }];
}

-(void)postRequestForRespondent_id
{
    NSString *url = @"http://devrepublic-projects.nl/development/say-it/public/APIs/save-respondent";
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:data.campaign_data.id,@"campaign_id",data.campaign_data.account_id,@"account_id",nil];
    
    [WebService requestWithUrl:url andParameters:dict response:^(id response, NSError *error)
     {
         if ([[NSString stringWithFormat:@"%@",[response valueForKey:@"status"]] isEqualToString:@"1"])
         {
             NSLog(@"Success!");
             [[NSUserDefaults standardUserDefaults] setValue:[[response objectForKey:@"data"] valueForKey:@"respondent_id"] forKey:@"respondentId"];
             NSLog(@"123 = %@",[[NSUserDefaults standardUserDefaults] valueForKey:@"respondentId"]);
         }
     }];
}

-(void)popViewController
{
    [self postRequestForRespondent_id];
    qVC = [storyboard instantiateViewControllerWithIdentifier:@"QuestionsViewController"];
    qVC.data = data;
    [self.navigationController pushViewController:qVC animated:YES];
    
    t1.text = nil;
    t2.text = nil;
    t3.text = nil;
    t4.text = nil;
    t5.text = nil;
    t6.text = nil;
}

-(void)wrongCode
{
    DisplayAlertWithTitle(AppName, @"Ongeldige code ingevoerd. Probeer het nog eens.")
    t1.text = nil;
    t2.text = nil;
    t3.text = nil;
    t4.text = nil;
    t5.text = nil;
    t6.text = nil;
    [t1 becomeFirstResponder];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (!isTop)
    {
        isTop = YES;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.25];
        
        vwCampaignCode.transform = CGAffineTransformMakeTranslation(0, -150);
        
        [UIView commitAnimations];
    }
}

-(void)keyboardWillHide:(NSNotification *)notificaiton
{
    isTop = NO;
    [UIView animateWithDuration:0.3f
                     animations:^{
                         [vwCampaignCode setTransform:CGAffineTransformMakeTranslation(0, 0)];
                     }
                     completion:^(BOOL finished){
                     }
     ];
}

-(IBAction)btnOKClicked:(id)sender
{
    [t6 resignFirstResponder];
    [self postRequestForCampaignCode];
}

-(IBAction)btnCancelClicked:(id)sender
{
    t1.text = nil;
    t2.text = nil;
    t3.text = nil;
    t4.text = nil;
    t5.text = nil;
    t6.text = nil;
    [t1 becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
