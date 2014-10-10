//
//  Recipes.h
//  CoffeeAPP
//
//  Created by gali on 10/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomFooter.h"
#import "CustomCellBackground.h"
#import "CustomHeader.h"
#import "PreparationSteps.h"
#import "CoffeeCellViewController.h"

@interface Recipes : UIViewController {

	IBOutlet CoffeeCellViewController *coffeeCell;
	NSMutableArray *recipesArray;
	
}

@property (nonatomic, retain) NSMutableArray *recipesArray;

@end
