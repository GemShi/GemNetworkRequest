//
//  GemNetworkManager.m
//  GemNetworkRequest
//
//  Created by GemShi on 2017/2/1.
//  Copyright © 2017年 GemShi. All rights reserved.
//

#import "GemNetworkManager.h"
#import "Reachability.h"
#import <objc/message.h>

@interface GemNetworkManager()
@property(nonatomic,copy)NSMutableString *requestStr;
@property(nonatomic,copy)NSMutableString *parameterStr;
@end

@implementation GemNetworkManager

//懒加载
-(NSMutableString *)requestStr
{
    if (_requestStr == nil) {
        _requestStr = [[NSMutableString alloc]init];
    }
    return _requestStr;
}

-(NSMutableString *)parameterStr
{
    if (_parameterStr == nil) {
        _parameterStr = [[NSMutableString alloc]init];
    }
    return _parameterStr;
}

//网络请求方法
-(void)requestBySessionWithURL:(NSString *)urlStr Interface:(NSString *)interfaceStr KeyArray:(NSArray *)keyArr ValueArray:(NSArray *)valueArr NetWorkBlock:(Block)netWorkBlock GetOrPost:(BOOL)isGet
{
    //字符串拼接
    self.block = netWorkBlock;
    if (isGet) {
        //get
        [self.requestStr appendFormat:@"%@%@?",urlStr,interfaceStr];
        for (int i = 0; i < keyArr.count; i++) {
            [self.requestStr appendFormat:@"%@=%@",keyArr[i],valueArr[i]];
            if (i < keyArr.count - 1) {
                [self.requestStr appendString:@"&"];
            }
        }
    }else{
        //post
        [self.requestStr appendFormat:@"%@%@",urlStr,interfaceStr];
        for (int i = 0; i < keyArr.count; i++) {
            [self.parameterStr appendFormat:@"%@=%@",keyArr[i],valueArr[i]];
            if (i < keyArr.count - 1) {
                [self.parameterStr appendString:@"&"];
            }
        }
    }
    
    //将str转为url
    NSURL *url = [NSURL URLWithString:self.requestStr];
    //设置请求对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //请求超时
    request.timeoutInterval = 10;
    //请求头
    [request addValue:@"URLSession" forHTTPHeaderField:@"X-Requested-With"];
    if (!isGet) {
        //POST
        request.HTTPMethod = @"POST";
        //请求体
        request.HTTPBody = [self.parameterStr dataUsingEncoding:NSUTF8StringEncoding];
    }
    
    //session对象
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            id obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            self.block(obj);
        }else{
            self.block(@{@"requestError":error.localizedDescription});
        }
    }];
    //启动任务
    [task resume];
}

-(void)requestByConnectionWithURL:(NSString *)urlStr Interface:(NSString *)interfaceStr KeyArray:(NSArray *)keyArr ValueArray:(NSArray *)valueArr NetWorkBlock:(Block)netWorkBlock GetOrPost:(BOOL)isGet
{
    self.block = netWorkBlock;
    if (isGet) {
        //get
        [self.requestStr appendFormat:@"%@%@?",urlStr,interfaceStr];
        for (int i = 0; i < keyArr.count; i++) {
            [self.requestStr appendFormat:@"%@=%@",keyArr[i],valueArr[i]];
            if (i < keyArr.count - 1) {
                [self.requestStr appendString:@"&"];
            }
        }
    }else{
        //post
        [self.requestStr appendFormat:@"%@%@",urlStr,interfaceStr];
        for (int i = 0; i < keyArr.count; i++) {
            [self.parameterStr appendFormat:@"%@=%@",keyArr[i],valueArr[i]];
            if (i < keyArr.count - 1) {
                [self.parameterStr appendString:@"&"];
            }
        }
    }
    
    NSURL *url = [NSURL URLWithString:self.requestStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    request.timeoutInterval = 10;
    [request addValue:@"URLCconnection" forHTTPHeaderField:@"X-Requested-With"];
    if (!isGet) {
        request.HTTPMethod = @"POST";
        request.HTTPBody = [self.parameterStr dataUsingEncoding:NSUTF8StringEncoding];
    }
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue  currentQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        if (!connectionError) {
            id obj = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            self.block(obj);
        }else{
            self.block(@{@"requestError":connectionError.localizedDescription});
        }
        
    }];
}

//判断网络状态
+(BOOL)isExistenceNetwork
{
    BOOL isExist;
    Reachability *reacha = [Reachability reachabilityWithHostName:@"www.apple.com"];
    switch ([reacha currentReachabilityStatus]) {
        case NotReachable:
            NSLog(@"没有网络");
            isExist = NO;
            break;
        case ReachableViaWiFi:
            NSLog(@"无线网络");
            isExist = YES;
            break;
        case ReachableViaWWAN:
            NSLog(@"数据或其他连接");
            isExist = YES;
            break;
        default:
            break;
    }
    return isExist;
}

+(NSString *)networkingStatesFromStatebar
{
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *views = [[[app valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    
    int type = 0;
    for (id view in views) {
        if ([view isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
            type = [[view valueForKeyPath:@"dataNetworkType"] intValue];
        }
    }
    
    NSString *statusStr = @"wifi";
    switch (type) {
        case 0:
            statusStr = @"notReachable";
            break;
        case 1:
            statusStr = @"2G";
            break;
        case 2:
            statusStr = @"3G";
            break;
        case 3:
            statusStr = @"4G";
            break;
        case 4:
            statusStr = @"LTE";
            break;
        case 5:
            statusStr = @"wifi";
            break;
        default:
            break;
    }
    return statusStr;
}

+(NSInteger)networkingStatesNumber
{
    UIApplication *app = [UIApplication sharedApplication];
    NSInteger type = 0;
    NSArray *statusForeground = [[[app valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    for (id child in statusForeground) {
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            type = [[child valueForKeyPath:@"dataNetworkType"] integerValue];
        }
    }
    return type;
}

@end
