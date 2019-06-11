//
//  ViewController.m
//  DKRequest
//
//  Created by Dikey on 2019/6/11.
//  Copyright © 2019 Dikey. All rights reserved.
//

#import "ViewController.h"
#import "DKRequest.h"
#import "DKRequestInterface.h"

@interface ViewController ()

@end

@implementation ViewController

void DK_requestFinishCallback(const char *downloadURL,
                              const char *resultCode,
                              const char *resultDescription,
                              const void *data,
                              int length,
                              void *const user_data)
{
    NSData *nsData = [NSData dataWithBytes:data length:length];
    NSString* stringData = [[NSString alloc] initWithData:nsData encoding:NSUTF8StringEncoding];
    NSLog(@"stringData is %@",stringData);
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    dk_Request(@"https://www.baidu.com/".UTF8String , @"GET".UTF8String , NULL, NULL, DK_requestFinishCallback);

    
    
    NSString *url = @"https://httpbin.org/post";
//    NSDictionary *publicParameter = @{
//                                      @"page_size":@10, //每次获取的个数
//                                      @"offset":@0
//                                      };
    NSString *jsonString = @"{\"page_size\":10,\"offset\":0}";
    dk_Request(url.UTF8String , @"POST".UTF8String , jsonString.UTF8String, NULL, DK_requestFinishCallback);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES completion:nil];
    });
}

@end
