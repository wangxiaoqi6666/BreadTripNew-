//
//  BWGetNetWork.m
//  YTKNetwork
//
//  Created by Tony on 2016/10/22.
//  Copyright © 2016年 Tony. All rights reserved.
//

#import "BWGetNetWork.h"
#import <SVProgressHUD.h>
@implementation BWGetNetWork
{
    NSDictionary *_params;
    NSString *_url;
}
- (instancetype)initWithParams:(NSDictionary *)param URL:(NSString *)url
{
    self = [super init];
    if (self) {
        _params = param;
        _url = url;
        [SVProgressHUD showWithStatus:@"正在加载..."];
    }
    return self;
}



///  Called on the main thread after request succeeded.
- (void)requestCompleteFilter
{
    [SVProgressHUD showSuccessWithStatus:@"请求成功"];
    NSLog(@"请求成功, 提示框消失");
}

- (BOOL)statusCodeValidator
{
    return YES;
}
///  Called on the main thread when request failed.
- (void)requestFailedFilter
{
    [SVProgressHUD showErrorWithStatus:@"请求失败"];
    NSLog(@"请求失败, 提示失败");
}

///  The URL of request.
- (NSString *)requestUrl
{
    return _url;
}

- (NSTimeInterval)requestTimeoutInterval
{
    return 15;
}

///  Additional request argument.
- (nullable id)requestArgument
{
    return _params;
}

///  HTTP request method.
- (YTKRequestMethod)requestMethod
{
    return YTKRequestMethodGET;
}

///  Request serializer type.
- (YTKRequestSerializerType)requestSerializerType
{
    return YTKRequestSerializerTypeJSON;
}

///  Response serializer type. See also `responseObject`.
- (YTKResponseSerializerType)responseSerializerType
{
    return YTKResponseSerializerTypeJSON;
}



@end
