//
//  BWBaseBackRequest.h
//  YTKNetwork
//
//  Created by Tony on 2016/10/22.
//  Copyright © 2016年 Tony. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BWGetNetWork.h"

typedef void(^SuccessBlock) (id success);
typedef void(^FailureBlock) (id failure);
@interface BWBaseBackRequest : NSObject

+ (void)GetRequestWithURL:(NSString *)url params:(NSDictionary *)param success:(SuccessBlock)success failure:(FailureBlock)failure;


@end
