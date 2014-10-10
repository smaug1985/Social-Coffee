//
//  LocationsMap.m
//  Business Listings Part 3
//
//  Created by Zack Ensign on 9/21/10.
//

#import "LocationsMap.h"
#import "MapDataParser.h"
#import "MapLocationVO.h"
#import "BLAnnotation.h"
#import "BLPinAnnotation.h"
#import "DDAnnotation.h"
#import "DDAnnotationView.h"

@implementation LocationsMap

@synthesize myMapView, currentLocation, searchKeyword, currentAnnotations, anotherLocation;


- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame]))
	{
		// Create the map view 
		
        myMapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
		myMapView.delegate = self;
		myMapView.userInteractionEnabled = YES;
		myMapView.showsUserLocation = YES;
		[self addSubview:myMapView];
		
		// array to store annotations added to the map
		currentAnnotations = [[NSMutableArray alloc] init];
		
		// respond to an annotation being selected by centering the map to it's coordinates
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(centerMapToAnnotation:) name:@"annotationSelected" object:nil];
    }
	
    return self;
}

-(void) centerMapToAnnotation:(NSNotification *)note
{
	// Type dispatching annotation object
	BLPinAnnotation *annotation = (BLPinAnnotation *)[note object];
	
	// animate the map to the pin's coordinates
	[myMapView setCenterCoordinate:annotation.annotation.coordinate animated: YES];
}

-(void) findLocationsByKeyword:(NSString *)keyword
{
	// if we haven't gotten the user's location yet, create an instance of CLLocationManager to find it.
	// Otherwise, go ahead and call "getBusinessListingsByKeyword" on our MapDataParser instance
	
	if(!locationManager)
	{
		locationManager = [[CLLocationManager alloc] init];
		locationManager.desiredAccuracy=kCLLocationAccuracyNearestTenMeters;
		locationManager.delegate = self;
		[locationManager startUpdatingLocation];
		
		// listen for map data parsing completion
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(displayBusinessLocations:) name:@"mapDataParseComplete" object:nil];
	}
	else
	{
		[mapDataParser getBusinessListingsByKeyword:keyword atLat:currentLocation.coordinate.latitude atLng:currentLocation.coordinate.longitude];
	}
	
	// save the keyword state
	searchKeyword = keyword;
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{	
	// User location has been found/updated, load map data now.
	
	locationManager.delegate = nil;
	[locationManager stopUpdatingLocation];
	
	if(!mapDataParser) mapDataParser = [[MapDataParser alloc] init];
	
	currentLocation = [newLocation copy];
	
	[mapDataParser getBusinessListingsByKeyword:searchKeyword atLat:currentLocation.coordinate.latitude atLng:currentLocation.coordinate.longitude];
	//[mapDataParser getBusinessListingsByKeyword:searchKeyword atLat:26.152718f atLng:-80.216259f];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
	// Failed to find the user's location. This error occurs when the user declines the location request 
	// or has location servives turned off.
	
	NSString * errorString = @"Unable to determine your current location.";
	UIAlertView * errorAlert = [[UIAlertView alloc] initWithTitle:@"Error Locating" message:errorString delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[errorAlert show];
	[locationManager stopUpdatingLocation];
}

-(void) displayBusinessLocations:(id)sender
{	
	// User location has been found and map data is loaded.
	// Now create the annotations and add them to the map.
	
	MKCoordinateRegion region;
	MKCoordinateSpan span;
	span.latitudeDelta = 0.2;
	span.longitudeDelta = 0.2;
	
	region.span=span;
	if (anotherLocation) {
		region.center = anotherLocation.coordinate;
	}
	else {
		region.center=currentLocation.coordinate;
	}

	//
	
	[myMapView setRegion:region animated:YES];
	[myMapView regionThatFits:region];
	
	for(MapLocationVO *mapLocationVO in mapDataParser.locationData)
	{
		
		
		// Create annotations for the returned google maps data.
		
		BLAnnotation *businessListingAnnotation = [[BLAnnotation alloc] initWithCoordinate: mapLocationVO.mapLocation.coordinate title: mapLocationVO.locationTitle subtitle:mapLocationVO.locationSnippet];
		
		[myMapView addAnnotation: businessListingAnnotation];
		[currentAnnotations addObject: businessListingAnnotation];
		
		[businessListingAnnotation release];
		businessListingAnnotation = nil;
	}
}


 

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>) annotation
{
	// Specify which MKPinAnnotationView to use for each annotation. 
	
	if (annotation != self.myMapView.userLocation)
	{
		// Use custom annotation view for anything but the user's locaiton pin
		
		BLPinAnnotation *blAnnotationView = (BLPinAnnotation *)[self.myMapView dequeueReusableAnnotationViewWithIdentifier: @"BLPin" ];
		
		if (blAnnotationView == nil)
		{
			blAnnotationView = [[BLPinAnnotation alloc] initWithAnnotation:annotation reuseIdentifier:@"BLPin"];
		}
		else
		{
			blAnnotationView.annotation = annotation;
			blAnnotationView.titleLabel.text = annotation.title;
			blAnnotationView.subtitleLabel.text = annotation.subtitle;
		}
		
		return blAnnotationView;
	}
	else
	{
		// Use a native MKAnnoationView for the user's location
		
		MKPinAnnotationView *businessListingPin = (MKPinAnnotationView *)[self.myMapView dequeueReusableAnnotationViewWithIdentifier: @"BLUserPin" ];
		
		if (businessListingPin == nil) businessListingPin = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"BLUserPin"];
		businessListingPin.draggable = YES;
		businessListingPin.canShowCallout = NO;
		//businessListingPin.enabled = NO;
		[businessListingPin setAccessibilityFrame:CGRectMake(businessListingPin.frame.origin.x, businessListingPin.frame.origin.y, businessListingPin.frame.size.width, businessListingPin.frame.size.height)];
		businessListingPin.pinColor = MKPinAnnotationColorRed;
		
	
		return businessListingPin;
		
		/*static NSString * const kPinAnnotationIdentifier = @"PinIdentifier";
		MKAnnotationView *draggablePinView = [self.myMapView dequeueReusableAnnotationViewWithIdentifier:kPinAnnotationIdentifier];
		
		if (draggablePinView) {
			
			draggablePinView.annotation = annotation;
		} else {		
			draggablePinView = [[[DDAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:kPinAnnotationIdentifier] autorelease];
			
			if ([draggablePinView isKindOfClass:[DDAnnotationView class]]) {
				((DDAnnotationView *)draggablePinView).mapView = self.myMapView;
			} else {
				// NOTE: draggablePinView instance will be built-in draggable MKPinAnnotationView when running under iOS 4.
			}
		}
		CLLocationCoordinate2D coord =  [mapView convertPoint:draggablePinView.center toCoordinateFromView:nil];
		//NSLog(@"original coord: %g,%g", coord.latitude, coord.longitude);
		NSLog(@"original coord: %f,%f", draggablePinView.center.x, draggablePinView.center.y);
		draggablePinView.tag = 1;
		draggablePinView.canShowCallout = NO;
		return draggablePinView;*/
	}
	
}


