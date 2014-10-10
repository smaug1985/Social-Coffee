//
//  OAuthTwitterDemoViewController.h
//  OAuthTwitterDemo
//
//  Created by Ben Gottlieb on 7/24/09.
//  Copyright Stand Alone, Inc. 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SA_OAuthTwitterController.h"

@class SA_OAuthTwitterEngine;


@interface OAuthTwitterDemoViewController : UIViewController <SA_OAuthTwitterControllerDelegate, UITextViewDelegate> {
	SA_OAuthTwitterEngine				*_engine;
	BOOL isAuthenticated;
	IBOutlet UITextView *textview;
	IBOutlet UIButton *sendButton;

}
@property (nonatomic, retain) UITextView *textview;
@property (nonatomic, retain) UIButton *sendButton;
-(IBAction) updateStatus;
@end

