/*
     File: MyViewController.m 
 Abstract: The main view controller of this app.
  
  Version: 1.0 
  
 Disclaimer: IMPORTANT:  This Apple software is supplied to you by Apple 
 Inc. ("Apple") in consideration of your agreement to the following 
 terms, and your use, installation, modification or redistribution of 
 this Apple software constitutes acceptance of these terms.  If you do 
 not agree with these terms, please do not use, install, modify or 
 redistribute this Apple software. 
  
 In consideration of your agreement to abide by the following terms, and 
 subject to these terms, Apple grants you a personal, non-exclusive 
 license, under Apple's copyrights in this original Apple software (the 
 "Apple Software"), to use, reproduce, modify and redistribute the Apple 
 Software, with or without modifications, in source and/or binary forms; 
 provided that if you redistribute the Apple Software in its entirety and 
 without modifications, you must retain this notice and the following 
 text and disclaimers in all such redistributions of the Apple Software. 
 Neither the name, trademarks, service marks or logos of Apple Inc. may 
 be used to endorse or promote products derived from the Apple Software 
 without specific prior written permission from Apple.  Except as 
 expressly stated in this notice, no other rights or licenses, express or 
 implied, are granted by Apple herein, including but not limited to any 
 patent rights that may be infringed by your derivative works or by other 
 works in which the Apple Software may be incorporated. 
  
 The Apple Software is provided by Apple on an "AS IS" basis.  APPLE 
 MAKES NO WARRANTIES, EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION 
 THE IMPLIED WARRANTIES OF NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS 
 FOR A PARTICULAR PURPOSE, REGARDING THE APPLE SOFTWARE OR ITS USE AND 
 OPERATION ALONE OR IN COMBINATION WITH YOUR PRODUCTS. 
  
 IN NO EVENT SHALL APPLE BE LIABLE FOR ANY SPECIAL, INDIRECT, INCIDENTAL 
 OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
 SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
 INTERRUPTION) ARISING IN ANY WAY OUT OF THE USE, REPRODUCTION, 
 MODIFICATION AND/OR DISTRIBUTION OF THE APPLE SOFTWARE, HOWEVER CAUSED 
 AND WHETHER UNDER THEORY OF CONTRACT, TORT (INCLUDING NEGLIGENCE), 
 STRICT LIABILITY OR OTHERWISE, EVEN IF APPLE HAS BEEN ADVISED OF THE 
 POSSIBILITY OF SUCH DAMAGE. 
  
 Copyright (C) 2010 Apple Inc. All Rights Reserved. 
  
 */

#import "PhotoViewController.h"

@implementation PhotoViewController

@synthesize imageView, myToolbar, txtPhoto, overlayViewController, capturedImages, context;
@synthesize progressVC;


#pragma mark -
#pragma mark View Controller

- (void)viewDidLoad
{
	
    self.capturedImages = [NSMutableArray array];
	
	// save button
	UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] 
								   initWithBarButtonSystemItem:UIBarButtonSystemItemSave
								   target:self
								   action:@selector(saveImage)];
	
	[[self navigationItem] setRightBarButtonItem:saveButton];
	

    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        // camera is not on this device, don't show the camera button
        NSMutableArray *toolbarItems = [NSMutableArray arrayWithCapacity:self.myToolbar.items.count];
        [toolbarItems addObjectsFromArray:self.myToolbar.items];
        [toolbarItems removeObjectAtIndex:4];
        [self.myToolbar setItems:toolbarItems animated:NO];
    }
	
	if (self.imageView.image == nil) {
		//NSLog(@"niiiiiiiiiiil!!");
		
		UIBarButtonItem *b = [[self.myToolbar items] objectAtIndex:2];
		b.enabled=NO;
		b = [[self.myToolbar items] objectAtIndex:3];
		b.enabled=NO;
		
		saveButton.enabled=NO;
		
	}
	
	[saveButton release];
	
	self.txtPhoto.delegate = self;
	
	self.progressVC = [[ProgressViewController alloc] initWithNibName:@"ProgressViewController" bundle:[NSBundle mainBundle]];
}

- (void)viewDidUnload
{
    self.imageView = nil;
    self.myToolbar = nil;
	self.txtPhoto = nil;
    
    self.overlayViewController = nil;
    self.capturedImages = nil;
	
}

