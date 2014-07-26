//
//  ViewController.m
//  mocklocationdemo
//
//  Created by Ivo Jansch on 24/07/14.
//  Copyright (c) 2014 Egeniq. All rights reserved.
//

#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import <EFLocationScenarioRunner.h>
#import <EFStraightLineScenario.h>
#import <EFMockLocationManager.h>

@interface ViewController () <CLLocationManagerDelegate, MKMapViewDelegate>
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, weak) IBOutlet MKMapView *mapView;
@property (nonatomic, strong) CLLocation *lastKnownLocation;
@property (nonatomic, strong) EFLocationScenarioRunner *scenarioRunner;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	 
    // Get the location manager
    EFMockLocationManager *mockLocationManager = [[EFMockLocationManager alloc] init];
    
    // And use it like we would with a real locationmanager.
    self.locationManager = mockLocationManager.CLLocationManager;
    self.locationManager.delegate = self;
    
    // Play with the below settings to see differences in accuracy.
    
    // 1. Accurate - you can track superman's every move.
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager startUpdatingLocation];
    
    // 2. Not so accurate. Notice how superman still saves lois, but his
    // phone doesn't see his every location anymore.
    // self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    // [self.locationManager startUpdatingLocation];
    
    // 3. To save superman's battery, we could only do significant changes.
    // [self.locationManager startMonitoringSignificantLocationChanges];
    
    // Now set up a nice simulation!
    self.scenarioRunner = [[EFLocationScenarioRunner alloc] initWithMockLocationManager:mockLocationManager];
    
    CLLocation *louvre = [[CLLocation alloc] initWithLatitude:48.862611 longitude:2.335238];
    CLLocation *arcDeTriomph = [[CLLocation alloc] initWithLatitude:48.873781 longitude:2.295026];
    CLLocation *eiffelTower = [[CLLocation alloc] initWithLatitude:48.85837 longitude:2.294481];
    
    EFStraightLineScenario *supermanSavesLois = [[EFStraightLineScenario alloc] initWithFrom:louvre
                                                                                          to:arcDeTriomph
                                                                                       speed:EFLocationScenarioSpeedSupermanRun];
    
    [self.scenarioRunner
        runScenario:supermanSavesLois
        onStart:^(CLLocation *startAt) {
            // center the map around the point (500m area)
            MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(startAt.coordinate, 500, 500);
            [self.mapView setRegion:viewRegion animated:NO];
        }
        onEnd:^(CLLocation *endedAt) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"End"
                                                            message:@"Oh no! Lois is not here, she's at the Eiffel Tower!"
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            // It's important to use endedAt as the starting point for our next leg, since a scenario isn't guaranteed
            // to complete at its endpoint (some scenario's may simulate someone stranded halfway).
            // 
            EFStraightLineScenario *toEiffel = [[EFStraightLineScenario alloc] initWithFrom:endedAt
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

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// This just plots our mocked locations on the map.
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    // Only this delegate method is currently supported. More can be added in the future.
    NSLog(@"Got some locations %@", locations);
    
    self.lastKnownLocation = [locations firstObject];
    
    // center the map around the point (500m area)
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(self.lastKnownLocation.coordinate, 500, 500);
    
    [self.mapView setRegion:viewRegion animated:YES];
    
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    [annotation setCoordinate:self.lastKnownLocation.coordinate];
    [self.mapView addAnnotation:annotation];
}

@end
