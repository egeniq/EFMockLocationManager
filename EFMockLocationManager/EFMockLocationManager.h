//
//  EFMockLocationManager.h
//  MockLocationDemo
//
//  Created by Ivo Jansch on 24/07/14.
//  Copyright (c) 2014 Egeniq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CLAvailability.h>
#import <CoreLocation/CLLocation.h>
#import <CoreLocation/CLRegion.h>
#import <CoreLocation/CLLocationManagerDelegate.h>
#import <CoreLocation/CLLocationManager.h>
#import <EFLocationScenario-Internal.h>

@class CLLocation;
@class CLHeading;
@class CLBeaconRegion;
@protocol CLLocationManagerDelegate;

/*
 *  MockLocationManager
 *
 *  Discussion:
 *    The MockLocationManager simulates a CLLocationManager. The main
 *    difference is that it doesn't actually use location services. 
 *    It has a setLocation that allows you to set the location manually
 *    at runtime. 
 * 
 *    Whether that location gets propagated to the CLLocationManager's 
 *    delegate depends on the accuracy settings, to reflect CLLocationManager
 *    as accurately as possible.
 */
NS_CLASS_AVAILABLE(10_6, 2_0)
@interface EFMockLocationManager : NSObject

/**
 * Set the location of the locationmanager.
 */
- (void)setLocation:(CLLocation *)location;

/**
 * Get the CLLocationManager instance.
 * This is basically the same object, but it gets casted to CLLocationManager 
 * so you get proper completion in your code (it acts like a true CLLocationManager 
 * in terms of interface, but it's a different thing under the hood.
 * 
 * Note, not every feature is currently implemented. At the moment it mostly supports
 * location updates with proper lat/long (no speed properties, beacons, heading etc.)
 */
- (CLLocationManager *)CLLocationManager;

/** 
 * below are all the CLLocationManager method clones. For documentation, see CLLocationManager.
 */
+ (BOOL)locationServicesEnabled __OSX_AVAILABLE_STARTING(__MAC_10_7,__IPHONE_4_0);
+ (BOOL)headingAvailable __OSX_AVAILABLE_STARTING(__MAC_10_7,__IPHONE_4_0);
+ (BOOL)significantLocationChangeMonitoringAvailable __OSX_AVAILABLE_STARTING(__MAC_10_7,__IPHONE_4_0);
+ (BOOL)isMonitoringAvailableForClass:(Class)regionClass __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_7_0);
+ (BOOL)isRangingAvailable __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_7_0);
+ (CLAuthorizationStatus)authorizationStatus __OSX_AVAILABLE_STARTING(__MAC_10_7,__IPHONE_4_2);

@property(assign, nonatomic) id<CLLocationManagerDelegate> delegate;
@property(readonly, nonatomic) BOOL locationServicesEnabled __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_NA,__MAC_NA,__IPHONE_2_0,__IPHONE_4_0);
@property(copy, nonatomic) NSString *purpose __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_10_7, __MAC_NA, __IPHONE_3_2, __IPHONE_6_0);
@property(assign, nonatomic) CLActivityType activityType __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_6_0);
@property(assign, nonatomic) CLLocationDistance distanceFilter;
@property(assign, nonatomic) CLLocationAccuracy desiredAccuracy;
@property(assign, nonatomic) BOOL pausesLocationUpdatesAutomatically __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_6_0);
@property(readonly, nonatomic) CLLocation *location;
@property(readonly, nonatomic) BOOL headingAvailable __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_NA,__MAC_NA,__IPHONE_3_0,__IPHONE_4_0);
@property(assign, nonatomic) CLLocationDegrees headingFilter __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0);
@property(assign, nonatomic) CLDeviceOrientation headingOrientation __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_4_0);
@property(readonly, nonatomic) CLHeading *heading __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_4_0);
@property (readonly, nonatomic) CLLocationDistance maximumRegionMonitoringDistance __OSX_AVAILABLE_STARTING(__MAC_10_7,__IPHONE_4_0);
@property (readonly, nonatomic) NSSet *monitoredRegions __OSX_AVAILABLE_STARTING(__MAC_10_7,__IPHONE_4_0);
@property (readonly, nonatomic) NSSet *rangedRegions __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_7_0);

- (void)startUpdatingLocation;
- (void)stopUpdatingLocation;
- (void)startUpdatingHeading __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0);
- (void)stopUpdatingHeading __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0);
- (void)dismissHeadingCalibrationDisplay __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0);
- (void)startMonitoringSignificantLocationChanges __OSX_AVAILABLE_STARTING(__MAC_10_7,__IPHONE_4_0);
- (void)stopMonitoringSignificantLocationChanges __OSX_AVAILABLE_STARTING(__MAC_10_7,__IPHONE_4_0);
- (void)startMonitoringForRegion:(CLRegion *)region
                 desiredAccuracy:(CLLocationAccuracy)accuracy __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_NA, __MAC_NA,__IPHONE_4_0, __IPHONE_6_0);
- (void)stopMonitoringForRegion:(CLRegion *)region __OSX_AVAILABLE_STARTING(__MAC_10_7,__IPHONE_4_0);
- (void)startMonitoringForRegion:(CLRegion *)region __OSX_AVAILABLE_STARTING(__MAC_TBD,__IPHONE_5_0);
- (void)requestStateForRegion:(CLRegion *)region __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_7_0);
- (void)startRangingBeaconsInRegion:(CLBeaconRegion *)region __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_7_0);
- (void)stopRangingBeaconsInRegion:(CLBeaconRegion *)region __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_7_0);
- (void)allowDeferredLocationUpdatesUntilTraveled:(CLLocationDistance)distance
                                          timeout:(NSTimeInterval)timeout __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_6_0);
- (void)disallowDeferredLocationUpdates __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_6_0);
+ (BOOL)deferredLocationUpdatesAvailable __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_6_0);

@end
