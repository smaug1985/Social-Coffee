//
//  DrawsTableViewController.h
//  CofeeApp
//
//  Created by Fran Estrada on 14/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoffeeCellViewController.h"
#import "DrawDetailViewController.h"


@interface DrawsTableViewController : UITableViewController {

	IBOutlet CoffeeCellViewController *coffeeCell;
	NSMutableArray *drawsArray;
	
}

@property (nonatomic, retain) NSMutableArray *drawsArray;

@end
