//
//  MapDataParser.h
//  Business Listings Part 3
//
//  Created by Zack Ensign on 9/21/10.
//

#import <Foundation/Foundation.h>
#import "MapLocationVO.h"

@interface MapDataParser : NSObject <NSXMLParserDelegate>
{
	BOOL isPlacemark;
	
	NSXMLParser *mapsDataParser;
	NSMutableString *currentElementValue;
	NSMutableArray *locationData;
	MapLocationVO *currentMapLocation;
	NSMutableString	*currentElementName;
}

@property (nonatomic, retain) NSMutableArray *locationData;

-(void) getBusinessListingsByKeyword:(NSString *)keyword atLat:(float)lat atLng:(float)lng;
-(void) parseXMLFileAtURL:(NSString *)URL;

@end
