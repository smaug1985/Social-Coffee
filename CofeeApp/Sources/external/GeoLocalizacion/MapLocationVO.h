//
//  MapLocationVO.h
//  Business Listings Part 3
//
//  Created by Zack Ensign on 9/21/10.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MapLocationVO : NSObject {
	NSMutableString *locationTitle;
	NSMutableString *locationSnippet;
	CLLocation *mapLocation;
}

@property (nonatomic, retain) NSMutableString *locationTitle;
@property (nonatomic, retain) NSMutableString *locationSnippet;
@property (nonatomic, retain) CLLocation *mapLocation;

@end
