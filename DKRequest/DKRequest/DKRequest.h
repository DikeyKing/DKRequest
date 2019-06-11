//
//  DKRequest.h
//  DKRequest
//
//  Created by Dikey on 2019/6/11.
//  Copyright © 2019 Dikey. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DKRequest : NSObject

- (void)request:(NSString *)urlString
    requestType:(NSString *)type
           body:(id)body
       callback:(void(^)(NSError *error,id result))resultBlock;

@end
