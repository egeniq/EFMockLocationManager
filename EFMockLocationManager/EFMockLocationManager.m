//
//  EFMockLocationManager.m
//  MockLocationDemo
//
//  Created by Ivo Jansch on 24/07/14.
//  Copyright (c) 2014 Egeniq. All rights reserved.
//

#import <EFMockLocationManager.h>

@interface EFMockLocationManager ()

// Some stuff we delegate to a real manager.
// (It's never used for any location stuff though)
@property (nonatomic, strong) CLLocationManager *realLocationManager;
@property (nonatomic, strong, readwrite) CLLocation *location;

@property (nonatomic, assign) BOOL isUpdatingLocation;
@property (nonatomic, assign) BOOL isUpdatingHeading;
@property (nonatomic, assign) BOOL significantMode;

@end

@implementation EFMockLocationManager

- (id)init {
    self = [super init];
    if (self) {
        self.realLocationManager = [[CLLocationManager alloc] init];
        self.isUpdatingLocation = NO;
        self.isUpdatingHeading = NO;
        self.significantMode = NO;
        self.desiredAccuracy = kCLLocationAccuracyBest;
    }
    return self;
}

- (void)startUpdatingLocation {
    self.isUpdatingLocation = YES;
}

- (void)stopUpdatingLocation {
    self.isUpdatingLocation = NO;
}

- (void)startUpdatingHeading {
    self.isUpdatingHeading = YES;
}

- (void)stopUpdatingHeading {
    self.isUpdatingHeading = NO;
}

- (void)dismissHeadingCalibrationDisplay {
    [self.realLocationManager dismissHeadingCalibrationDisplay];
}

- (void)startMonitoringSignificantLocationChanges {
    self.significantMode = YES;
    self.isUpdatingLocation = YES;
}

- (void)stopMonitoringSignificantLocationChanges {
    self.significantMode = NO;
    self.isUpdatingLocation = NO;
}

- (void)startMonitoringForRegion:(CLRegion *)region desiredAccuracy:(CLLocationAccuracy)accuracy {
    // not supported
}

#pragma mark - ibeacon methods, not yet supported
- (void)stopMonitoringForRegion:(CLRegion *)region {
    
}

- (void)startMonitoringForRegion:(CLRegion *)region {
    
}

- (void)requestStateForRegion:(CLRegion *)region {
    
}

- (void)startRangingBeaconsInRegion:(CLBeaconRegion *)region {
    
}

- (void)stopRangingBeaconsInRegion:(CLBeaconRegion *)region {
    
}

- (void)allowDeferredLocationUpdatesUntilTraveled:(CLLocationDistance)distance timeout:(NSTimeInterval)timeout {
    
}

- (void)disallowDeferredLocationUpdates {
    
}

+ (BOOL)locationServicesEnabled {
    return YES;
}

+ (BOOL)headingAvailable {
    return YES;
}

+ (BOOL)significantLocationChangeMonitoringAvailable {
    return YES;
}

+ (BOOL)isMonitoringAvailableForClass:(Class)regionClass {
    return NO;
}

+ (BOOL)isRangingAvailable {
    return NO;
}

+ (CLAuthorizationStatus)authorizationStatus {
    return kCLAuthorizationStatusAuthorized;
}

+ (BOOL)deferredLocationUpdatesAvailable {
    return NO;
}


// This is what the simulator calls to actually set the location. Here's where the
// Mock decides to update the app.
- (void)setLocation:(CLLocation *)location {
   
    if (self.isUpdatingLocation) {
        long traveledDistance = 0;
        if (self.location) {
            traveledDistance = [location distanceFromLocation:self.location];
        }
        if (!self.location || (self.significantMode && traveledDistance > 800) || (!self.significantMode && traveledDistance > self.desiredAccuracy)) {
            _location = location;
            // todo, maybe also pass the skipped locations in the array?
            [self.delegate locationManager:(CLLocationManager *)self didUpdateLocations:@[location]];
        } else {
            // skipping, we don't use this location because it would be too accurate for our settings.
        }
    }
}

@end
