//
//  OAuthTwitterDemoViewController.m
//  OAuthTwitterDemo
//
//  Created by Ben Gottlieb on 7/24/09.
//  Copyright Stand Alone, Inc. 2009. All rights reserved.
//

#import "OAuthTwitterDemoViewController.h"
#import "SA_OAuthTwitterEngine.h"
#import "AppDelegate.h"



#define kOAuthConsumerKey				@"oEK8teFX2CYTpWCoe06AWw"	
#define kOAuthConsumerSecret			@"8H075QCONSPYZkgYCXpYd1a7YIYvGuds0KSl7Ppg0SU"

@implementation OAuthTwitterDemoViewController

@synthesize textview;
@synthesize sendButton;


//=============================================================================================================================
#pragma mark SA_OAuthTwitterEngineDelegate
- (void) storeCachedTwitterOAuthData: (NSString *) data forUsername: (NSString *) username {
	NSUserDefaults			*defaults = [NSUserDefaults standardUserDefaults];

	[defaults setObject: data forKey: @"authData"];
	[defaults synchronize];
}

- (NSString *) cachedTwitterOAuthDataForUsername: (NSString *) username {
	return [[NSUserDefaults standardUserDefaults] objectForKey: @"authData"];
}

//=============================================================================================================================
#pragma mark SA_OAuthTwitterControllerDelegate
- (void) OAuthTwitterController: (SA_OAuthTwitterController *) controller authenticatedWithUsername: (NSString *) username {
	NSLog(@"Authenicated for %@", username);
	isAuthenticated = YES;
		sendButton.enabled = YES;
}

- (void) OAuthTwitterControllerFailed: (SA_OAuthTwitterController *) controller {
	isAuthenticated = NO;
	NSLog(@"Authentication Failed!");
		sendButton.enabled = NO;
}

- (void) OAuthTwitterControllerCanceled: (SA_OAuthTwitterController *) controller {
	NSLog(@"Authentication Canceled.");
}

//=============================================================================================================================
#pragma mark TwitterEngineDelegate
- (void) requestSucceeded: (NSString *) requestIdentifier {
	NSLog(@"Request %@ succeeded", requestIdentifier);
	isAuthenticated = YES;
	sendButton.enabled = YES;
}

- (void) requestFailed: (NSString *) requestIdentifier withError: (NSError *) error {
	NSString *errorDescription = [error description];
	if ([error code] == 403){
	 	NSLog(@"ERROR: Duplicate tweet!");
		errorDescription = @"ERROR: Duplicate tweet!";
	}
	UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error" message:errorDescription delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
	[alert release];
	//NSLog(@"Request %@ failed with error: %@", requestIdentifier, error);
}



//=============================================================================================================================
#pragma mark ViewController Stuff
- (void)dealloc {
	[_engine release];
    [super dealloc];
}
- (void) viewDidAppear: (BOOL)animated {
	if (_engine) return;
		_engine = [[SA_OAuthTwitterEngine alloc] initOAuthWithDelegate: self];
	_engine.consumerKey = kOAuthConsumerKey;
	_engine.consumerSecret = kOAuthConsumerSecret;
	
	UIViewController *controller = [SA_OAuthTwitterController controllerToEnterCredentialsWithTwitterEngine: _engine delegate: self];
	
	if (controller) 
		[self presentModalViewController: controller animated: YES];
	else {
		NSLog(@"Falla el tema de levantar el nib file");
		[_engine sendUpdate: [NSString stringWithFormat: @"Already Updated. %@", [NSDate date]]];
	}

}


-(IBAction) updateStatus{

	[textview resignFirstResponder];
	if(isAuthenticated){
		if([textview.text length] > 0){
			[_engine sendUpdate:[NSString stringWithFormat: textview.text]];
		}else{
			UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error" message:@"Insert some text to tweet" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alert show];
			[alert release];
			
		}

	}
		
	else{
		UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error" message:@"You must be logged to tweet" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		[alert show];
		[alert release];
	}

	
}

-(BOOL) textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
	
	if ([text isEqualToString:@"\n"]) {
		[textView resignFirstResponder];
	}
	
	return YES;
}

@end
