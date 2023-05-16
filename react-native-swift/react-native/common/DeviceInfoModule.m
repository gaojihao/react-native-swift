//
//  DeviceInfoModule.m
//  react-native-swift
//
//  Created by Saiki on 2023/5/16.
//

#import "DeviceInfoModule.h"

@implementation DeviceInfoModule

RCT_EXPORT_MODULE(DeviceInfoModule)

+ (BOOL)requiresMainQueueSetup
{
    return YES;
}

- (NSDictionary<NSString *, id> *)constantsToExport
{
    NSDictionary *constants = [self getConstants];
    return constants;
}

- (NSDictionary<NSString *, id> *)getConstants
{
    return @{
             @"osType": @"",
             @"sysVersion": @"",
             @"appPlatform": @"",
             @"appBuildVersion": @"",
             @"storeChanel": @"",
             @"appVersion": @"",
             @"buildVersion": @"",
             @"uuid": @"",
             @"deviceName": @"",
             @"udid": @""
            };
}

@end
