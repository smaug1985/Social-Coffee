//
//  WorldCoffeesDetail.m
//  CofeeApp
//
//  Created by Borja Rubio Soler on 13/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "WorldCoffeesDetail.h"


@implementation WorldCoffeesDetail
@synthesize titleCoffee,descriptionCoffee,imageCoffee;
@synthesize mainLabel,description,imageView;

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
	
	self.view.backgroundColor = [UIColor colorWithRed:214/255.0 green:195/255.0 blue:113/255.0 alpha:1.0];
	
	self.description.text = descriptionCoffee;
	self.imageView.image = [UIImage imageNamed:imageCoffee];
	self.mainLabel.text = titleCoffee;
	self.navigationItem.title = titleCoffee;
	
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
	self.mainLabel = nil;
	self.description = nil;
	self.imageView = nil;
	self.titleCoffee = nil;
	self.descriptionCoffee = nil;
	self.imageCoffee = nil;
    [super dealloc];
}


@end
