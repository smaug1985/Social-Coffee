//
//  WorldCoffeesDetail.h
//  CofeeApp
//
//  Created by Borja Rubio Soler on 13/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WorldCoffeesDetail : UIViewController {
	NSString *titleCoffee;
	NSString *descriptionCoffee;
	NSString *imageCoffee;
	UILabel *mainLabel;
	UITextView *description;
	UIImageView *imageView;
	
}
@property (nonatomic,retain) IBOutlet UILabel *mainLabel;
@property (nonatomic,retain) IBOutlet UITextView *description;
@property (nonatomic,retain) IBOutlet UIImageView *imageView;
@property (nonatomic,retain) NSString *titleCoffee;
@property (nonatomic,retain) NSString *descriptionCoffee;
@property (nonatomic,retain) NSString *imageCoffee;



@end
