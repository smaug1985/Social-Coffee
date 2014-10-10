//
//  FacebookDataManager.m
//  HoroscopoTarotChic
//
//  Created by ender on 11/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FacebookDataManager.h"
#import "BLPinAnnotation.h"


@implementation FacebookDataManager
@synthesize loginDialog = _loginDialog;
@synthesize loginDialogView = _loginDialogView;
@synthesize access_token;
@synthesize delegate;

static FacebookDataManager *sharedInstance;

+(void)initialize
{
	if (self == [FacebookDataManager class]) {
		sharedInstance = [[FacebookDataManager alloc] init];
	}
}


+(FacebookDataManager *) sharedData
{
	return sharedInstance;
}



//el método init inicializa y loguea
-(id) init{
	if (self= [super init]) {
		//8fa673a06891cac667e55d690e27ecbb
		//,user_photos
		NSString *appId = @"8fa673a06891cac667e55d690e27ecbb";
		NSString *permissions = @"publish_stream, user_photos, create_event";
				
		self.loginDialog = [[[FBDialog alloc] initWithAppId:appId 
									   requestedPermissions:permissions delegate:self] autorelease];
		self.loginDialogView = _loginDialog.view;
		
		
		
	}	
	return self;
	
}

-(void)login{
	
	
	
	
	
	

	
	[self refresh];
	
	
	
}


-(void) postWall{
	if (_loginState == LoginStateStartup || _loginState == LoginStateLoggedOut) {
		
		[_loginDialog login];
	} 
	else {
		[_loginDialog postToWall:@"Hola"];
	}
	
	
	
	
}

-(void) postImage:(UIImage *)image withMessage:(NSString *) message{
	if (_loginState == LoginStateStartup || _loginState == LoginStateLoggedOut) {
		
		[_loginDialog login];
	} 
	else {
		[[FacebookDataManager sharedData].loginDialog postImage:image withMessage:message];
	}
	
}

-(void) createEventWhithPin:(BLPinAnnotation *)pin description:(NSString *)des fecInit:(NSString *)fecin fecFin:(NSString *)fecfi {

	if (_loginState == LoginStateStartup || _loginState == LoginStateLoggedOut) {
		
		[_loginDialog login];
		//[[FacebookDataManager sharedData].loginDialog createEventFaceBook:pin];
	} 
	else {
		
		[[FacebookDataManager sharedData].loginDialog createEventFaceBookWhithPin:pin description:des fecInit:fecin fecFin:fecfi];
		//NSLog(@"AQUI ESTOIIIIIIII: %@", pin.titleLabel.text);
	}
	
}

/*
-(void) postTarot:(Tarot*)tarot{
	//[_loginDialog postToWallWithZodiaco:zodiaco];
	
	
	
}


*/



- (void)dealloc {
	self.loginDialog = nil;
    self.loginDialogView = nil;
    [super dealloc];
}


- (void)refresh {
    if (_loginState == LoginStateStartup || _loginState == LoginStateLoggedOut) {
		NSLog(@"Not connected to Facebook");
		// _loginStatusLabel.text = @"Not connected to Facebook";
        //[_loginButton setTitle:@"Login" forState:UIControlStateNormal];
        //_loginButton.hidden = NO;
    } else if (_loginState == LoginStateLoggingIn) {
		NSLog(@"Connecting to Facebook...");
		// _loginStatusLabel.text = @"Connecting to Facebook...";
        //_loginButton.hidden = YES;
    } else if (_loginState == LoginStateLoggedIn) {
		NSLog(@"Connected to Facebook");
		//  _loginStatusLabel.text = @"Connected to Facebook";
		// [_loginButton setTitle:@"Logout" forState:UIControlStateNormal];
		// _loginButton.hidden = NO;
    }   
}

- (IBAction)loginButtonTapped:(id)sender 
{
	
    	
}

- (void)accessTokenFound:(NSString *)accessToken {
	NSLog(@"Access token found: %@", accessToken);
    self.access_token = accessToken;
	_loginDialog.access_token =accessToken;
    _loginState = LoginStateLoggedIn;
	[self.delegate dismissLoginDialog];
	[self.delegate loggedInSuccesfully];
	
	//aqui va el mensaje de quitar el modal view controller
   // [self dismissModalViewControllerAnimated:YES];    
    //[self getFacebookProfile];
	//NSString *string = ;
	//[self getFacebookPhotoWithId:@"126948924021891"];
	//[_loginDialog postToWallWithZodiaco:zodiaco];
	
    [self refresh];
	
	//[self postZodiaco];
}

- (void)displayRequired {
    //[self presentModalViewController:_loginDialog animated:YES];
	//[[NSNotificationCenter defaultCenter] postNotificationName:@"facebook_dialog" object:_loginDialog];
	NSLog(@"display required!");
	[delegate showLoginDialog:self.loginDialog];
}

- (IBAction)closeTapped :(id)sender{
	[delegate dismissLoginDialog];
	
}


-(void) postToWallWithMessage:(NSString *) message
					 withName:(NSString *) name
				  withCaption:(NSString *) caption
			  withDescription:(NSString *) description
					 withLink:(NSString *) link

{
	
	if (_loginState == LoginStateStartup || _loginState == LoginStateLoggedOut) {
		
		[_loginDialog login];
	}
	else {
		
		[_loginDialog postToWallWithMessage:message withName:name withCaption:caption withDescription:description withLink:link];
	}
}




- (void)uploadingPhotoStartFBD{
	[delegate uploadingPhotoStart];
}

- (void)uploadingPhotoFinishFBD{
	[delegate uploadingPhotoFinish];
}

@end
