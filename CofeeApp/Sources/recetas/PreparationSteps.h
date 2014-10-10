//
//  preparationSteps.h
//  CoffeeAPP
//
//  Created by gali on 10/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoViewController.h"
#import "CustomSeparatorViewController.h"
#import "StepsCellViewController.h"
#import "CoffeeTableHeader.h"

@interface PreparationSteps : UIViewController {

	IBOutlet CustomSeparatorViewController *separatorCell;
	IBOutlet StepsCellViewController *stepsCell;
	
	NSMutableArray *stepsArray;
	NSString *imgDetail;
	
}

@property (nonatomic, retain) NSMutableArray *stepsArray;
@property (nonatomic, retain) NSString *imgDetail;

-(void)takePhoto;

@end
