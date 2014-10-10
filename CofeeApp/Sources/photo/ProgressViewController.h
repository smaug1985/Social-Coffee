//
//  ProgressViewController.h
//  PhotoPicker
//
//  Created by Fran on 15/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ProgressViewController : UIViewController {

	IBOutlet UIProgressView *progressBar;
	IBOutlet UILabel *lblUpload;
	IBOutlet UIActivityIndicatorView *activity;
	
	BOOL fb;
	
}

@property (nonatomic, retain) UIProgressView *progressBar;
@property (nonatomic, retain) UILabel *lblUpload;
@property (nonatomic, retain) UIActivityIndicatorView *activity;
@property (nonatomic, assign) BOOL fb;

@end
