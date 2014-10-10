//
//  CustomCellBackground.m
//  CoolTable
//
//  Created by Ray Wenderlich on 9/29/10.
//  Copyright 2010 Ray Wenderlich. All rights reserved.
//

#import "CustomCellBackground.h"
#import "Common.h"

@implementation CustomCellBackground
@synthesize lastCell = _lastCell;
@synthesize selected = _selected;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGColorRef whiteColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0].CGColor; 
    CGColorRef lightGrayColor = [UIColor colorWithRed:230.0/255.0 green:230.0/255.0 blue:230.0/255.0 alpha:1.0].CGColor;
    CGColorRef redColor = [UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0].CGColor;
    CGColorRef separatorColor = [UIColor colorWithRed:208.0/255.0 green:208.0/255.0 blue:208.0/255.0 alpha:1.0].CGColor;
    CGColorRef mistyRose = [UIColor colorWithRed:255/255.0 green:228/255.0 blue:225/255.0 alpha:1.0].CGColor;
    
	CGColorRef lightBrown = [UIColor colorWithRed:192/255.0 green:163/255.0 blue:97/255.0 alpha:1.0].CGColor;
	
	//CGColorRef browColor = [UIColor colorWithRed:130/255.0 green:103/255.0 blue:42/255.0 alpha:255/255.0];
	
	CGRect paperRect = self.bounds;

    // Fill with gradient
    if (_selected) {
        drawLinearGradient(context, paperRect, mistyRose, separatorColor);
    } else {
        drawLinearGradient(context, paperRect, whiteColor, lightBrown);
    }
    
    if (!_lastCell) {
        // Add white 1 px stroke
        CGRect strokeRect = paperRect;
        strokeRect.size.height -= 1;
        strokeRect = rectFor1PxStroke(strokeRect);

        CGContextSetStrokeColorWithColor(context, whiteColor);
        CGContextSetLineWidth(context, 1.0);
        CGContextStrokeRect(context, strokeRect);
        
        // Add separator
        CGPoint startPoint = CGPointMake(paperRect.origin.x, paperRect.origin.y + paperRect.size.height - 1);
        CGPoint endPoint = CGPointMake(paperRect.origin.x + paperRect.size.width - 1, paperRect.origin.y + paperRect.size.height - 1);
        draw1PxStroke(context, startPoint, endPoint, separatorColor); 
        
    } else {
     
        CGContextSetStrokeColorWithColor(context, whiteColor);
        CGContextSetLineWidth(context, 1.0);
        
        CGPoint pointA = CGPointMake(paperRect.origin.x, paperRect.origin.y + paperRect.size.height - 1);
        CGPoint pointB = CGPointMake(paperRect.origin.x, paperRect.origin.y);
        CGPoint pointC = CGPointMake(paperRect.origin.x + paperRect.size.width - 1, paperRect.origin.y);
        CGPoint pointD = CGPointMake(paperRect.origin.x + paperRect.size.width - 1, paperRect.origin.y + paperRect.size.height - 1);
        
        draw1PxStroke(context, pointA, pointB, whiteColor);
        draw1PxStroke(context, pointB, pointC, whiteColor);
        draw1PxStroke(context, pointC, pointD, whiteColor);
        
    }
    
}

- (void)dealloc {
    [super dealloc];
}


@end