- (void) viewWillDisappear:(BOOL)animated {

	[self.capturedImages removeAllObjects];
	self.txtPhoto.text = @"";
	self.txtPhoto.hidden = YES;
	self.imageView.image = nil;
	
	
	UIBarButtonItem *b = [[self.myToolbar items] objectAtIndex:2];
	b.enabled=NO;
	b = [[self.myToolbar items] objectAtIndex:3];
	b.enabled=NO;
	
	[[self navigationItem] rightBarButtonItem].enabled=NO;
	
}

- (void)dealloc
{	
	[imageView release];
	[myToolbar release];
	[txtPhoto release];
    
    [overlayViewController release];
	[capturedImages release];
	
	[progressVC release];
	
    [super dealloc];
}

-(void) inicializar {

	self.overlayViewController =
	[[[OverlayViewController alloc] initWithNibName:@"OverlayViewController" bundle:nil] autorelease];
	
	// as a delegate we will be notified when pictures are taken and when to dismiss the image picker
	self.overlayViewController.delegate = self;
	
}

-(id) initWithCoder:(NSCoder *)aDecoder {

	if ([super initWithCoder:aDecoder]) {
		
		[self inicializar];
		
	}
	
	return self;
	
}


- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
	
	if ([super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		
		[self inicializar];
		
	}
	
	return self;
	
}


- (void)saveImage{

	// save Image
	UIImageWriteToSavedPhotosAlbum([self.capturedImages objectAtIndex:0], nil, nil, nil);
	
	// alertView for result
	UIAlertView* alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"La foto se guardó correctamente en la biblioteca." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alertView show];
	[alertView release];
	
	// disable save button
	[[self navigationItem] rightBarButtonItem].enabled=NO;

}


#pragma mark -
#pragma mark Toolbar Actions

- (void)showImagePicker:(UIImagePickerControllerSourceType)sourceType
{
    if (self.imageView.isAnimating)
        self.imageView.stopAnimating;
	
    if (self.capturedImages.count > 0)
        [self.capturedImages removeAllObjects];
    
    if ([UIImagePickerController isSourceTypeAvailable:sourceType])
    {
        [self.overlayViewController setupImagePicker:sourceType];
        [self presentModalViewController:self.overlayViewController.imagePickerController animated:YES];
    }
}

