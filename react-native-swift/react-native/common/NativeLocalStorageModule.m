//
//  NativeLocalStorageModule.m
//  react-native-swift
//
//  Created by Saiki on 2023/5/16.
//

#import "NativeLocalStorageModule.h"

@implementation NativeLocalStorageModule

RCT_EXPORT_MODULE(NativeLocalStorageModule)

RCT_EXPORT_METHOD(setItem:(NSString *)key value:(NSString *)value)
{
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


RCT_EXPORT_METHOD(getItem:(NSString *)key
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    if (!resolve) {
        return;
    }
    NSString *value =  [[NSUserDefaults standardUserDefaults] stringForKey:key];
    resolve(value);
}


RCT_EXPORT_METHOD(removeItem:(NSString *)key)
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
}


RCT_EXPORT_METHOD(clear)
{
    
}

@end
