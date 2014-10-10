//
//  BusinessListingsPart3ViewController.h
//  Business Listings Part 3
//
//  Created by Zack Ensign on 9/21/10.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "LocationsMap.h"
#import "BLPinAnnotation.h"
#import "BLAnnotation.h"
#import "FormularioFacebook.h"
#import "OAuthTwitterDemoViewController.h"

@interface BusinessListingsPart3ViewController : UIViewController <UISearchBarDelegate, UIAlertViewDelegate> {
	LocationsMap *locationsMap;
	UISearchBar *searchBar;
	UIBarButtonItem *clear;
	BLPinAnnotation *selectedPin;
	BOOL twiceProtect;
	//UIBarButtonItem *post;
}

@property (nonatomic,retain) IBOutlet UISearchBar *searchBar;
@property (nonatomic,retain) IBOutlet UIBarButtonItem *clear;
@property (nonatomic,retain) BLPinAnnotation *selectedPin;
//@property (nonatomic,retain) IBOutlet UIBarButtonItem *post;

-(IBAction)removeBusinessAnnotations;
//-(IBAction)PostBusinessAnnotations;
@end

