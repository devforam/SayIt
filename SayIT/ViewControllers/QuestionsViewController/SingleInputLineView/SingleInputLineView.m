//
//  BottomView.m
//  DivorceApp
//
//  Created by Devrepublic on 4/29/14.
//  Copyright (c) 2014 DevRepublic. All rights reserved.
//

#import "SingleInputLineView.h"
#import "AppDelegate.h"

@implementation SingleInputLineView

-(void)loadView
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardDidHideNotification object:nil];
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
        
        self.superview.transform = CGAffineTransformMakeTranslation(0, -310);
        
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

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.question.answer = textField.text;
    
    [UIView animateWithDuration:0.1f
                     animations:^{
                         [self.superview setTransform:CGAffineTransformMakeTranslation(0, 0)];
                     }
                     completion:^(BOOL finished){
                     }
     ];
}

@end