-(void) mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view didChangeDragState:(int)newState fromOldState:(int)oldState{
	
	//NSLog(@"annotation old position was: %@ ", view.annotation.coordinate);
	//NSLog(@"annotation state changed from state:%d to state: %d",oldState, newState);
	
	
	//NSLog(@"new coord: %g,%g", coord.latitude, coord.longitude);
	//NSLog(@"new coord: %g,%g", coord.latitude, coord.longitude);
	if (newState == 0) {
		[self removeBusinessAnnotations];
		
		CLLocationCoordinate2D coord = view.annotation.coordinate;
		
			anotherLocation = [[CLLocation alloc] initWithLatitude:coord.latitude longitude:coord.longitude];
		
		
			
		

		//[myMapView removeAnnotations:myMapView.annotations];
		//CLLocationCoordinate2D coord =  [mapView convertPoint:view.center toCoordinateFromView:mapView];
		[mapDataParser getBusinessListingsByKeyword:searchKeyword atLat:anotherLocation.coordinate.latitude	atLng:anotherLocation.coordinate.longitude];

	}
	
}


- (void)dealloc {
    [super dealloc];
	
	[myMapView release]; myMapView = nil;
	[locationManager release]; locationManager = nil;
	[mapDataParser release]; mapDataParser = nil;
	[currentAnnotations release]; currentAnnotations = nil;
	[currentLocation release]; currentLocation = nil;
	[searchKeyword release]; searchKeyword = nil;
}


-(void)removeBusinessAnnotations
{
	
	
	[myMapView removeAnnotations:currentAnnotations];
	
	
}

@end
