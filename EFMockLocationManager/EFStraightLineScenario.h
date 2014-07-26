//
//  EFStraightLineLocationScenario.h
//  MockLocationDemo
//
//  Created by Ivo Jansch on 25/07/14.
//  Copyright (c) 2014 Egeniq. All rights reserved.
//

#import "EFLocationScenario.h"

@class CLLocation;

@interface EFStraightLineScenario : EFLocationScenario

- initWithFrom:(CLLocation *)from to:(CLLocation *)to;
- initWithFrom:(CLLocation *)from to:(CLLocation *)to speed:(EFLocationScenarioSpeed)speed;

@end
