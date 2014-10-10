//
//  CustomTabBarController.h
//  CofeeApp
//
//  Created by Borja Rubio Soler on 13/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CustomTabBarController : UITabBarController {
	
	NSArray *setOne;
	NSArray *setTwo;
	BOOL isSetOne;
}
@property (nonatomic,retain) NSArray *setOne;
@property (nonatomic,retain) NSArray *setTwo;


@end
