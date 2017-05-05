//
//  BWBaseBackRequest.m
//  YTKNetwork
//
//  Created by Tony on 2016/10/22.
//  Copyright © 2016年 Tony. All rights reserved.
//

#import "BWBaseBackRequest.h"

@implementation BWBaseBackRequest
+ (void)GetRequestWithURL:(NSString *)url params:(NSDictionary *)param success:(SuccessBlock)success failure:(FailureBlock)failure
{
    BWGetNetWork *work = [[BWGetNetWork alloc] initWithParams:param URL:url];
    
    
    
    
    [work startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        success([NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingMutableContainers error:nil]);
        
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        failure([NSJSONSerialization JSONObjectWithData:request.responseData options:NSJSONReadingMutableContainers error:nil]);
    }];
    
}
@end
