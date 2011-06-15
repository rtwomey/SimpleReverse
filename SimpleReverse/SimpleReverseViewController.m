//
//  SimpleReverseViewController.m
//  SimpleReverse
//
//  Created by Ryan Twomey on 6/15/11.
//  Copyright 2011 Draconis Software. All rights reserved.
//

#import "SimpleReverseViewController.h"

@implementation SimpleReverseViewController

@synthesize locationManager;
@synthesize latLabel, lngLabel;

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
	[super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

#pragma mark - CLLocationManager

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
	// wait until we are within a certain level of accuracy
	if(newLocation.horizontalAccuracy <= 70.0f) {
		[locationManager stopUpdatingLocation];
	}
	
	latLabel.text = [NSString stringWithFormat:@"%f", newLocation.coordinate.latitude];
	lngLabel.text = [NSString stringWithFormat:@"%f", newLocation.coordinate.longitude];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
	UIAlertView *prompt = [[UIAlertView alloc] initWithTitle: @"CLLocation Error" 
																									 message: error.description
																									delegate: nil 
																				 cancelButtonTitle: @"OK" 
																				 otherButtonTitles: nil];
	
	[prompt show];
	[prompt release];
}

#pragma mark - View lifecycle

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.locationManager = [[CLLocationManager alloc] init];
	self.locationManager.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];

	[locationManager startUpdatingLocation];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	
	[locationManager stopUpdatingLocation];
}

- (void)viewDidUnload {
	[super viewDidUnload];

	self.locationManager = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
