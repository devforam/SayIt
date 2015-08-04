//
//  BottomView.m
//  DivorceApp
//
//  Created by Devrepublic on 4/29/14.
//  Copyright (c) 2014 DevRepublic. All rights reserved.
//

#import "TextsView.h"
#import "AppDelegate.h"

@implementation TextsView 

-(void)textViewDidEndEditing:(UITextView *)textView
{
    self.question.answer = textView.text;
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
    }
    return YES;
}
@end
