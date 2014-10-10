//
//  CoffeeTableHeader.h
//  CofeeApp
//
//  Created by Fran Estrada on 13/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "FacebookDataManager.h"
#import "OAuthTwitterDemoViewController.h"


@interface CoffeeTableHeader : UIViewController <FacebookDataManagerDelegate> {

	IBOutlet UILabel *lblCoffee;
	IBOutlet UIImageView *imgCoffee;
	
	NSString *strCoffee;
	NSString *strImgCoffee;
	
}

@property (nonatomic, retain) UILabel *lblCoffee;
@property (nonatomic, retain) UIImageView *imgCoffee;
@property (nonatomic, retain) NSString *strCoffee;
@property (nonatomic, retain) NSString *strImgCoffee;


-(IBAction) facebookButton;
-(IBAction) twitterButton;
@end
