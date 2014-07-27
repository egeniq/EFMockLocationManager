//
//  EFLocationScenario-Internal.h
//  MockLocationDemo
//
//  Created by Ivo Jansch on 25/07/14.
//  Copyright (c) 2014 Egeniq. All rights reserved.
//

#import <EFLocationSCenario.h>
#import <CoreLocation/CLLocation.h>
#import <CoreLocation/CLHeading.h>

@protocol EFLocationScenarioInternalDelegate <NSObject>

- (void)scenario:(EFLocationScenario *)scenario movedToLocation:(CLLocation *)location;
- (void)scenario:(EFLocationScenario *)scenario didStartAt:(CLLocation *)location;
- (void)scenario:(EFLocationScenario *)scenario didEndAt:(CLLocation *)location;

@end

@interface EFLocationScenario ()

@property (nonatomic, weak) id<EFLocationScenarioInternalDelegate>internalDelegate;

- (CLLocation *)locationAtTimeInterval:(NSTimeInterval)interval;
- (CLHeading *)headingAtTimeInterval:(NSTimeInterval)interval;
- (BOOL)shouldStop;

@end