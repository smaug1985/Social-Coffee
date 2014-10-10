//
//  FBDialog.m
//  pizza
//
//  Created by ender on 15/09/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FBDialog.h"

@implementation FBDialog
@synthesize webView = _webView;
@synthesize apiKey = _apiKey;
@synthesize requestedPermissions = _requestedPermissions;
@synthesize delegate = _delegate;
@synthesize access_token;

- (id)initWithAppId:(NSString *)apiKey 
requestedPermissions:(NSString *)requestedPermissions 
		   delegate:(id<FBDialogDelegate>)delegate {
    if ((self = [super initWithNibName:@"FBDialog" 
								bundle:[NSBundle mainBundle]])) {
        self.apiKey = apiKey;
        self.requestedPermissions = requestedPermissions;
        self.delegate = delegate;
    }
    return self;    
}

- (void)dealloc {
    self.webView = nil;
    self.apiKey = nil;
    self.requestedPermissions = nil;
    [super dealloc];
}
- (void)login {
	
    [_webView loadRequest:
	 [NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];
	
    NSString *redirectUrlString = 
	@"http://www.facebook.com/connect/login_success.html";
    NSString *authFormatString = @"https://graph.facebook.com/oauth/authorize?client_id=%@&redirect_uri=%@&scope=%@&type=user_agent&display=touch";
	
    NSString *urlString = [NSString stringWithFormat:authFormatString, 
						   _apiKey, redirectUrlString, _requestedPermissions];
	urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlString];
	
	NSLog(urlString);
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
	_webView.delegate = self;
	
    [_webView loadRequest:request];	   
}

-(void)logout {    
    NSHTTPCookieStorage* cookies = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (NSHTTPCookie* cookie in 
		 [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]) {
        [cookies deleteCookie:cookie];
    }
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
	
    NSString *urlString = request.URL.absoluteString;
	
    [self checkForAccessToken:urlString];    
    [self checkLoginRequired:urlString];
	
    return TRUE;
}

-(void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
	NSLog(@"ERROR::::::::%&", [error localizedDescription]);
	
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
	NSLog(@"did finish load");
	
	//[_delegate displayRequired];

	
}

-(void)checkForAccessToken:(NSString *)urlString {
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression 
								  regularExpressionWithPattern:@"access_token=(.*)&" 
								  options:0 error:&error];
    if (regex != nil) {
        NSTextCheckingResult *firstMatch = 
		[regex firstMatchInString:urlString 
						  options:0 range:NSMakeRange(0, [urlString length])];
        if (firstMatch) {
            NSRange accessTokenRange = [firstMatch rangeAtIndex:1];
            NSString *accessToken = [urlString substringWithRange:accessTokenRange];
            accessToken = [accessToken 
						   stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            [_delegate accessTokenFound:accessToken];               
        }
    }
}


-(void) postImage:(UIImage *)image withMessage:(NSString *) message
{
	
	[_delegate uploadingPhotoStartFBD];
	
	NSURL *url = [NSURL URLWithString:@"https://graph.facebook.com/me/photos"];
    ASIFormDataRequest *newRequest = [ASIFormDataRequest requestWithURL:url];
    [newRequest setPostValue:message forKey:@"message"];
	
	
    [newRequest setPostValue:access_token forKey:@"access_token"];
    [newRequest setDidFinishSelector:@selector(postImageFinished:)];
	
	//===========
	NSData *picture_data = UIImagePNGRepresentation(image);
	//[body appendData:];
	//[body appendData:picture_data];
	
	//[newRequest appendPostData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"media\";\r\nfilename=\"media.png\"\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
	//[newRequest appendPostData:picture_data];
	[newRequest addData:picture_data forKey:@"picture"];
	
	//===============
    [newRequest setDelegate:self];
    [newRequest startAsynchronous];
	
	
	
	
}


-(void) postToWall:(NSString *)post {
	NSURL *url = [NSURL URLWithString:@"https://graph.facebook.com/me/feed"];
    ASIFormDataRequest *newRequest = [ASIFormDataRequest requestWithURL:url];
    //[newRequest setPostValue: forKey:@"message"];
    [newRequest setPostValue:@"4+Apps" forKey:@"name"];
    [newRequest setPostValue:@"Las cartas han hablado." forKey:@"caption"];
    [newRequest setPostValue:post forKey:@"description"];
    [newRequest setPostValue:@"http://www.4plusapps.com" forKey:@"link"];
	
    [newRequest setPostValue:access_token forKey:@"access_token"];
    [newRequest setDidFinishSelector:@selector(postToWallFinished:)];
	
    [newRequest setDelegate:self];
    [newRequest startAsynchronous];
	
	
	
	
}

