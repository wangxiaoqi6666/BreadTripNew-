//
//  SeletData.h
//  BreadTripNew
//
//  Created by 王小琪 on 17/1/8.
//  Copyright © 2017年 王小琪. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SuccessBlock)(id success);
typedef void(^FailureBlock)(id failure);

@interface SeletData : NSObject

+ (void)GET:(NSString *)url Parameter:(id)parameter Success:(SuccessBlock)success Failure:(FailureBlock)failure;

@end
