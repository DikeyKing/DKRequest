//
//  DKRequestInterface.h
//  DKRequest
//
//  Created by Dikey on 2019/6/11.
//  Copyright © 2019 Dikey. All rights reserved.
//

#ifndef DKRequestInterface_h
#define DKRequestInterface_h

#ifdef __cplusplus
extern "C" {
#endif
    typedef void (*DK_RequestCallback)(const char *downloadURL,
                                       const char *resultCode,
                                       const char *resultDescription,
                                       const void *data,
                                       int length,
                                       void *const user_data);
    
    /**
     https请求
     
     @param url URL，只支持https
     @param requestType 0 = POST，1 = get
     @param requestBody {key:value,key:value}
     @param user_data 可以为空
     @param finishCallback <#finishCallback description#>
     */
    void dk_Request(const char *url,
                    const char *requestType,
                     const char *requestBody,
                     void *const user_data,
                     DK_RequestCallback finishCallback
                     );
#ifdef __cplusplus
}
#endif

#endif /* DKRequestInterface_h */