-(void) createEventFaceBookWhithPin:(BLPinAnnotation *)pin description:(NSString *)des fecInit:(NSString *)fecin fecFin:(NSString *)fecfi {

	//NSString *event = [NSString stringWithFormat:@"{\"name\":\"A party\",\"start_time\":\"1215929160\",\"end_time\":\"1215929160\",\"location\":\"%@\"}",pin.titleLabel.text];
	//NSDictionary *params = [NSDictionary dictionaryWithObject:event forKey:@"event_info"];
	
	
	NSURL *url = [NSURL URLWithString:@"https://graph.facebook.com/me/events"];
    ASIFormDataRequest *newRequest = [ASIFormDataRequest requestWithURL:url];
	
	[newRequest setPostValue:fecfi forKey:@"end_time"];
	[newRequest setPostValue:fecin forKey:@"start_time"];
	
	[newRequest setPostValue:access_token forKey:@"access_token"];
	[newRequest setPostValue:@"SocialCafe" forKey:@"name"];
	[newRequest setPostValue:[NSString stringWithFormat:@"%@, %@",pin.titleLabel.text,pin.subtitleLabel.text] forKey:@"location"];
	[newRequest setPostValue:des forKey:@"description"];
	
	[newRequest setDidFinishSelector:@selector(createEventFinished:)];
	
    [newRequest setDelegate:self];
    [newRequest startAsynchronous];
}


- (UIImage *) captureScreen {
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    CGRect rect = [keyWindow bounds];
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [keyWindow.layer renderInContext:context];   
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}



- (void)postToWallFinished:(ASIHTTPRequest *)request
{
    NSString *responseString = [request responseString];
	NSLog(responseString);
    NSMutableDictionary *responseJSON = [responseString JSONValue];
    NSString *postId = [responseJSON objectForKey:@"id"];
	
    NSLog(@"Post id is: %@", postId);
	
    UIAlertView *av = [[[UIAlertView alloc] 
						initWithTitle:@"Sucessfully posted to wall!" 
						message:@"Check out your Facebook to see!"
						delegate:nil 
						cancelButtonTitle:@"OK"
						otherButtonTitles:nil] autorelease];
	[av show];
	
}

- (void)createEventFinished:(ASIHTTPRequest *)request {
	//NSLog(@"CREATE EVENTTTTTTTTTTTTTTTTTTTTTT");
	NSString *responseString = [request responseString];
	//NSLog(responseString);
    NSMutableDictionary *responseJSON = [responseString JSONValue];
    NSString *postId = [responseJSON objectForKey:@"id"];
	
    //NSLog(@"Post id is: %@", postId);
	
    UIAlertView *av = [[[UIAlertView alloc] 
						initWithTitle:@"Sucessfully create event!" 
						message:@"Check out your Facebook to see!"
						delegate:nil 
						cancelButtonTitle:@"OK"
						otherButtonTitles:nil] autorelease];
	[av show];
	
}

-(void)postImageFinished:(ASIHTTPRequest *)request{
	
	[_delegate uploadingPhotoFinishFBD];
	
	NSString *responseString = [request responseString];
	NSLog(responseString);
    NSMutableDictionary *responseJSON = [responseString JSONValue];
    NSNumber *postId = [responseJSON objectForKey:@"id"];
	
	NSString * iDString = [postId stringValue];
	
    NSLog(@"Post id is: %@", postId);
	
    UIAlertView *av = [[[UIAlertView alloc] 
						initWithTitle:@"Sucessfully posted to photos & wall!" 
						message:@"Check out your Facebook to see!"
						delegate:nil 
						cancelButtonTitle:@"OK"
						otherButtonTitles:nil] autorelease];
	//[av show];
	
	//FBViewController * fbvc = (FBViewController*)self.delegate;
	int n = [postId intValue];
	
	
	//[_delegate getFacebookPhotoWithId:iDString];
	

	
	
}






-(void)checkLoginRequired:(NSString *)urlString {
    NSLog(@"%@", urlString);
	if ([urlString rangeOfString:@"login.php"].location != NSNotFound) {
        [_delegate displayRequired];
    }
	
}

- (IBAction)closeTapped:(id)sender {
    [_delegate closeTapped:nil];
}



-(void) postToWallWithMessage:(NSString *) message
					 withName:(NSString *) name
				  withCaption:(NSString *) caption
			  withDescription:(NSString *) description
					 withLink:(NSString *) link

{
	NSURL *url = [NSURL URLWithString:@"https://graph.facebook.com/me/feed"];
	ASIFormDataRequest *newRequest = [ASIFormDataRequest requestWithURL:url];
	//[newRequest setPostValue: forKey:@"message"];
	[newRequest setPostValue:name forKey:@"name"];
	[newRequest setPostValue:caption forKey:@"caption"];
	[newRequest setPostValue:description forKey:@"description"];
	[newRequest setPostValue:link forKey:@"link"];
	
	
	[newRequest setPostValue:access_token forKey:@"access_token"];
	[newRequest setDidFinishSelector:@selector(postToWallFinished:)];
	
	[newRequest setDelegate:self];
	[newRequest startAsynchronous];
}

@end