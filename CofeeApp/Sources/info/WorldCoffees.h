//
//  WorldCoffees.h
//  CofeeApp
//
//  Created by Borja Rubio Soler on 13/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WorldCoffees : UIViewController {
	
	UILabel *northAmericaLabel;
	UILabel *europeLabel;
	UILabel *asiaLabel;
	UILabel *southAmericaLabel;
	UILabel *africaLabel;
	UILabel *oceaniaLabel;
	UILabel *worldCoffeeLabel;
	UITextView *description;
	
	NSArray *contents;

}
@property (nonatomic,retain) IBOutlet UILabel *northAmericaLabel;
@property (nonatomic,retain) IBOutlet UILabel *europeLabel;
@property (nonatomic,retain) IBOutlet UILabel *asiaLabel;
@property (nonatomic,retain) IBOutlet UILabel *southAmericaLabel;
@property (nonatomic,retain) IBOutlet UILabel *africaLabel;
@property (nonatomic,retain) IBOutlet UILabel *oceaniaLabel;
@property (nonatomic,retain) IBOutlet UILabel *worldCoffeeLabel;
@property (nonatomic,retain) IBOutlet UITextView *description;
@property (nonatomic,retain) NSArray *contents;

-(IBAction) buttonPressed:(id)sender;

@end
