EFMockLocationManager
=====================

A simple simulator that helps debugging location based apps. Designed to be more flexible than the simulator's built in location simulation features, and it works on the device too.

The project consists of 2 separate, but closely related parts:

* A mock locationmanager object that mimics the CLLocationManager's interface, but doesn't use any of the device's sensors. It gets its location manually in your code.
* A simulator that can simulate an object moving about according to various scenarios.

The simulator accurately updates its location every half second. However whether or not you get location updates depends on how you use the location manager. It simulates accuracy by only reporting the simulator's location if the change is larger than the desired accuracy.

Installation
------------
Can be installed with cocoapods.

However to just toy around with the simulator, you can get this entire repo, which comes with a demo project that plays a scenario and plots the result in a map view.

Working with the mock location manager
--------------------------------------
To get a simulated CLLocationManager intance:

    EFMockLocationManager *mockLocationManager = [[EFMockLocationManager alloc] init];
    
To force it to some location:

    [mockLocationManager setLocation:someLocation];
    
To use it as a CLLocationManager to debug an app's use of the location manager:

    CLLocationManager *locationManager = mockLocationManager.CLLocationManager;
    
Alternative, simply cast it:

    CLLocationManager *locationManager = (CLLocationManager *)mockLocationManager;

Working with the simulator
--------------------------
To simulate some actual movement, work with scenarios. Currently we only support straight line scenarios with variable speed, but in the future we should be adding teleportation, random wandering, maybe even one that follows navigation instructions from mapkit.

Scenarios can easily be chained as they have optional onEnd blocks where you can launch the next scenario.

Here's a code sample to illustrate a scenario. This is the one that's available in the demo application and runs out of the box. (In the demo it features a bit more code to illustrate the locations on a map and to present an alert when the scenario completes)

```
self.scenarioRunner = [[EFLocationScenarioRunner alloc] initWithMockLocationManager:mockLocationManager];

CLLocation *louvre = [[CLLocation alloc] initWithLatitude:48.862611 longitude:2.335238];
CLLocation *arcDeTriomph = [[CLLocation alloc] initWithLatitude:48.873781 longitude:2.295026];
CLLocation *eiffelTower = [[CLLocation alloc] initWithLatitude:48.85837 longitude:2.294481];

EFStraightLineScenario *supermanSavesLois = 
     [[EFStraightLineScenario alloc] initWithFrom:louvre 
                                               to:arcDeTriomph
                                            speed:EFLocationScenarioSpeedSupermanRun];

[self.scenarioRunner
    runScenario:supermanSavesLois
    onEnd:^(CLLocation *endedAt) {
        
        // It's important to use endedAt as the starting point for our next leg, since a scenario isn't guaranteed
        // to complete at its endpoint (some scenario's may simulate someone stranded halfway).
        // 
        // Lois isn't at Arc De Triomph. Go to Eiffeltower from here.
        EFStraightLineScenario *toEiffel = 
            [[EFStraightLineScenario alloc] initWithFrom:endedAt
                                                      to:eiffelTower
                                                   speed:EFLocationScenarioSpeedSupermanRun];
        [self.scenarioRunner runScenario:toEiffel
                            onEnd:^(CLLocation *endedAt) {
            if ([endedAt isEqual:eiffelTower]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"End"
                                                                message:@"Superman saves the day"
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
            }
        }];
    }
 ];

```