- (IBAction)photoLibraryAction:(id)sender
{   
	[self showImagePicker:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (IBAction)cameraAction:(id)sender
{
    [self showImagePicker:UIImagePickerControllerSourceTypeCamera];
}


#pragma mark -
#pragma mark OverlayViewControllerDelegate

// as a delegate we are being told a picture was taken
- (void)didTakePicture:(UIImage *)picture
{
    [self.capturedImages addObject:picture];
}

// as a delegate we are told to finished with the camera
- (void)didFinishWithCamera
{
    [self dismissModalViewControllerAnimated:YES];
    
	
    if ([self.capturedImages count] > 0){
		
		UIBarButtonItem *b = [[self.myToolbar items] objectAtIndex:2];
		b.enabled=YES;
		b = [[self.myToolbar items] objectAtIndex:3];
		b.enabled=YES;
		
		[[self navigationItem] rightBarButtonItem].enabled=YES;
		
        if ([self.capturedImages count] == 1){
	
            // we took a single shot
            [self.imageView setImage:[self.capturedImages objectAtIndex:0]];
			
			self.txtPhoto.hidden = NO;
	
        }
    }
	
}

-(NSString *) gotToken:(Element *) aToken{
	NSLog(@"got auth token: %@", [aToken contentsText]);
	[context setAuthToken:[aToken contentsText]];
	return nil;
}

#pragma mark image upload methods

-(IBAction) uploadImage:(UIImage *)img
{
	
	[self startUpload:img];
	
	[self.view addSubview:[PhotoViewController loadingView:self.progressVC.view inView:self.view]];
	
}

- (void)startUpload:(UIImage *)image
{
	
    NSData *JPEGData = UIImageJPEGRepresentation(image, 1.0);
    OFFlickrAPIRequest *request = [[OFFlickrAPIRequest alloc] initWithAPIContext:context];
	[request setDelegate:self];
	//snapPictureButton.enabled = NO;
	//snapPictureDescriptionLabel.text = @"Uploading";
	
    request.sessionInfo = @"kUploadImageStep";
    [request uploadImageStream:[NSInputStream inputStreamWithData:JPEGData] suggestedFilename:self.txtPhoto.text MIMEType:@"image/jpeg" arguments:[NSDictionary dictionaryWithObjectsAndKeys:@"0", @"is_public", nil]];
	
	[UIApplication sharedApplication].idleTimerDisabled = YES;
	//[self updateUserInterface:nil];
	NSLog(@"uploading photo...%@",@".");
}


#pragma mark flickr request delegate methods

- (void)flickrAPIRequest:(OFFlickrAPIRequest *)inRequest didCompleteWithResponse:(NSDictionary *)inResponseDictionary{
	NSLog(@"did complete response %@",inResponseDictionary);
	
	id token = [[inResponseDictionary objectForKey:@"auth"] objectForKey:@"token"];
	NSString * tokenString = [token objectForKey:@"_text"];
	if (tokenString) {
		NSLog(@"found TOKEN!: %@", tokenString );
		[context setAuthToken:tokenString];
		[self uploadImage:[self.capturedImages objectAtIndex:0]];
	}
	
	
	
}
- (void)flickrAPIRequest:(OFFlickrAPIRequest *)inRequest didFailWithError:(NSError *)inError{
	NSLog(@"did fail with error: %@", inError);
	
}
- (void)flickrAPIRequest:(OFFlickrAPIRequest *)inRequest imageUploadSentBytes:(NSUInteger)inSentBytes totalBytes:(NSUInteger)inTotalBytes{
	
	//self.progressBar.hidden = NO;
	float progress = (inSentBytes*100)/inTotalBytes;
	//NSLog(@"%f", progress);
	self.progressVC.progressBar.hidden = NO;
	self.progressVC.progressBar.progress = progress/100;
	
	//self.lblUpload.hidden = NO;
	
	NSLog(@"image uploaded succesfully. Sent bytes: %u of total bytes: %u", inSentBytes, inTotalBytes);
	
	if(progress==100){
		self.progressVC.progressBar.hidden = YES;
		self.progressVC.progressBar.progress = 0.0;
		[self.progressVC.view removeFromSuperview];
	}
	
}

- (void) flickrButton{

	if (context.authToken==nil) {
		
		context = [[OFFlickrAPIContext alloc] initWithAPIKey:@"7ecd2e86650ed7d429d9473a0b6fbda3" sharedSecret:@"2f058ed8b70422fd"];
		
		NSURL *loginURL = [context loginURLFromFrobDictionary:nil requestedPermission:OFFlickrWritePermission];
		[[UIApplication sharedApplication] openURL:loginURL];
	
	}else{
		
		[self uploadImage:[self.capturedImages objectAtIndex:0]];
		
	}

	
}

- (IBAction) facebookButton{

	[FacebookDataManager sharedData].delegate=self;
	[[FacebookDataManager sharedData] postImage:[self.capturedImages objectAtIndex:0] withMessage:self.txtPhoto.text];

}

#pragma mark FacebookDataManager protocol

-(void)showLoginDialog:(FBDialog *)dialog{

	[self presentModalViewController:dialog animated:YES];
	
}

-(void)loggedInSuccesfully{

	[[FacebookDataManager sharedData] postImage:[self.capturedImages objectAtIndex:0] withMessage:self.txtPhoto.text];
	[self dismissLoginDialog];
	
}

-(void)dismissLoginDialog{

	[self dismissModalViewControllerAnimated:YES];
	
}

- (void)uploadingPhotoStart{

	[self.view addSubview:[PhotoViewController loadingView:self.progressVC.view inView:self.view]];
	self.progressVC.activity.hidden = NO;
	[self.progressVC.activity startAnimating];
	
}

- (void)uploadingPhotoFinish{

	[self.progressVC.activity stopAnimating];
	self.progressVC.activity.hidden = YES;
	
	[self.progressVC.view removeFromSuperview];
	
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

#pragma mark UITextFieldDelegate

- (BOOL) textFieldShouldReturn:(UITextField *)textField{

	[textField resignFirstResponder];
	return YES;

}

@end