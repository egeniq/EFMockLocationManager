//
//  EFLocationScenario.m
//  MockLocationDemo
//
//  Created by Ivo Jansch on 25/07/14.
//  Copyright (c) 2014 Egeniq. All rights reserved.
//

#import <EFLocationScenario.h>
#import <EFLocationScenario-Internal.h>

@interface EFLocationScenario ()
@property (nonatomic, strong, readwrite) CLLocation *currentLocation;
@property (nonatomic, strong, readwrite) CLHeading *currentHeading;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NSDate *startedAt;
@end

@implementation EFLocationScenario

- (void)start {
    self.startedAt = [NSDate date];
    self.currentLocation = [self locationAtTimeInterval:0];
    [self propagateLocation];
    [self.internalDelegate scenario:self didStartAt:self.currentLocation];
    [self.delegate scenario:self didStartAt:self.currentLocation];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(updateLocation) userInfo:nil repeats:YES];
}

- (void)updateLocation {
    // todo, maybe update location.accuracy, speed etc. too.
    NSTimeInterval elapsed = [[NSDate date] timeIntervalSinceDate:self.startedAt];
    self.currentLocation = [self locationAtTimeInterval:elapsed];
    [self propagateLocation];
    if ([self shouldStop]) {
        [self stop];
        [self.internalDelegate scenario:self didEndAt:self.currentLocation];
        [self.delegate scenario:self didEndAt:self.currentLocation];
    }
}

- (void)stop {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)dealloc {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)propagateLocation {
    [self.internalDelegate scenario:self movedToLocation:self.currentLocation];
}

// Should be overriden by derived scenarios. The default just doesn't ever move.
- (CLLocation *)locationAtTimeInterval:(NSTimeInterval)interval {
    return self.currentLocation;
}

// Should be overriden
- (CLHeading *)headingAtTimeInterval:(NSTimeInterval)interval {
    return self.currentHeading;
}

// Should be overriden
- (BOOL)shouldStop {
    return NO;
}

- (double)kmPerHour:(EFLocationScenarioSpeed)speed {
    switch (speed) {
        case EFLocationScenarioSpeedCarCity:
            return 50;
        case EFLocationScenarioSpeedCarHighway:
            return 100;
        case EFLocationScenarioSpeedPedestrian:
            return 5;
        case EFLocationScenarioSpeedRunner:
            return 12;
        case EFLocationScenarioSpeedSupermanRun:
            return 300;
        case EFLocationScenarioSpeedSupermanFly:
            return 1200; // ~ 4 * speed of sound
    }
}

- (double)metersPerSecond:(EFLocationScenarioSpeed)speed {
    return ([self kmPerHour:speed] * 1000) / (60 * 60);
}

@end
