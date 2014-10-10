//
//  MapDataParser.m
//  Business Listings Part 3
//
//  Created by Zack Ensign on 9/21/10.
//

#import "MapDataParser.h"
#import "MapLocationVO.h"


@implementation MapDataParser 

@synthesize locationData;

-(void) getBusinessListingsByKeyword:(NSString *)keyword atLat:(float)lat atLng:(float)lng
{
	// Construct our maps call.
	NSString * urlString = [NSString stringWithFormat:@"http://maps.google.com/maps?q=%@&mrt=yp&sll=%g,%g&output=kml", [keyword stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding], lat, lng];
	[self parseXMLFileAtURL:urlString];
	NSLog(urlString);
}

- (void)parseXMLFileAtURL:(NSString *)URL
{	
	// parse file at url
	
	NSURL *xmlURL = [NSURL URLWithString:URL];
	
	mapsDataParser = [[NSXMLParser alloc] initWithContentsOfURL:xmlURL];
	mapsDataParser.delegate = self;
	[mapsDataParser setShouldProcessNamespaces:NO];
	[mapsDataParser setShouldReportNamespacePrefixes:NO];
	[mapsDataParser setShouldResolveExternalEntities:NO];
	
	[mapsDataParser parse];
}

- (void)parserDidStartDocument:(NSXMLParser *)parser
{
	// Parser has started so create locationData array to store MapLocation value objects
	
	if(self.locationData) 
	{
		[self.locationData removeAllObjects];
	}
	else
	{
		self.locationData = [[NSMutableArray alloc] init];
	}
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
	// Unable to reach the service, show error alert
	
	NSString * errorString = [NSString stringWithFormat:@"Unable to get map data. (Error code %@ )", [parseError localizedDescription]];
	UIAlertView * errorAlert = [[UIAlertView alloc] initWithTitle:@"Error loading content" message:errorString delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[errorAlert show];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"Placemark"])
    {
		// Placemark item found, prepare to save data to new MapLocationVO
		
		currentMapLocation = [[MapLocationVO alloc] init];
		isPlacemark = YES;
    }
	else
	{
		// Element other than Placemark found, store it for "foundCharacters" check
		
		[currentElementName release];
		currentElementName = nil;
		currentElementName = [[NSString alloc] initWithString:elementName];
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
	if ([elementName isEqualToString:@"Placemark"]) 
	{
		// Placemark element ended, store data
		
		isPlacemark = NO;
		
		[self.locationData addObject: currentMapLocation];
		NSLog(@"number of locations stored:%d",[locationData count]);
		[currentMapLocation release];
		currentMapLocation = nil;
	}	
} 

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
	if(isPlacemark)
	{		
		// If we are currently in a Placemark element, 
		// check if current is something we want to store
		
		if ([currentElementName isEqualToString:@"name"])
		{
			if(!currentMapLocation.locationTitle)
			{
				currentMapLocation.locationTitle = [[NSMutableString alloc] initWithString:string];
			}
			else
			{
				[currentMapLocation.locationTitle appendString: string];
			}
		}
		else if ([currentElementName isEqualToString:@"Snippet"]) 
		{
			// Replace line breaks with new line
			
			currentMapLocation.locationSnippet = [[NSMutableString alloc] initWithString:[string stringByReplacingOccurrencesOfString:@"<br/>" withString:@"\n"]];
		}
		else if ([currentElementName isEqualToString:@"coordinates"])
		{		
			// Create a coordinate array to use when allocating CLLocation.
			// We will use the CLLocation object later when populating the map
			
			NSArray *coordinatesList = [string componentsSeparatedByString:@","];
			currentMapLocation.mapLocation = [[CLLocation alloc] initWithLatitude:[[coordinatesList objectAtIndex:1] floatValue] longitude:[[coordinatesList objectAtIndex:0] floatValue]];
		}
	}
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{		
	// XML document is completely parsed, dispatch an event for app to handle data as needed
	
	[[NSNotificationCenter defaultCenter] postNotificationName:@"mapDataParseComplete" object:nil];
	[mapsDataParser release]; mapsDataParser = nil;
}

- (void)dealloc
{
	[super dealloc];
	
	mapsDataParser.delegate = nil;
	[mapsDataParser release]; mapsDataParser = nil;
	[currentMapLocation release]; currentMapLocation = nil;
	[locationData release]; locationData = nil;
}

@end
