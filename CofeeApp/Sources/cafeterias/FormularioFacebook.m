//
//  FormularioFacebook.m
//  CofeeApp
//
//  Created by gali on 16/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FormularioFacebook.h"


@implementation FormularioFacebook
@synthesize selectedPin,tv1,ini,fin,picker,dateIni,dateFin,isIni,label;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
		
    }
    return self;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];	
	
	
	[self.view setBackgroundColor:[UIColor colorWithRed:7/255.0 green:69/255.0 blue:144/255.0 alpha:255/255.0]];
	
	[self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"post",@"post") style:UIBarButtonItemStyleBordered target:self action:@selector(post)]];
	self.tv1.delegate = self;
	
	[self.picker addTarget:self action:@selector(valuChangePicker) forControlEvents:UIControlEventValueChanged];
	
	self.tv1.text = NSLocalizedString(@"cafe",@"cafe");
	[self.ini setTitle:NSLocalizedString(@"inicio",@"inicio") forState:UIControlStateNormal];
	[self.fin setTitle:NSLocalizedString(@"fin",@"fin") forState:UIControlStateNormal];
	[self.label setText:NSLocalizedString(@"fechaI",@"fechaI")];
	
	self.isIni = YES;
}

-(void) valuChangePicker{

	if (self.isIni == YES) {

		self.dateIni = self.picker.date;
		
	}else {
	
		self.dateFin = self.picker.date;
		
	}
	
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
	[self.selectedPin release];
	[self.tv1 release];
	[self.ini release];
	[self.fin release];
	[self.picker release];
	[self.dateIni release];
	[self.dateFin release];
	[self.label release];
    [super dealloc];
}


-(IBAction) fecInicio{
	self.isIni = YES;
	[self.label setText:NSLocalizedString(@"fechaI",@"fechaI")];
	[self.picker setDate:[NSDate date] animated:YES];
}


-(IBAction) fecFin{
	self.isIni = NO;
	[self.label setText:NSLocalizedString(@"fechaF",@"fechaF")];
	[self.picker setDate:[NSDate date] animated:YES];
}


-(IBAction) post {

	double timestampIni = [self.dateIni timeIntervalSince1970];
	double timestampFin = [self.dateFin timeIntervalSince1970];
	//int fechaInicial = [timestampIni unsignedIntValue];
	//int fechaFinal = [timestampFin unsignedIntValue];
	
	//NSLog(@"AQUIIIIIIIIIIIIII %f",timestampIni);
	
	[FacebookDataManager sharedData].delegate=self;
	//[[FacebookDataManager sharedData] createEventWhithPin:self.selectedPin description:self.tv1.text fecInit:@"2010-12-15T21:00:00" fecFin:@"2010-12-15T21:00:00"];
	[[FacebookDataManager sharedData] createEventWhithPin:self.selectedPin description:self.tv1.text fecInit:[NSString stringWithFormat:@"%f",timestampIni] fecFin:[NSString stringWithFormat:@"%f",timestampFin]];
	
}

#pragma mark FacebookDataManager protocol

-(void)showLoginDialog:(FBDialog *)dialog{
	
	[self presentModalViewController:dialog animated:YES];
	
}

-(void)loggedInSuccesfully{
	
	double timestampIni = [self.dateIni timeIntervalSince1970];
	double timestampFin = [self.dateFin timeIntervalSince1970];
	
	//[[FacebookDataManager sharedData] postImage:[self.capturedImages objectAtIndex:0] withMessage:self.txtPhoto.text];
	//[[FacebookDataManager sharedData] createEventWhithPin:self.selectedPin description:self.tv1.text fecInit:@"2010-12-15T21:00:00" fecFin:@"2010-12-15T21:00:00"];
	[[FacebookDataManager sharedData] createEventWhithPin:self.selectedPin description:self.tv1.text fecInit:[NSString stringWithFormat:@"%f",timestampIni] fecFin:[NSString stringWithFormat:@"%f",timestampFin]];
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

#pragma mark UITextViewDelegate

-(BOOL) textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
	
	if ([text isEqualToString:@"\n"]) {
		[textView resignFirstResponder];
	}
	
	return YES;
}
@end
