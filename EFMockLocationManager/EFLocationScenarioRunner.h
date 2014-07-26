//
//  EFLocationScenarioRunner.h
//  MockLocationDemo
//
//  Created by Ivo Jansch on 25/07/14.
//  Copyright (c) 2014 Egeniq. All rights reserved.
//

#import <Foundation/Foundation.h>
@class EFLocationScenario;
@class CLLocationManager;
@class CLLocation;

@interface EFLocationScenarioRunner : NSObject

typedef void (^EFScenarioStatusBlock)(CLLocation *endedAt);

@property (nonatomic, strong, readonly) CLLocationManager *locationManager;

- (void)runScenario:(EFLocationScenario *)scenario;
- (void)runScenario:(EFLocationScenario *)scenario onEnd:(EFScenarioStatusBlock)end;
- (void)runScenario:(EFLocationScenario *)scenario onStart:(EFScenarioStatusBlock) start onEnd:(EFScenarioStatusBlock)end;
@end
