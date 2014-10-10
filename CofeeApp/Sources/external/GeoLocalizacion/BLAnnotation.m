//
//  BLAnnotation.m
//  Business Listings Part 3
//
//  Created by Zack Ensign on 9/21/10.
//

#import "BLAnnotation.h"

@interface BLAnnotation ()

@property (nonatomic, retain) NSString *title;
@property (nonatomic, retain) NSString *subtitle;

@end

@implementation BLAnnotation

@synthesize coordinate = _coordinate;
@synthesize title = _title;
@synthesize subtitle = _subtitle;

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString*)title subtitle:(NSString *)subtitle
{
    if ((self = [super init]))
	{
		_coordinate = coordinate;
        _title = title;
		_subtitle = subtitle;
    }
    return self;
}

- (NSString *)title {
    return _title;
}

- (NSString *)subtitle
{
    return _subtitle;
}

- (void)dealloc {
    [_title release]; _title = nil;
	[_subtitle release]; _subtitle = nil;
    [super dealloc];
}

@end
