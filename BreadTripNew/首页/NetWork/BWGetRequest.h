//
//  BWGetRequest.h
//  YTKNetwork
//
//  Created by Tony on 2016/10/22.
//  Copyright © 2016年 Tony. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BWBaseBackRequest.h"
#import "ColleModel.h"
#import "DetailModel.h"
@interface BWGetRequest : NSObject

+ (void)GetRequestQBWithURL:(NSString *)url Params:(NSDictionary *)param success:(SuccessBlock)successback failure:(FailureBlock)failureback;

+ (void)GetRequestDetailWithURL:(NSString *)url Params:(NSDictionary *)param success:(SuccessBlock)successback failure:(FailureBlock)failureback;

@end
