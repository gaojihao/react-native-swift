//
//  LoadingViewModule.m
//  react-native-swift
//
//  Created by Saiki on 2023/5/16.
//

#import "LoadingViewModule.h"

@implementation LoadingViewModule

RCT_EXPORT_MODULE(LoadingViewModule)

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

RCT_EXPORT_METHOD(showLoading)
{
    
}

RCT_EXPORT_METHOD(hideLoading)
{
    
}


RCT_REMAP_METHOD(showToast,
                 text:(NSString *)text
                 duration:(int)seconds)
{
}

@end
