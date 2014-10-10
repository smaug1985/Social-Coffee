//
//  appCell.h
//  appsView
//
//  Created by Fran on 03/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface AppCell : UITableViewCell {

	IBOutlet UIImageView *iconImage;
	IBOutlet UILabel *nameLabel;
	
}

@property (nonatomic, retain) UIImageView *iconImage;
@property (nonatomic, retain) UILabel *nameLabel;

@end
