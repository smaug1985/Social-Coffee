//
//  appCell.m
//  appsView
//
//  Created by Fran on 03/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "AppCell.h"


@implementation AppCell

@synthesize nameLabel, iconImage;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        
		
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)dealloc {
	[iconImage release];
	[nameLabel release];
    [super dealloc];
}


@end
