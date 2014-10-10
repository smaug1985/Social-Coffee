//
//  LocationsMap.h
//  Business Listings Part 3
//
//  Created by Zack Ensign on 9/21/10.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "MapDataParser.h"

@interface LocationsMap : UIView <MKMapViewDelegate, CLLocationManagerDelegate>
{
	MKMapView *myMapView;
	CLLocationManager *locationManager;
	MapDataParser *mapDataParser;
	NSMutableArray *currentAnnotations;
	CLLocation *currentLocation;
	CLLocation *anotherLocation; //used when user moves pin for search coffee in another place.
	NSString *searchKeyword;
}

@property (nonatomic, retain) MKMapView *myMapView;
@property (nonatomic, retain) CLLocation *currentLocation;
@property (nonatomic, retain) CLLocation *anotherLocation;
@property (nonatomic, retain) NSString *searchKeyword;
@property (nonatomic, retain) NSMutableArray *currentAnnotations;

-(void) findLocationsByKeyword:(NSString *)searchKeyword;
-(void)removeBusinessAnnotations;
@end
