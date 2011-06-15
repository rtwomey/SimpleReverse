//
//  SimpleReverseViewController.h
//  SimpleReverse
//
//  Created by Ryan Twomey on 6/15/11.
//  Copyright 2011 Draconis Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface SimpleReverseViewController : UIViewController<CLLocationManagerDelegate> {
	CLLocationManager* locationManager;
	
	UILabel* latLabel;
	UILabel* lngLabel;
}

@property(nonatomic, retain) CLLocationManager* locationManager;

@property(nonatomic, retain) IBOutlet UILabel* latLabel;
@property(nonatomic, retain) IBOutlet UILabel* lngLabel;

@end
