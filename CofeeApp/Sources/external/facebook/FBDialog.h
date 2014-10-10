//
//  FBDialog.h
//  pizza
//
//  Created by ender on 15/09/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASIFormDataRequest.h"
#import "BLPinAnnotation.h"

@protocol FBDialogDelegate
- (void)accessTokenFound:(NSString *)accessToken;
- (void)displayRequired;
- (void)closeTapped;
- (void)uploadingPhotoStartFBD;
- (void)uploadingPhotoFinishFBD;
@end

@interface FBDialog : UIViewController <UIWebViewDelegate, ASIHTTPRequestDelegate> {
    UIWebView *_webView;
    NSString *_apiKey;
    NSString *_requestedPermissions;
    id <FBDialogDelegate> _delegate;
	NSString *access_token;
}

@property (retain) IBOutlet UIWebView *webView;
@property (copy) NSString *apiKey;
@property (nonatomic, retain) NSString *access_token;
@property (copy) NSString *requestedPermissions;
@property (assign) id <FBDialogDelegate> delegate;

- (id)initWithAppId:(NSString *)apiKey 
requestedPermissions:(NSString *)requestedPermissions 
		   delegate:(id<FBDialogDelegate>)delegate;
- (IBAction)closeTapped:(id)sender;
- (void)login;
- (void)logout;

-(void)checkForAccessToken:(NSString *)urlString;
-(void)checkLoginRequired:(NSString *)urlString;
- (IBAction)closeTapped:(id)sender;

-(void) createEventFaceBook:(BLPinAnnotation *)pin;

@end