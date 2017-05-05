//
//  BWGetRequest.m
//  YTKNetwork
//
//  Created by Tony on 2016/10/22.
//  Copyright © 2016年 Tony. All rights reserved.
//

#import "BWGetRequest.h"
#import "ColleModel.h"
#import "ColleModel_elements_type1.h"
@implementation BWGetRequest

+ (void)GetRequestQBWithURL:(NSString *)url Params:(NSDictionary *)param success:(SuccessBlock)successback failure:(FailureBlock)failureback
{
    [BWBaseBackRequest GetRequestWithURL:url params:param success:^(id success) {
        ColleModel *model = [ColleModel yy_modelWithJSON:success];
        NSMutableArray *arr = [NSMutableArray array];
        for (NSInteger i = 0; i < [success[@"data"][@"elements"][0][@"data"][0] count]; i++) {
            ColleModel_elements_type1 *type1 = [ColleModel_elements_type1 yy_modelWithDictionary:success[@"data"][@"elements"][0][@"data"][0][i]];
            [arr addObject:type1];
        }
        successback(@[model, arr]);
    } failure:^(id failure) {
        
    }];
}

+ (void)GetRequestDetailWithURL:(NSString *)url Params:(NSDictionary *)param success:(SuccessBlock)successback failure:(FailureBlock)failureback
{
    [BWBaseBackRequest GetRequestWithURL:url params:param success:^(id success) {
        DetailModel *model = [DetailModel yy_modelWithJSON:success];
        successback(model);
    } failure:^(id failure) {
        
    }];
}


@end
