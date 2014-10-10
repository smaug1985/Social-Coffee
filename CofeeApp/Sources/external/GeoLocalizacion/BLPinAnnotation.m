//
//  BLPinAnnotation.m
//  Business Listings Part 3
//
//  Created by Zack Ensign on 9/21/10.
//

#import "BLPinAnnotation.h"
#import "BLAnnotation.h"

@implementation BLPinAnnotation

@synthesize titleLabel, subtitleLabel;

- (id)initWithAnnotation:(id )annotation reuseIdentifier:(NSString *)reuseIdentifier
{	
	self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
	
	// Create selected and un-selected pin images
	normalPin = [UIImage imageNamed:@"map_pin.png"];
	selectedPin = [UIImage imageNamed:@"selected_map_pin.png"];
	
	// Set current pin to unselected image
	self.image = normalPin;
	
	
	// cast annotation an our expected BLAnnotation
	
	BLAnnotation *blAnnotation = (BLAnnotation *)annotation;
	
	// create title label and size to text
	
	titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, 5, 280, 20)];
	titleLabel.text = blAnnotation.title;
	titleLabel.textAlignment = UITextAlignmentLeft;
	titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:13];
	titleLabel.textColor = [UIColor whiteColor];
	titleLabel.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.7];
    titleLabel.shadowOffset = CGSizeMake(0, -1.0);
	titleLabel.backgroundColor = [UIColor clearColor];
	titleLabel.lineBreakMode = UILineBreakModeWordWrap;
	titleLabel.numberOfLines = 3;

	CGSize titleLabelSize = [blAnnotation.title sizeWithFont: titleLabel.font constrainedToSize: CGSizeMake(280, 600) lineBreakMode: titleLabel.lineBreakMode];
	titleLabel.frame = CGRectMake(titleLabel.frame.origin.x, titleLabel.frame.origin.y, 280, titleLabelSize.height);

	// create subtitle label and size to text
	
	subtitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(45, titleLabel.frame.size.height + 5, 200, 20)];
	subtitleLabel.text = blAnnotation.subtitle;
	subtitleLabel.textAlignment = UITextAlignmentLeft;
	subtitleLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:11];
	subtitleLabel.textColor = [UIColor whiteColor];
	subtitleLabel.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.7];
    subtitleLabel.shadowOffset = CGSizeMake(0, -1.0);
	subtitleLabel.backgroundColor = [UIColor clearColor];
	subtitleLabel.lineBreakMode = UILineBreakModeWordWrap;
	subtitleLabel.numberOfLines = 5;
	
	CGSize subtitleLabelSize = [blAnnotation.subtitle sizeWithFont: subtitleLabel.font constrainedToSize: CGSizeMake(235, 600) lineBreakMode: subtitleLabel.lineBreakMode];
	subtitleLabel.frame = CGRectMake(subtitleLabel.frame.origin.x, subtitleLabel.frame.origin.y, subtitleLabelSize.width, subtitleLabelSize.height);
	
	
	
	// create callout view to be shown once a annotation view is selected
	
	//calloutView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 300, titleLabel.frame.size.height + subtitleLabel.frame.size.height+13)];
	calloutView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bocadillo.png"]];
	calloutView.hidden = YES;
	
	//[calloutView addSubview:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bocadillo.png"]]];
	[self addSubview:calloutView];
	
	
	
	
	/* // create rounded rect background and size to text
	UIImageView *backgroundRect = [[UIImageView alloc] initWithFrame: CGRectMake(0, 0, calloutView.frame.size.width, calloutView.frame.size.height)];
	[backgroundRect.image drawInRect:calloutView.frame];
	//UIImageView *backgroundRect = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bocadillo.png"]];
	//[backgroundRect.image drawInRect:calloutView.frame];
	
	UIGraphicsBeginImageContext(backgroundRect.frame.size);
	 
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	CGRect frame = calloutView.bounds;
	[[UIColor colorWithRed:.2 green:.2 blue:.2 alpha:1] set];
	CGPathRef roundedRectPath = [self roundedRectPath:frame radius:5];
	CGContextAddPath(ctx, roundedRectPath);
	CGContextFillPath(ctx);
	CGPathRelease(roundedRectPath);	
	
	backgroundRect.image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext(); 

	//[calloutView addSubview:backgroundRect];*/
	[calloutView addSubview:titleLabel];
	[calloutView addSubview:subtitleLabel];
	//[self setRightCalloutAccessoryView:[UIButton buttonWithType:UIButtonTypeDetailDisclosure]];
	// position callout above pin
	
	calloutView.frame = CGRectMake(-140, -calloutView.frame.size.height+10, calloutView.frame.size.width, calloutView.frame.size.height);
	//but.frame = 
//	[backgroundRect release]; backgroundRect = nil;
	
	return self;
}

- (CGPathRef) roundedRectPath:(CGRect)rect radius:(CGFloat)radius
{
	// generate rounded rect path
	
	CGMutablePathRef retPath = CGPathCreateMutable();
	
	CGRect innerRect = CGRectInset(rect, radius, radius);
	
	CGFloat inside_right = innerRect.origin.x + innerRect.size.width;
	CGFloat outside_right = rect.origin.x + rect.size.width;
	CGFloat inside_bottom = innerRect.origin.y + innerRect.size.height;
	CGFloat outside_bottom = rect.origin.y + rect.size.height;
	
	CGFloat inside_top = innerRect.origin.y;
	CGFloat outside_top = rect.origin.y;
	CGFloat outside_left = rect.origin.x;
	
	CGPathMoveToPoint(retPath, NULL, innerRect.origin.x, outside_top);
	
	CGPathAddLineToPoint(retPath, NULL, inside_right, outside_top);
	CGPathAddArcToPoint(retPath, NULL, outside_right, outside_top, outside_right, inside_top, radius);	
	CGPathAddLineToPoint(retPath, NULL, outside_right, inside_bottom);
	CGPathAddArcToPoint(retPath, NULL,  outside_right, outside_bottom, inside_right, outside_bottom, radius);
	
	CGPathAddLineToPoint(retPath, NULL, innerRect.origin.x, outside_bottom);
	CGPathAddArcToPoint(retPath, NULL,  outside_left, outside_bottom, outside_left, inside_bottom, radius);
	CGPathAddLineToPoint(retPath, NULL, outside_left, inside_top);
	CGPathAddArcToPoint(retPath, NULL,  outside_left, outside_top, innerRect.origin.x, outside_top, radius);
	
	CGPathCloseSubpath(retPath);
	
	return retPath;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
	// show/hide callout and swap pin image
	
	calloutView.hidden = !selected;
	
	self.image = !selected ? normalPin : selectedPin;
	self.selected = selected;
	// dispatch an event to alert app a pin has been selected
	
	 [[NSNotificationCenter defaultCenter] postNotificationName:@"annotationSelected" object:self];
}

-(void) dealloc
{
	[super dealloc];
	[calloutView release]; calloutView = nil;
	[titleLabel release]; titleLabel = nil;
	[subtitleLabel release]; subtitleLabel = nil;
}



@end
