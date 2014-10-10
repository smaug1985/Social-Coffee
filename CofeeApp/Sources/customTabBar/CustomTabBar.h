//
//  CustomTabBar.h
//  deleteMe
//
//  Created by Borja Rubio Soler on 02/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CustomTabBar : UITabBar {
	UIColor *firstColor;
	UIColor *secondColor;
	UIImage *backgroundImage;
	int selected;
	NSArray *images;
}
@property(nonatomic,retain) UIColor *firstColor;
@property(nonatomic,retain) UIColor *secondColor;
@property(nonatomic,retain) UIImage *backgroundImage;
@property(nonatomic,assign) int selected;

@end
