//
//  myTabBar.m
//  deleteMe
//
//  Created by Borja Rubio Soler on 02/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CustomTabBar.h"
#import "Common.h"


@implementation CustomTabBar

@synthesize firstColor,secondColor,backgroundImage;
@synthesize selected;


-(id) initWithFrame:(CGRect)frame{
	if((self=[super initWithFrame:frame])){
		images = [NSArray arrayWithObjects:[UIImage imageNamed:@"tabBar1.png"],[UIImage imageNamed:@"tabBar2.png"],[UIImage imageNamed:@"tabBar3.png"],[UIImage imageNamed:@"tabBar4.png"],nil];
		selected = 0;
	}
	return self;
}
-(id) initWithCoder:(NSCoder *)aDecoder{
	
	NSLog(@"coder");
	if(([super initWithCoder:aDecoder])){

	images = [[NSArray arrayWithObjects:[UIImage imageNamed:@"tabBar1.png"],[UIImage imageNamed:@"tabBar2.png"],[UIImage imageNamed:@"tabBar3.png"],[UIImage imageNamed:@"tabBar4.png"],nil] retain];
	selected = 0;
	}
		return self;
}
-(id) init{
	
	NSLog(@"init");
	return [super init];
}
-(void) drawRect:(CGRect)rect{
	CGContextRef context = UIGraphicsGetCurrentContext();
	self.backgroundColor = [UIColor colorWithRed:214.0/255.0 green:195.0/255.0 blue:113.0/255.0 alpha:1.0];
	CGContextSetFillColorWithColor(context, self.backgroundColor.CGColor);
	CGContextFillRect(context, rect);
	backgroundImage = [images objectAtIndex:selected];
	[backgroundImage drawInRect:rect];
	/*
	if(backgroundImage==nil)
		drawGlossAndGradient(context, rect, firstColor.CGColor, secondColor.CGColor);	
	else{
		
	}
	 */
}
@end
