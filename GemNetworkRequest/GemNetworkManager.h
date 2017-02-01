//
//  GemNetworkManager.h
//  GemNetworkRequest
//
//  Created by GemShi on 2017/2/1.
//  Copyright © 2017年 GemShi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^Block)(id response);

@interface GemNetworkManager : NSObject

@property(nonatomic,copy) Block block;

/**基于Session*/
-(void)requestBySessionWithURL:(NSString *)urlStr Interface:(NSString *)interfaceStr KeyArray:(NSArray *)keyArr ValueArray:(NSArray *)valueArr NetWorkBlock:(Block)netWorkBlock GetOrPost:(BOOL)isGet;

/**基于Connection*/
-(void)requestByConnectionWithURL:(NSString *)urlStr Interface:(NSString *)interfaceStr KeyArray:(NSArray *)keyArr ValueArray:(NSArray *)valueArr NetWorkBlock:(Block)netWorkBlock GetOrPost:(BOOL)isGet;

/**判断网络连接状态*/
+(BOOL)isExistenceNetwork;

/**获取网络模式---返回值是字符串*/
+(NSString *)networkingStatesFromStatebar;

/**获取网络模式---返回值是NSInteger*/
+(NSInteger)networkingStatesNumber;

@end
