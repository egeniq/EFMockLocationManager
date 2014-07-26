//
//  EFLocationScenario.h
//  MockLocationDemo
//
//  Created by Ivo Jansch on 25/07/14.
//  Copyright (c) 2014 Egeniq. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CLLocation;
@class EFLocationScenario;

typedef NS_ENUM(NSUInteger, EFLocationScenarioSpeed) {
    EFLocationScenarioSpeedPedestrian,
    EFLocationScenarioSpeedRunner,
    EFLocationScenarioSpeedCarCity,
    EFLocationScenarioSpeedCarHighway,
    EFLocationScenarioSpeedSupermanRun,
    EFLocationScenarioSpeedSupermanFly
};

@protocol EFLocationScenarioDelegate <NSObject>

- (void)scenario:(EFLocationScenario *)scenario didStartAt:(CLLocation *)location;
- (void)scenario:(EFLocationScenario *)scenario didEndAt:(CLLocation *)location;

@end

@interface EFLocationScenario : NSObject

- (void)start;
- (void)stop;

// Get the average km/h rate for a certain speed preset.
- (double)kmPerHour:(EFLocationScenarioSpeed)speed;
- (double)metersPerSecond:(EFLocationScenarioSpeed)speed;

// You can alsways see the simulator's current location but of course, you
// wouldn't use that in your app, you'd access this through the mock location manager.
@property (nonatomic, strong, readonly) CLLocation *currentLocation;

// The speed of the simulated location trip. Can be changed along the way.
@property (nonatomic, assign) EFLocationScenarioSpeed speed;

@property (nonatomic, weak) id<EFLocationScenarioDelegate> delegate;

@end
