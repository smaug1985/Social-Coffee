//
//  WorldCoffees.m
//  CofeeApp
//
//  Created by Borja Rubio Soler on 13/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "WorldCoffees.h"
#import "WorldCoffeesDetail.h"

@implementation WorldCoffees

@synthesize northAmericaLabel,europeLabel,asiaLabel,southAmericaLabel,africaLabel;
@synthesize oceaniaLabel,worldCoffeeLabel,description, contents;
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
	
	// Textos Localizados
	northAmericaLabel.text = NSLocalizedString(@"northAmerica",@"");
	europeLabel.text = NSLocalizedString(@"europe",@"");
	asiaLabel.text = NSLocalizedString(@"asia",@"");
	southAmericaLabel.text = NSLocalizedString(@"southAmerica",@"");
	africaLabel.text = NSLocalizedString(@"africa",@"");
	oceaniaLabel.text = NSLocalizedString(@"oceania",@"");
	worldCoffeeLabel.text = NSLocalizedString(@"worldCoffees",@"");
	description.text = NSLocalizedString(@"mainDescription",@"");
	
	self.contents = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"worldCoffees" ofType:@"plist"] ];

	self.navigationItem.title = NSLocalizedString(@"worldCoffees",@"");
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
	self.northAmericaLabel = nil;
	self.europeLabel = nil;
	self.asiaLabel= nil;
	self.southAmericaLabel= nil;
	self.africaLabel= nil;
	self.oceaniaLabel= nil;
	self.worldCoffeeLabel= nil;
	self.description= nil;
	self.contents = nil;
    [super dealloc];
}

-(IBAction) buttonPressed:(id)sender{
	
	UIButton *button = (UIButton *) sender;
	int tag = button.tag;
	if(tag>=0 && tag < [contents count]){
		NSDictionary *dict = [self.contents objectAtIndex:tag];
		WorldCoffeesDetail *vc = [[[WorldCoffeesDetail alloc] initWithNibName:@"WorldCoffeesDetail" bundle:[NSBundle mainBundle]] autorelease];
		vc.descriptionCoffee= [dict objectForKey:@"description"];
		vc.imageCoffee = [dict objectForKey:@"image"];
		vc.titleCoffee = [dict objectForKey:@"name"];
		//[self.navigationItem setBackBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:<#(id)target#> action:<#(SEL)action#>]]
		[self.navigationController pushViewController:vc animated:YES];
	}
		
}

@end
