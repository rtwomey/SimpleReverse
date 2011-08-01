# SimpleReverse

Demo showing how to use SimpleGeo.framework to do a reverse geocode and retrieve current weather information of a lat/lng.

This uses the [`SimpleGeo.framework`](https://github.com/simplegeo/SimpleGeo.framework), referenced in this project as a git submodule.

This app was written for [an article on iOSDevNotes](http://www.iosdevnotes.com/2011/08/simplegeo-ios-started-tutorial/).  Be sure to check out that tutorial for details on how this works.

## How it works

The app first uses CLLocationManager (part of CoreLocation) to retrieve the current latitude & longitude of the device.  Once the lat/lng has been retrieved, app kicks off a request to SimpleGeo to get an SGContext, which contains the street address (reverse geocode) and weather information.

## API Key

You'll need to register for a developer account to get your API key needed to use this demo.  You'll find the place to enter your consumer key and secret in SimpleReverseViewController.m
