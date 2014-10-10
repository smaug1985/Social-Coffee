//
//  MapLocationVO.m
//  Business Listings Part 3
//
//  Created by Zack Ensign on 9/21/10.
//

#import "MapLocationVO.h"


@implementation MapLocationVO

@synthesize locationTitle, locationSnippet, mapLocation;

- (void)dealloc
{
	[super dealloc];
	[locationTitle release]; locationTitle = nil;
	[locationSnippet release]; locationSnippet = nil;
	[mapLocation release]; mapLocation = nil;
}

@end
