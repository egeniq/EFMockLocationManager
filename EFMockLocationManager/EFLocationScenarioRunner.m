//
//  EFLocationScenarioRunner.m
//  MockLocationDemo
//
//  Created by Ivo Jansch on 25/07/14.
//  Copyright (c) 2014 Egeniq. All rights reserved.
//

#import <EFLocationScenarioRunner.h>
#import <EFLocationScenario.h>
#import <EFMockLocationManager.h>
#import <EFLocationScenario-Internal.h>

@interface EFLocationScenarioRunner () <EFLocationScenarioInternalDelegate>

@property (nonatomic, strong) EFLocationScenario *currentScenario;
@property (nonatomic, strong) EFMockLocationManager *mockLocationManager;
@property (nonatomic, strong) EFScenarioStatusBlock scenarioStartBlock;
@property (nonatomic, strong) EFScenarioStatusBlock scenarioEndBlock;

@end

@implementation EFLocationScenarioRunner

- (id)initWithMockLocationManager:(EFMockLocationManager *)locationManager {
    self = [super init];
    if (self) {
        self.mockLocationManager = (EFMockLocationManager *)locationManager;
    }
    return self;
}

- (void)runScenario:(EFLocationScenario *)scenario {
    [self runScenario:scenario onStart:nil onEnd:nil];
}

- (void)runScenario:(EFLocationScenario *)scenario onEnd:(EFScenarioStatusBlock)end {
    [self runScenario:scenario onStart:nil onEnd:end];
}

- (void)runScenario:(EFLocationScenario *)scenario onStart:(EFScenarioStatusBlock)start onEnd:(EFScenarioStatusBlock)end {
    self.currentScenario = scenario;
    scenario.internalDelegate = self;
    self.scenarioStartBlock = start;
    self.scenarioEndBlock = end;
    [scenario start];
}

- (void)scenario:(EFLocationScenario *)scenario movedToLocation:(CLLocation *)location {
    [self.mockLocationManager setLocation:location];
}

- (void)scenario:(EFLocationScenario *)scenario didStartAt:(CLLocation *)location {
    if (self.scenarioStartBlock) {
        EFScenarioStatusBlock block = self.scenarioStartBlock;
        self.scenarioStartBlock = nil;
        block(location);
    }
}

- (void)scenario:(EFLocationScenario *)scenario didEndAt:(CLLocation *)location {
    if (self.scenarioEndBlock) {
        EFScenarioStatusBlock block = self.scenarioEndBlock;
        self.scenarioEndBlock = nil;
        block(location);
    }
}

@end
