//
//  FacebookDataManager.h
//  HoroscopoTarotChic
//
//  Created by ender on 11/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//
typedef enum {
    LoginStateStartup,
    LoginStateLoggingIn,
    LoginStateLoggedIn,
    LoginStateLoggedOut
} LoginState;

#import <Foundation/Foundation.h>
#import "FBDialog.h"
#import "BLPinAnnotation.h"

@protocol FacebookDataManagerDelegate

-(void)showLoginDialog:(FBDialog *)dialog;
-(void)loggedInSuccesfully;
-(void)dismissLoginDialog;
-(void)uploadingPhotoStart;
-(void)uploadingPhotoFinish;
@end



@interface FacebookDataManager : NSObject <FBDialogDelegate, ASIHTTPRequestDelegate> {

	//facebook properties
	LoginState _loginState;
    FBDialog *_loginDialog;
    UIView *_loginDialogView;
	NSString *access_token;
	id <FacebookDataManagerDelegate> delegate;

	
	
}

@property (retain) FBDialog *loginDialog;
@property (retain) IBOutlet UIView *loginDialogView;
@property (nonatomic, retain) NSString *access_token;
@property (nonatomic, retain) id <FacebookDataManagerDelegate> delegate;
-(void) postToWallWithMessage:(NSString *) message withName:(NSString *) name withCaption:(NSString *) caption withDescription:(NSString *) description withLink:(NSString *) link;


+(FacebookDataManager *) sharedData;

@end
