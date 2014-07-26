//
//  EFLocationScenarioRunner.h
//  MockLocationDemo
//
//  Created by Ivo Jansch on 25/07/14.
//  Copyright (c) 2014 Egeniq. All rights reserved.
//

#import <Foundation/Foundation.h>
@class EFLocationScenario;
@class EFMockLocationManager;
@class CLLocation;

@interface EFLocationScenarioRunner : NSObject

typedef void (^EFScenarioStatusBlock)(CLLocation *endedAt);

- (id)initWithMockLocationManager:(EFMockLocationManager *)locationManager;

- (void)runScenario:(EFLocationScenario *)scenario;
- (void)runScenario:(EFLocationScenario *)scenario onEnd:(EFScenarioStatusBlock)end;
- (void)runScenario:(EFLocationScenario *)scenario onStart:(EFScenarioStatusBlock) start onEnd:(EFScenarioStatusBlock)end;

@end
