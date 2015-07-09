//
//  JIMEnvironments.m
//  juan.im
//
//  Created by Juan Felipe Alvarez Saldarriaga on 9/29/14.
//  Copyright (c) 2014 juan.im. All rights reserved.
//

#import "JIMEnvironments.h"

@implementation JIMEnvironments

NSString *const kJIMEnvironmentsEnvironmentsFilename = @"Environments";
NSString *const kJIMEnvironmentsTargetBuildConfigurationName = @"JIMEnvironmentsTargetBuildConfigurationName";

+ (instancetype)sharedInstance
{
    static JIMEnvironments *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });

    return _sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (!self) return nil;

    NSString *envsFile = [[NSBundle mainBundle] pathForResource:kJIMEnvironmentsEnvironmentsFilename ofType:@"plist"];
    NSAssert(envsFile && [envsFile length] > 0, @"Environments.plist file not found");

    _environments = [NSDictionary dictionaryWithContentsOfFile:envsFile];
    _targetBuildConfigurationName = [[[NSBundle mainBundle] infoDictionary] objectForKey:kJIMEnvironmentsTargetBuildConfigurationName];
    _environment = _environments[_targetBuildConfigurationName];

    return self;
}

@end
