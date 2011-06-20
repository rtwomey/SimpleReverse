//
//  SimpleReverseViewController.h
//  SimpleReverse
//
//  Created by Ryan Twomey on 6/15/11.
//  Copyright 2011 Draconis Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <SimpleGeo/SimpleGeo.h>

@interface SimpleReverseViewController : UIViewController<CLLocationManagerDelegate> {
	CLLocationManager* locationManager;
	SimpleGeo* sgClient;
	
	UILabel* latLabel;
	UILabel* lngLabel;
	UILabel* addressLabel;
}

@property(nonatomic, retain) CLLocationManager* locationManager;
@property(nonatomic, retain) SimpleGeo* sgClient;

@property(nonatomic, retain) IBOutlet UILabel* latLabel;
@property(nonatomic, retain) IBOutlet UILabel* lngLabel;
@property(nonatomic, retain) IBOutlet UILabel* addressLabel;

@end
