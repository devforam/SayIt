//
//  WebService.h
//  DivorceApp
//
//  Created by Devrepublic on 5/1/14.
//  Copyright (c) 2014 DevRepublic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebService : NSObject

+(void)getRequestWithUrl:(NSString *)url WithParameter:(NSDictionary *)dictParams GetResponse:(void (^)(id response))getResponse;

+(void)getImageData:(NSString *)url WithParameter:(NSDictionary *)dictParams GetResponse:(void (^)(NSData *response))getResponse;

+(void)requestWithUrl:(NSString *)strURL andParameters:(NSDictionary *)mParameters response:(void (^)(id response, NSError *error))getResponse;

@end
