//
//  EFStraightLineLocationScenario.m
//  MockLocationDemo
//
//  Created by Ivo Jansch on 25/07/14.
//  Copyright (c) 2014 Egeniq. All rights reserved.
//

#import <EFStraightLineScenario.h>
#import <EFLocationScenario-Internal.h>
#import <CLLocation+LocationExtensions.h>

@interface EFStraightLineScenario ()

@property (nonatomic, strong) CLLocation *from;
@property (nonatomic, strong) CLLocation *to;
@property (nonatomic, assign) EFLocationScenarioSpeed speed;
@property (nonatomic, assign) NSTimeInterval lastInterval;

@end

@implementation EFStraightLineScenario

- (id)initWithFrom:(CLLocation *)from to:(CLLocation *)to {
    return [self initWithFrom:from to:to speed:EFLocationScenarioSpeedPedestrian];
}

- (id)initWithFrom:(CLLocation *)from to:(CLLocation *)to speed:(EFLocationScenarioSpeed)speed {
    self = [super init];
    if (self) {
        self.from = from;
        self.to = to;
        self.speed = speed;
    }
    return self;
}

- (CLLocation *)locationAtTimeInterval:(NSTimeInterval)interval {
    if (interval == 0) {
        return self.from;
    } else {
        NSTimeInterval elapsedSincePrevious = interval - self.lastInterval;
        self.lastInterval = interval;
        NSUInteger metersToMove = [self metersPerSecond:self.speed] * elapsedSincePrevious;
        NSUInteger metersToDestination = [self.to distanceFromLocation:self.currentLocation];
        if (metersToMove >= metersToDestination) {
            // We reach the destination this step.
            return self.to;
        } else {
            CLLocationDegrees bearing = [self.currentLocation bearingTo:self.to];
            return [self.currentLocation locationAtDistance:metersToMove andBearing:bearing];
        }
    }
}

- (BOOL)shouldStop {
    return [self.currentLocation isEqual:self.to];
}

- (CLHeading *)headingAtTimeInterval:(NSTimeInterval)interval {
    // not supported
    return nil;
}


@end
