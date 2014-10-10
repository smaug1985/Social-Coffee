//
//  DrawDetailViewController.h
//  CofeeApp
//
//  Created by Fran Estrada on 14/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomSeparatorViewController.h"
#import "StepsCellViewController.h"


@interface DrawDetailViewController : UITableViewController {

	IBOutlet CustomSeparatorViewController *separatorCell;
	IBOutlet StepsCellViewController *stepsCell;
	
	NSMutableArray *stepsArray;
	NSString *imgDetail;
	
}

@property (nonatomic, retain) NSMutableArray *stepsArray;
@property (nonatomic, retain) NSString *imgDetail;

@end
