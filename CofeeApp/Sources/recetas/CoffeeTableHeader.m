//
//  CoffeeTableHeader.m
//  CofeeApp
//
//  Created by Fran Estrada on 13/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CoffeeTableHeader.h"


@implementation CoffeeTableHeader
@synthesize lblCoffee, imgCoffee, strCoffee, strImgCoffee;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	[FacebookDataManager sharedData].delegate=self;
	
	self.lblCoffee.textColor = [UIColor colorWithRed:123/255.0 green:80/255.0 blue:45/255.0 alpha:1.0];
	self.view.backgroundColor = [UIColor colorWithRed:214/255.0 green:195/255.0 blue:113/255.0 alpha:1.0];
	self.lblCoffee.text = strCoffee;
	self.imgCoffee.image = [UIImage imageNamed:self.strImgCoffee];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[self.lblCoffee release];
	[self.imgCoffee release];
	[self.strCoffee release];
	[self.strImgCoffee release];
    [super dealloc];
}


-(IBAction) facebookButton{

	NSString *name = @"4+Apps";
	NSString *caption = @"Social Café";
	NSString *description =NSLocalizedString(@"descriptionCafe",@"descriptionCafe");
	NSString *link = @"http://4plusapps.com/";
	
	[[FacebookDataManager sharedData] postToWallWithMessage:nil withName:name withCaption:caption withDescription:description withLink:link];
	//[[FacebookDataManager sharedData] createEventWhithPin:self.selectedPin description:self.tv1.text fecInit:self.tf1.text fecFin:self.tf2.text];
}

-(IBAction) twitterButton{

	[[NSNotificationCenter defaultCenter] postNotificationName:@"twitter" object:@""];
}

#pragma mark FacebookDataManager protocol

-(void)showLoginDialog:(FBDialog *)dialog{
	
	[self presentModalViewController:dialog animated:YES];
	
}

-(void)loggedInSuccesfully{
	
	NSString *name = @"4+Apps";
	NSString *caption = @"Social Café";
	NSString *description = NSLocalizedString(@"descriptionCafe",@"descriptionCafe");
	NSString *link = @"http://4plusapps.com/";
	
	[[FacebookDataManager sharedData] postToWallWithMessage:nil withName:name withCaption:caption withDescription:description withLink:link];
	[self dismissLoginDialog];
	
}

-(void)dismissLoginDialog{
	
	[self dismissModalViewControllerAnimated:YES];
	
}

+ (id)loadingView: (UIView *) aView inView:(UIView *)aSuperview
{
	
	
	aView.opaque = NO;
	aView.autoresizingMask =
	UIViewAutoresizingFlexibleWidth |
	UIViewAutoresizingFlexibleHeight;
	[aSuperview addSubview:aView];
	
	// Code to create and configure the label and activity view goes here.
	// Download the sample project to see it.
	
	// Set up the fade-in animation
	CATransition *animation = [CATransition animation];
	[animation setType:kCATransitionFade];
	//[animation setSubtype:kCATransitionFromTop];
	[animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn]];
	[animation setSpeed:0.7];
	[[aSuperview layer] addAnimation:animation forKey:@"layerAnimation"];
	
	return aView;
}


@end
