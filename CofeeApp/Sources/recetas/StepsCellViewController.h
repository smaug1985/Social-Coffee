//
//  StepsCellViewController.h
//  CofeeApp
//
//  Created by Fran Estrada on 13/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface StepsCellViewController : UITableViewCell {

	IBOutlet UILabel *lblNumber;
	IBOutlet UITextView *tvStep;
	
}

@property (nonatomic, retain) UILabel *lblNumber;
@property (nonatomic, retain) UITextView *tvStep;

@end
