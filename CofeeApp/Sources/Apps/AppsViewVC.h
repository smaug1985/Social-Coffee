//
//  appsViewVC.h
//  appsView
//
//  Created by Fran on 03/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppCell.h"

@interface AppsViewVC : UIViewController {

	NSArray *arrayApps;
	IBOutlet AppCell *appCell;
	
}

@property (nonatomic, retain) NSArray *arrayApps;
@property (nonatomic, retain) AppCell *appCell;

@end
