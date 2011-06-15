//
//  SimpleReverseAppDelegate.h
//  SimpleReverse
//
//  Created by Ryan Twomey on 6/15/11.
//  Copyright 2011 Draconis Software. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SimpleReverseViewController;

@interface SimpleReverseAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet SimpleReverseViewController *viewController;

@end
