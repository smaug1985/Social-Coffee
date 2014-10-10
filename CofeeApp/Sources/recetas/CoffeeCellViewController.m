//
//  coffeeCell.m
//  CofeeApp
//
//  Created by Fran Estrada on 13/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "CoffeeCellViewController.h"


@implementation CoffeeCellViewController
@synthesize lblCell, imgCell;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}


- (void)dealloc {
	[self.lblCell release];
	[self.imgCell release];
    [super dealloc];
}


@end
