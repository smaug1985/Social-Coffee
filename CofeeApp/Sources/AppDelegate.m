/*
     File: AppDelegate.m 
 Abstract: The application delegate class used for installing our main navigation controller.
  
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

#import "AppDelegate.h"

@implementation AppDelegate;

@synthesize window, tabBarController1,tabBarController2, notifyCenter, photoVC, navBar,navBar2,navBar3,navBar4,navBar5,mainView,label1,label2;

- (void)applicationDidFinishLaunching:(UIApplication *)application
{
	UIColor *color = [UIColor colorWithRed:130/255.0 green:103/255.0 blue:42/255.0 alpha:255/255.0];
	[self.navBar setTintColor:color];
	[self.navBar2 setTintColor:color];
	[self.navBar3 setTintColor:color];
	[self.navBar4 setTintColor:color];
	[self.navBar5 setTintColor:color];
	
	self.photoVC = [[PhotoViewController alloc] initWithNibName:@"PhotoView" bundle:[NSBundle mainBundle]];
	
	self.notifyCenter = [NSNotificationCenter defaultCenter];
	[notifyCenter addObserver:self selector:@selector(trackNotifications:) name:nil object:nil];
	
	// create window and set up table view controller
	NSArray *array;
	UIViewController *controller;
	
	[self.tabBarController1.view setTag:2];
	array = self.tabBarController1.viewControllers;
	controller = [array objectAtIndex:0];
	controller.tabBarItem.title = NSLocalizedString(@"recipe",@"recipe");
	controller = [array objectAtIndex:1];
	controller.tabBarItem.title = NSLocalizedString(@"dibujos",@"dibujos");
	controller = [array objectAtIndex:2];
	controller.tabBarItem.title = NSLocalizedString(@"worldCafe",@"worldCafe");
	controller = [array objectAtIndex:3];
	controller.tabBarItem.title = NSLocalizedString(@"more",@"more");
	
	
	[self.tabBarController2.view setTag:3];
	array = self.tabBarController2.viewControllers;
	controller = [array objectAtIndex:0];
	controller.tabBarItem.title = NSLocalizedString(@"less",@"less");
	controller = [array objectAtIndex:1];
	controller.tabBarItem.title = NSLocalizedString(@"location",@"location");
	controller = [array objectAtIndex:2];
	controller.tabBarItem.title = NSLocalizedString(@"photo",@"photo");
	controller = [array objectAtIndex:3];
	controller.tabBarItem.title = NSLocalizedString(@"apps",@"apps");
	
	
	
	[self.mainView.view setBackgroundColor:[UIColor colorWithRed:214/255.0 green:195/255.0 blue:113/255.0 alpha:255/255.0]];
	self.mainView.view.tag = 1;
	[self.label1 setText:NSLocalizedString(@"label1",@"label1")];
	[self.label2 setText:NSLocalizedString(@"label2",@"label2")];
	
	[window addSubview:self.mainView.view];
	[window makeKeyAndVisible];
}

- (IBAction) publicar{
}

- (IBAction) entrar{

	[[window viewWithTag:1] removeFromSuperview];
	[window addSubview:self.tabBarController1.view];
	[window makeKeyAndVisible];
}

- (void)dealloc
{
	[navBar release];
	[navBar2 release];
	[navBar3 release];
	[navBar4 release];
	[navBar5 release];
	[tabBarController1 release];
	[tabBarController2 release];
    [window release];
	[mainView release];
	
    [super dealloc];
}

- (void) trackNotifications: (NSNotification *) notification{
	
	NSString *nName = [NSString stringWithString:[notification name]];
	//NSLog(@"%@",nName);
	id obj = [notification object];
	
	if([nName isEqual:@"photo"]){		
		for (UIView *v in [window subviews]) {
			self.photoVC.hidesBottomBarWhenPushed=YES;
			UINavigationController *recVC = [[self.tabBarController1 viewControllers] objectAtIndex:0];
			[recVC pushViewController:self.photoVC animated:YES];
		}
	}
	if ([nName isEqual:@"photo2"]) {
		for (UIView *v in [window subviews]) {
			self.photoVC.hidesBottomBarWhenPushed=YES;
			UINavigationController *recVC = [[self.tabBarController1 viewControllers] objectAtIndex:1];
			[recVC pushViewController:self.photoVC animated:YES];
		}
	}
	if ([nName isEqual:@"twitter"]) {
		for (UIView *v in [window subviews]) {
			OAuthTwitterDemoViewController *twitter = [[OAuthTwitterDemoViewController alloc] init];
			twitter.title = @"Twitter";
			
			UINavigationController *recVC = [[self.tabBarController1 viewControllers] objectAtIndex:0];
			[recVC pushViewController:twitter animated:YES];
		}
	}
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    // Recover the string
    if (!url) return NO;
	NSString *URLString = [url absoluteString];
	NSLog(@"got URL from flickr: %@", URLString);
	NSArray * tmp = [URLString componentsSeparatedByString:@"frob="];
	NSLog(@"got frob from flickr: %@", [tmp objectAtIndex:1]);
    // YOUR WORK HERE
	OFFlickrAPIRequest *request = [[OFFlickrAPIRequest alloc] initWithAPIContext:photoVC.context];
	
	// set the delegate, here we assume it's the controller that's creating the request object
	[request setDelegate:photoVC];
	//URLParser *parser = [[URLParser alloc] initWithCallbackDelegate:viewController];
	//NSString * tmp = [[NSString alloc] initWithContentsOfURL:url];
	[request callAPIMethodWithGET:@"flickr.auth.getToken" arguments:[NSDictionary dictionaryWithObjectsAndKeys:@"7ecd2e86650ed7d429d9473a0b6fbda3", @"api_key", [tmp objectAtIndex:1], @"frob",nil]];
	//[parser performSelector:@selector(gotToken:) forElementsMatching:@"token"];
	
	//[parser parseURL:url];
	
    return YES;
}

-(void) tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {

	if (viewController.tabBarItem.tag == 3) {
		if (tabBarController.view.tag == 2) {
			int selectedTag = 1;
			[[window viewWithTag:2] removeFromSuperview];
			[window addSubview:self.tabBarController2.view];
			[window makeKeyAndVisible];
			[tabBarController2 setSelectedIndex:selectedTag];
			NSArray *array = tabBarController2.viewControllers;
			UIViewController *controller = [array objectAtIndex:selectedTag];
			[tabBarController2 tabBar:tabBarController2.tabBar didSelectItem:controller.tabBarItem];
			[tabBarController2.tabBar setNeedsDisplay];
		}
	}
	
	if (viewController.tabBarItem.tag == 0) {
		if (tabBarController.view.tag == 3){
			int selectedTag = 2;
			[[window viewWithTag:3] removeFromSuperview];
			[window addSubview:self.tabBarController1.view];
			[window makeKeyAndVisible];
			[tabBarController1 setSelectedIndex:selectedTag];
			NSArray *array = tabBarController1.viewControllers;
			UIViewController *controller = [array objectAtIndex:selectedTag];
			[tabBarController1 tabBar:tabBarController1.tabBar didSelectItem:controller.tabBarItem];
			[tabBarController1.tabBar setNeedsDisplay];
			
		}
	}
	
}

@end
