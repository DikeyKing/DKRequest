//
//  DKRequest.m
//  DKRequest
//
//  Created by Dikey on 2019/6/11.
//  Copyright © 2019 Dikey. All rights reserved.
//

#import "DKRequest.h"

static DKRequest *request;

typedef void (*DK_RequestCallback)(const char *downloadURL,
                                   const char *resultCode,
                                   const char *resultDescription,
                                   const void *data,
                                   int length,
                                   void *const user_data);
@interface DKRequest()

@end

@implementation DKRequest

- (void)dealloc
{
    NSLog(@"DKRequest dealloc");
}

- (void)request:(NSString *)urlString
    requestType:(NSString *)type
           body:(NSString *)bodyString
       callback:(void(^)(NSError *error,id result))resultBlock
{
    // handle URL
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *url = [NSURL URLWithString:urlString];
    __block NSError *callbackError = nil;
    if (!url.absoluteString.length) {
        callbackError = [NSError errorWithDomain:@"DKRequest" code:1000 userInfo:@{NSLocalizedDescriptionKey:@"invalide url"}];
    }
    if (callbackError != nil) {
        resultBlock(callbackError,nil);
    }
    
    // generate request
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod= type;
    
    // handle body
    if (bodyString.length) {
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        NSData *data = [bodyString dataUsingEncoding:NSUTF8StringEncoding];
        id json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        request.HTTPBody = json;
    }
    
    // request
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *sessionDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        //result
        if (error) {
            callbackError = error;
        }
        resultBlock(callbackError,data);
    }];
    
    //start request
    [sessionDataTask resume];
}

void dk_Request(const char *url,
                const char *requestType,
                 const char *requestBody,
                 void *const user_data,
                 DK_RequestCallback finishCallback
                 )
{
    request = [DKRequest new];
    [request request:[NSString stringWithUTF8String:url] requestType:[NSString stringWithUTF8String:requestType] body:[NSString stringWithUTF8String:requestBody] callback:^(NSError *error, NSData *data) {
        finishCallback(url,
                       [NSString stringWithFormat:@"%ld",(long)error.code].UTF8String,
                       error.localizedDescription.UTF8String ,
                       data.bytes,
                       (int)data.length,
                       user_data
                       );
    }];
}

@end
