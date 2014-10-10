//
//  CustomModalView.m
//  HoroscopoTarotChic
//
//  Created by ender on 04/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CustomModalView.h"


@implementation CustomModalView


- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    rect.size.height -= 1;
    rect.size.width -= 1;
    
    const CGFloat RECT_PADDING = 8.0;
    rect = CGRectInset(rect, RECT_PADDING, RECT_PADDING);
    
    const CGFloat ROUND_RECT_CORNER_RADIUS = 5.0;
    CGPathRef roundRectPath =
	createRoundedRectForRect(CGRectMake(0, 0, 320, 480), ROUND_RECT_CORNER_RADIUS);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
	
    const CGFloat BACKGROUND_OPACITY = 0.3;
    CGContextSetRGBFillColor(context, 0, 0, 0, BACKGROUND_OPACITY);
    CGContextAddPath(context, roundRectPath);
    CGContextFillPath(context);
	
    const CGFloat STROKE_OPACITY = 0.25;
    CGContextSetRGBStrokeColor(context, 1, 1, 1, STROKE_OPACITY);
    CGContextAddPath(context, roundRectPath);
    CGContextStrokePath(context);
	
    CGPathRelease(roundRectPath);
}
- (void)dealloc {
    [super dealloc];
}


@end
