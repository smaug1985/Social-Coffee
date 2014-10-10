//
//  coffeeCell.h
//  CofeeApp
//
//  Created by Fran Estrada on 13/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CoffeeCellViewController : UITableViewCell {

	IBOutlet UILabel *lblCell;
	IBOutlet UIImageView *imgCell;
	
}

@property (nonatomic, retain) UILabel *lblCell;
@property (nonatomic, retain) UIImageView *imgCell;

@end
