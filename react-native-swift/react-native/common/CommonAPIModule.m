//
//  CommonAPIModule.m
//  react-native-swift
//
//  Created by Saiki on 2023/5/16.
//

#import "CommonAPIModule.h"

@implementation CommonAPIModule

RCT_EXPORT_MODULE(CommonAPIModule)

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

RCT_EXPORT_METHOD(back:(BOOL)needRefresh)
{
    UIViewController *vc = [[UIApplication sharedApplication].delegate window].rootViewController;
    if ([vc isKindOfClass:UINavigationController.class]) {
        UINavigationController *navCtrl = (UINavigationController *)vc;
        [navCtrl popViewControllerAnimated:YES];
    }
}

/// 打开原生页面
RCT_EXPORT_METHOD(jump:(NSString *)route)
{
    
}

/// 登录态失效
RCT_EXPORT_METHOD(tokenExpired)
{
    
}

@end
