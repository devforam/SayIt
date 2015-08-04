//
//  WebService.m
//  DivorceApp
//
//  Created by Devrepublic on 5/1/14.
//  Copyright (c) 2014 DevRepublic. All rights reserved.
//

#import "WebService.h"

@implementation WebService

+(void)requestWithUrl:(NSString *)strURL andParameters:(NSDictionary *)mParameters response:(void (^)(id response, NSError *error))getResponse
{
    
    NSMutableURLRequest *postRequest = [[NSMutableURLRequest alloc] init];
    [postRequest setURL:[NSURL URLWithString:[strURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    
    [postRequest setHTTPMethod:@"POST"];
    [postRequest setTimeoutInterval:60];
    
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    NSMutableData *body = [[NSMutableData alloc] init];
    
    [postRequest addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    for (NSString *theKey in [mParameters allKeys])
    {
        if ([[mParameters objectForKey:theKey] isKindOfClass:[NSData class]])
        {
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\";  filename=\"image.png\"\r\n",[theKey stringByReplacingOccurrencesOfString:@" " withString:@""]] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[mParameters objectForKey:theKey]];
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            
        }
        else
        {
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",theKey] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"%@\r\n",[mParameters objectForKey:theKey]] dataUsingEncoding:NSUTF8StringEncoding]];
        }
    }
    [postRequest setHTTPBody:body];
    [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
    [NSURLConnection sendAsynchronousRequest:postRequest queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
     {
         dispatch_async(dispatch_get_main_queue(), ^{
             [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
             
             if (!connectionError)
             {
                 __unused NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                 id responseObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                 getResponse(responseObject,nil);
             }
         });
     }];
}

+(void)getRequestWithUrl:(NSString *)url WithParameter:(NSDictionary *)dictParams GetResponse:(void (^)(id response))getResponse
{
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSString *getRequest = [NSString stringWithFormat:@"%@%@", WEBSERVICEPATH, url];
    
    NSString *str1 = @"";
    
    for (int i = 0; i<[[dictParams allKeys] count]; i++) {
        
        NSString *str = [dictParams valueForKey:[[dictParams allKeys] objectAtIndex:i]];
        
        if (i == 0)
        {
            str1 = [NSString stringWithFormat:@"?%@=%@",[[dictParams allKeys] objectAtIndex:i], str];
            
        }else{
            
            str1 = [NSString stringWithFormat:@"%@&%@=%@",str1, [[dictParams allKeys] objectAtIndex:i], str];
        }
    }
    
    getRequest = [NSString stringWithFormat:@"%@%@",getRequest,str1];
    
    [request setURL:[NSURL URLWithString:getRequest]];
    
    if(request)
    {
        [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
         
         {
             
             dispatch_async(dispatch_get_main_queue(), ^{
                 
                 if(connectionError)
                     
                 {
                     getResponse(nil);
                     
                 }else if (!data){
                     
                     getResponse(nil);
                     
                 }else{
                     
                     NSError *err = nil;
                     
                     id json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&err];
                     
                     if (err) {
                         
                         DisplayAlertWithTitle(@"", @"Geen antwoord van de server!");
                         
                         getResponse(nil);
                         
                     }else{
                         
                         getResponse(json);
                     }
                 }
             });
         }];
    }
}

//Image Saved
+(void)getImageData:(NSString *)url WithParameter:(NSDictionary *)dictParams GetResponse:(void (^)(NSData *response))getResponse
{
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    NSString *getRequest = [NSString stringWithFormat:@"%@%@", WEBSERVICEPATH, url];
    
    NSError *error = nil;
    NSData *jsonInputData = [NSJSONSerialization dataWithJSONObject:dictParams options:NSJSONWritingPrettyPrinted error:&error];
    getRequest = [NSString stringWithFormat:@"%@",getRequest];
    
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",getRequest]]];
    [request setHTTPMethod:@"POST"];
    //    [request setValue:[NSString stringWithFormat:@"%@",[UserDefaults valueForKey:@"username"]] forHTTPHeaderField:@"X-MMGR-USERNAME"];
    //    [request setValue:[NSString stringWithFormat:@"%@",[UserDefaults valueForKey:@"password"]] forHTTPHeaderField:@"X-MMGR-PASSWORD"];
    
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"appliction/json" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:jsonInputData];
    
    //[request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    // [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    //[request setHTTPBody:[jsonInputString dataUsingEncoding:NSUTF8StringEncoding]];
    
    //    [request setURL:[NSURL URLWithString:[getRequest stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
//    NSURLResponse *response;
//    NSError *err;
//    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&err];
//    id jsonResponseData = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:nil];
//    
    if(request)
    {
        [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
         
         {
             
             dispatch_async(dispatch_get_main_queue(), ^{
                 
                 if(connectionError)
                     
                 {
                     getResponse(nil);
                     
                 }else if (!data){
                     
                     getResponse(nil);
                     
                 }else{
                     
                     NSError *err = nil;
                     
                     
                     if (err) {
                         
                         
                         getResponse(nil);
                         
                     }else{
                         
                         getResponse(data);
                     }
                 }
             });
         }];
    }
}

+(NSString *)buildmsgPostString
{
    NSMutableString  *messegerecordIds = [NSMutableString stringWithString:@""];
    [messegerecordIds appendString:@"version="];
    [messegerecordIds appendString:[NSString stringWithFormat:@"%@",@"1"]];
    [messegerecordIds appendString:@"inspection="];
    [messegerecordIds appendString:[NSString stringWithFormat:@"%@",@"1"]];
    [messegerecordIds appendString:@"type="];
    [messegerecordIds appendString:[NSString stringWithFormat:@"%@",@"0"]];
    
    
    return messegerecordIds;
}

@end
