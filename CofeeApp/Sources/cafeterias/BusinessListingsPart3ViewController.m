//
//  BusinessListingsPart3ViewController.m
//  Business Listings Part 3
//
//  Created by Zack Ensign on 9/21/10.
//

#import "BusinessListingsPart3ViewController.h"

@implementation BusinessListingsPart3ViewController
@synthesize searchBar,clear/*,post*/;
@synthesize selectedPin;

- (void)loadView {
	[super loadView];
	
	locationsMap = [[LocationsMap alloc] initWithFrame:CGRectMake(0, 30, 320, 480)];
	[self.view addSubview:locationsMap];
	[self.view sendSubviewToBack:locationsMap];
	
	[locationsMap findLocationsByKeyword:@"Cafeteria" ];
	
	
	self.searchBar.tintColor = [UIColor colorWithRed:130/255.0 green:103/255.0 blue:42/255.0 alpha:255/255.0];
	
	[self.clear setTitle:NSLocalizedString(@"clear",@"clear")];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(trackNotification:) name:nil object:nil];
	//[self.post setTitle:NSLocalizedString(@"post",@"post")];
	
	
	self.navigationItem.title = NSLocalizedString(@"location",@"location");
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
	[[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)dealloc {
    [super dealloc];
	[locationsMap release];
	locationsMap = nil;
	[self.searchBar release];
	[self.clear release];
	//[self.post release];
}

-(IBAction)removeBusinessAnnotations
{
	//	[self.navigationController pushViewController:face animated:YES];
	/*NSMutableArray * tmp = [[NSMutableArray alloc] init];
	for (UIView *annotation in locationsMap.myMapView.annotations) {
		if ([annotation isKindOfClass:[MKPinAnnotationView class]]) {
			[tmp addObject:annotation];
		}
	}*/
	
	[locationsMap removeBusinessAnnotations];
//	[locationsMap.myMapView addAnnotation:tmp];
	
	
}

/*-(IBAction)PostBusinessAnnotations{

}*/


#pragma mark UISearchBarDelegate
-(void)searchBarTextDidBeginEditing:(UISearchBar *)theSearchBar {
	theSearchBar.showsCancelButton = YES;
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)theSearchBar {
	theSearchBar.showsCancelButton = NO;
}

-(void)searchBar:(UISearchBar *)theSearchBar textDidChange:(NSString *) searchText {
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)theSearchBar {
	self.searchBar.text =@"";
	[self.searchBar resignFirstResponder];
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)theSearchBar {
	[locationsMap findLocationsByKeyword:self.searchBar.text];
	[self.searchBar resignFirstResponder];
	self.searchBar.text =@"";
}

-(BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
	return NO;
}

#pragma mark Notification methods

-(void)trackNotification:(NSNotification *)notification{
	
	NSString *nName = [NSString stringWithString:[notification name]];
	//NSLog(@"%@",nName);
	id obj = [notification object];
	
	if([nName isEqual:@"annotationSelected"]){

		BLPinAnnotation *tmpObject = (BLPinAnnotation *)obj;
		
		if (tmpObject.selected){
			if(selectedPin != obj && selectedPin != nil){
				twiceProtect = YES;
			}
			self.selectedPin = tmpObject;
			UIBarButtonItem *barButton = [[[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"post",@"post") style:UIBarButtonItemStyleBordered target:self action:@selector(postAction)] autorelease];
			self.navigationItem.rightBarButtonItem = barButton;
		}else{
			if(twiceProtect){
				twiceProtect = NO;
			}else{
				self.navigationItem.rightBarButtonItem = nil;
				self.selectedPin = nil;
			}
		}
		
	}
		
}
-(void)postAction{
	//NSLog(@"=========> Quedamos a tomar algo en %@",selectedPin.titleLabel.text);
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Desea publicar" message:@"Seleccione donde desea publicar su evento" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Facebook",@"Twitter",nil];
	//[alert setBackgroundColor:[UIColor colorWithRed:214/255.0 green:195/255.0 blue:113/255.0 alpha:1.0]];
	[alert show];
}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {

	if (buttonIndex == 1) {
		[self facebookButton];
	}else if (buttonIndex == 2) {
		[self twitterButton];
	}

	
}


-(void) twitterButton{

	OAuthTwitterDemoViewController *twitter = [[OAuthTwitterDemoViewController alloc] init];
	twitter.title = @"Twitter";
	[self.navigationController pushViewController:twitter animated:YES];
	
}



- (void) facebookButton{
	
	FormularioFacebook *fFb = [[FormularioFacebook alloc] initWithNibName:@"FormularioFacebook" bundle:[NSBundle mainBundle]]; 
	fFb.selectedPin = self.selectedPin;
	
	[self.navigationController pushViewController:fFb animated:YES];
	
}

@end
