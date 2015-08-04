//
//  BottomView.m
//  DivorceApp
//
//  Created by Devrepublic on 4/29/14.
//  Copyright (c) 2014 DevRepublic. All rights reserved.
//

#import "RespondentFormView.h"
#import "AppDelegate.h"

@implementation RespondentFormView
@synthesize svQuestion;
@synthesize mDictAnswer;

-(void)loadRespondentFormWithID:(NSString *)campaignId
{
    mDictAnswer = [[NSMutableDictionary alloc] init];
    mDictAnswer[@"ip_address"] = @"111";
    
    NSString *url = @"http://devrepublic-projects.nl/development/say-it/public/APIs/respond-fields";
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:campaignId,@"campaign_id",nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardDidHideNotification object:nil];
    
    y = 40;
    
    [WebService requestWithUrl:url andParameters:dict response:^(id response, NSError *error)
     {
         if (response)
         {
             NSArray *arr = [response valueForKey:@"data"];
             
             if (!isEmpty1([[arr objectAtIndex:0] valueForKey:@"first_name_status"])) {
                 
                 UILabel *lblFname = [[UILabel alloc] initWithFrame:CGRectMake(0, y, 500, 30)];
                 lblFname.text = @"First Name";
                 lblFname.font = [UIFont fontWithName:@"OpenSans-Light" size:20];
                 [self addSubview:lblFname];
                 
                 y += 30;
                 
                 UITextField *txtFname= [[UITextField alloc] initWithFrame:CGRectMake(0, y, 974, 35)];
                 txtFname.borderStyle = UITextBorderStyleBezel;
                 txtFname.font = [UIFont fontWithName:@"OpenSans-Light" size:20];
                 txtFname.clearButtonMode = UITextFieldViewModeWhileEditing;
                 txtFname.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
                 txtFname.delegate = self;
                 txtFname.tag = 11;
                 txtFname.tintColor = [UIColor blueColor];
                 txtFname.backgroundColor = [UIColor whiteColor];
                 [svQuestion addSubview:txtFname];
                 
                 y += 45;
             }
             
             if (!isEmpty1([[arr objectAtIndex:0] valueForKey:@"last_name_status"])) {
                 
                 UILabel *lblLname = [[UILabel alloc] initWithFrame:CGRectMake(0, y, 500, 30)];
                 lblLname.text = @"Last Name";
                 lblLname.font = [UIFont fontWithName:@"OpenSans-Light" size:20];
                 [svQuestion addSubview:lblLname];
                 
                 y += 30;
                 
                 UITextField *txtLname= [[UITextField alloc] initWithFrame:CGRectMake(0, y, 974, 35)];
                 txtLname.borderStyle = UITextBorderStyleBezel;
                 txtLname.font = [UIFont fontWithName:@"OpenSans-Light" size:20];
                 txtLname.clearButtonMode = UITextFieldViewModeWhileEditing;
                 txtLname.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
                 txtLname.delegate = self;
                 txtLname.tag = 12;
                 txtLname.backgroundColor = [UIColor whiteColor];
                 txtLname.tintColor = [UIColor blueColor];
                 [svQuestion addSubview:txtLname];
                 
                 y += 45;
             }
             
             if (!isEmpty1([[arr objectAtIndex:0] valueForKey:@"phone_num_status"])) {
                 
                 UILabel *lblphone = [[UILabel alloc] initWithFrame:CGRectMake(0, y, 500, 30)];
                 lblphone.text = @"Phone Number";
                 lblphone.font = [UIFont fontWithName:@"OpenSans-Light" size:20];
                 [svQuestion addSubview:lblphone];
                 
                 y += 30;
                 
                 UITextField *txtphone = [[UITextField alloc] initWithFrame:CGRectMake(0, y, 974, 35)];
                 txtphone.borderStyle = UITextBorderStyleBezel;
                 txtphone.font = [UIFont fontWithName:@"OpenSans-Light" size:20];
                 txtphone.clearButtonMode = UITextFieldViewModeWhileEditing;
                 txtphone.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
                 txtphone.delegate = self;
                 txtphone.tag = 13;
                 txtphone.tintColor = [UIColor blueColor];
                 txtphone.backgroundColor = [UIColor whiteColor];
                 [svQuestion addSubview:txtphone];
                 
                 y += 45;
             }
             
             if (!isEmpty1([[arr objectAtIndex:0] valueForKey:@"mail_address_status"])) {
                 
                 UILabel *lbladdress = [[UILabel alloc] initWithFrame:CGRectMake(0, y, 500, 30)];
                 lbladdress.text = @"Mail Address";
                 lbladdress.font = [UIFont fontWithName:@"OpenSans-Light" size:20];
                 [svQuestion addSubview:lbladdress];
                 
                 y += 30;
                 
                 UITextField *txtaddress = [[UITextField alloc] initWithFrame:CGRectMake(0, y, 974, 35)];
                 txtaddress.borderStyle = UITextBorderStyleBezel;
                 txtaddress.font = [UIFont fontWithName:@"OpenSans-Light" size:20];
                 txtaddress.clearButtonMode = UITextFieldViewModeWhileEditing;
                 txtaddress.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
                 txtaddress.delegate = self;
                 txtaddress.tag = 14;
                 txtaddress.tintColor = [UIColor blueColor];
                 txtaddress.backgroundColor = [UIColor whiteColor];
                 [svQuestion addSubview:txtaddress];
                 
                 y += 45;
             }
             
             if (!isEmpty1([[arr objectAtIndex:0] valueForKey:@"company_name_status"])) {
                 
                 UILabel *lblcompany_name = [[UILabel alloc] initWithFrame:CGRectMake(0, y, 500, 30)];
                 lblcompany_name.text = @"Company Name";
                 lblcompany_name.font = [UIFont fontWithName:@"OpenSans-Light" size:20];
                 [svQuestion addSubview:lblcompany_name];
                 
                 y += 30;
                 
                 UITextField *txtcompany_name = [[UITextField alloc] initWithFrame:CGRectMake(0, y, 974, 35)];
                 txtcompany_name.borderStyle = UITextBorderStyleBezel;
                 txtcompany_name.font = [UIFont fontWithName:@"OpenSans-Light" size:20];
                 txtcompany_name.clearButtonMode = UITextFieldViewModeWhileEditing;
                 txtcompany_name.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
                 txtcompany_name.delegate = self;
                 txtcompany_name.tag = 15;
                 txtcompany_name.backgroundColor = [UIColor whiteColor];
                 txtcompany_name.tintColor = [UIColor blueColor];
                 [svQuestion addSubview:txtcompany_name];
                 
                 y += 45;
             }
             
             if (!isEmpty1([[arr objectAtIndex:0] valueForKey:@"address_status"])) {
                 
                 UILabel *lbladdress = [[UILabel alloc] initWithFrame:CGRectMake(0, y, 500, 30)];
                 lbladdress.text = @"Address";
                 lbladdress.font = [UIFont fontWithName:@"OpenSans-Light" size:20];
                 [svQuestion addSubview:lbladdress];
                 
                 y += 30;
                 
                 UITextField *txtaddress = [[UITextField alloc] initWithFrame:CGRectMake(0, y, 974, 35)];
                 txtaddress.borderStyle = UITextBorderStyleBezel;
                 txtaddress.font = [UIFont fontWithName:@"OpenSans-Light" size:20];
                 txtaddress.clearButtonMode = UITextFieldViewModeWhileEditing;
                 txtaddress.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
                 txtaddress.delegate = self;
                 txtaddress.tag = 16;
                 txtaddress.backgroundColor = [UIColor whiteColor];
                 txtaddress.tintColor = [UIColor blueColor];
                 [svQuestion addSubview:txtaddress];
                 
                 y += 45;
             }
             
             if (!isEmpty1([[arr objectAtIndex:0] valueForKey:@"zip_code_status"])) {
                 
                 UILabel *lblzip = [[UILabel alloc] initWithFrame:CGRectMake(0, y, 500, 30)];
                 lblzip.text = @"Zip Code";
                 lblzip.font = [UIFont fontWithName:@"OpenSans-Light" size:20];
                 [svQuestion addSubview:lblzip];
                 
                 y += 30;
                 
                 UITextField *txtzip = [[UITextField alloc] initWithFrame:CGRectMake(0, y, 974, 35)];
                 txtzip.borderStyle = UITextBorderStyleBezel;
                 txtzip.font = [UIFont fontWithName:@"OpenSans-Light" size:20];
                 txtzip.clearButtonMode = UITextFieldViewModeWhileEditing;
                 txtzip.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
                 txtzip.delegate = self;
                 txtzip.tag = 17;
                 txtzip.backgroundColor = [UIColor whiteColor];
                 txtzip.tintColor = [UIColor blueColor];
                 [svQuestion addSubview:txtzip];
                 
                 y += 45;
                 
             }
             
             if (!isEmpty1([[arr objectAtIndex:0] valueForKey:@"city_status"])) {
                 
                 UILabel *lblcity = [[UILabel alloc] initWithFrame:CGRectMake(0, y, 500, 30)];
                 lblcity.text = @"City";
                 lblcity.font = [UIFont fontWithName:@"OpenSans-Light" size:20];
                 [svQuestion addSubview:lblcity];
                 
                 y += 30;
                 
                 UITextField *txtcity = [[UITextField alloc] initWithFrame:CGRectMake(0, y, 974, 35)];
                 txtcity.borderStyle = UITextBorderStyleBezel;
                 txtcity.font = [UIFont fontWithName:@"OpenSans-Light" size:20];
                 txtcity.clearButtonMode = UITextFieldViewModeWhileEditing;
                 txtcity.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
                 txtcity.delegate = self;
                 txtcity.tag = 18;
                 txtcity.backgroundColor = [UIColor whiteColor];
                 txtcity.tintColor = [UIColor blueColor];
                 [svQuestion addSubview:txtcity];
                 
                 y += 45;
             }
             
             [svQuestion setContentSize:CGSizeMake(974, y)];
         }
     }];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (!isTop)
    {
        isTop = YES;
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDuration:0.25];
        
        self.superview.transform = CGAffineTransformMakeTranslation(0, -260);
        
        [UIView commitAnimations];
    }
}

-(void)keyboardWillHide:(NSNotification *)notificaiton
{
    isTop = NO;
    [UIView animateWithDuration:0.1f
                     animations:^{
                         self.superview.transform = CGAffineTransformMakeTranslation(0, 0);
                     }
                     completion:^(BOOL finished){
                     }
     ];
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    switch (textField.tag) {
        case 11:
        {
            mDictAnswer[@"first_name"] = textField.text;
        }
            break;
        case 12:
        {
            mDictAnswer[@"last_name"] = textField.text;
        }
            break;
        case 13:
        {
            mDictAnswer[@"phone_num"] = textField.text;
        }
            break;
        case 14:
        {
            mDictAnswer[@"mail_address"] = textField.text;
        }
            break;
        case 15:
        {
            mDictAnswer[@"company_name"] = textField.text;
        }
            break;
        case 16:
        {
            mDictAnswer[@"address"] = textField.text;
        }
            break;
        case 17:
        {
            mDictAnswer[@"zip_code"] = textField.text;
        }
            break;
        case 18:
        {
            mDictAnswer[@"city"] = textField.text;
        }
            break;
    }
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
}
@end
