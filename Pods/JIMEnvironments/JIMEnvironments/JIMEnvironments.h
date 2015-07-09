//
//  JIMEnvironments.h
//  juan.im
//
//  Created by Juan Felipe Alvarez Saldarriaga on 9/29/14.
//  Copyright (c) 2014 juan.im. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JIMEnvironments : NSObject

extern NSString *const kJIMEnvironmentsEnvironmentsFilename;
extern NSString *const kJIMEnvironmentsTargetBuildConfigurationName;

@property (nonatomic, readonly, nonnull) NSDictionary *environments;
@property (nonatomic, readonly, nonnull) NSString *targetBuildConfigurationName;
@property (nonatomic, readonly, nonnull) NSDictionary *environment;

+ (instancetype)sharedInstance;

@end

NS_ASSUME_NONNULL_END
