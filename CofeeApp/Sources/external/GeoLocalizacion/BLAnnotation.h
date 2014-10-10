//
//  BLAnnotation.h
//  Business Listings Part 3
//
//  Created by Zack Ensign on 9/21/10.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface BLAnnotation : NSObject <MKAnnotation> {
@private
    CLLocationCoordinate2D _coordinate;
    NSString *_title;
	NSString *_subtitle;
}

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString*)title subtitle:(NSString *)subtitle;

@end
