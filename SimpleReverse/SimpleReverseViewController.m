//
//  SimpleReverseViewController.m
//  SimpleReverse
//
//  Created by Ryan Twomey on 6/15/11.
//  Copyright 2011 Draconis Software. All rights reserved.
//

#import "SimpleReverseViewController.h"

@implementation SimpleReverseViewController

@synthesize locationManager, sgClient;
@synthesize latLabel, lngLabel, addressLabel, weatherLabel;

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
	[super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
	// wait until we are within a certain level of accuracy
	if(newLocation.horizontalAccuracy <= 70.0f) {
		[locationManager stopUpdatingLocation];
		
		[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];

		self.sgClient = [SimpleGeo clientWithDelegate:self 
																			consumerKey:@"-CONSUMER_KEY-" 
																	 consumerSecret:@"-CONSUMER_SECRET-"];
		
		[sgClient getContextForPoint:[SGPoint pointWithLatitude:newLocation.coordinate.latitude 
																									longitude:newLocation.coordinate.longitude]];
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

#pragma mark - SimpleGeo

- (void)didLoadContext:(NSDictionary *)context forQuery:(NSDictionary *)query {
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

	NSDictionary* addrProperties = [[context objectForKey:@"address"] objectForKey:@"properties"];
	
	// be sure to check for "address" string for street address - it's not always present
	NSString* addrStr = [NSString stringWithFormat:@"%@, %@ %@", 
											 [addrProperties objectForKey:@"city"],
											 [addrProperties objectForKey:@"province"],
											 [addrProperties objectForKey:@"country"]];
	addressLabel.text = addrStr;
	
	// just for fun, let's get the weather too
	NSDictionary* weatherProperties = [context objectForKey:@"weather"];
	
	NSString* weatherStr = [NSString stringWithFormat:@"Cloud cover: %@\nConditions: %@\nTemp: %@",
													[weatherProperties objectForKey:@"cloud_cover"],
													[weatherProperties objectForKey:@"conditions"],
													[weatherProperties objectForKey:@"temperature"]];
	
	NSDictionary* tomorrow = [[weatherProperties objectForKey:@"forecast"] objectForKey:@"tomorrow"];
	
	weatherStr = [NSString stringWithFormat:@"%@\nTomorrow:\n  Conditions: %@\n  Precipitation: %@\n  Low: %@, High: %@",
								weatherStr,
								[tomorrow objectForKey:@"conditions"],
								[tomorrow objectForKey:@"precipitation"],
								[[tomorrow objectForKey:@"temperature"] objectForKey:@"min"],
								[[tomorrow objectForKey:@"temperature"] objectForKey:@"max"]];
	
	weatherLabel.text = weatherStr;
	
	self.sgClient = nil;
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
