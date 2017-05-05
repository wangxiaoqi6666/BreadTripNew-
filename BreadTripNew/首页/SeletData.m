//
//  SeletData.m
//  BreadTripNew
//
//  Created by 王小琪 on 17/1/8.
//  Copyright © 2017年 王小琪. All rights reserved.
//

#import "SeletData.h"
#import <AFNetworking.h>
#import "PremModel.h"

@implementation SeletData
+ (void)GET:(NSString *)url Parameter:(id)parameter Success:(SuccessBlock)success Failure:(FailureBlock)failure {
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
    [manager GET:url parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        PremModel *mode = [[PremModel alloc] initWithDictionary:responseObject[@"data"]];
        success(mode);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}
@end
