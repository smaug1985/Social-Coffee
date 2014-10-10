//
//  FormularioFacebook.h
//  CofeeApp
//
//  Created by gali on 16/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "BLPinAnnotation.h"
#import "FacebookDataManager.h"


@interface FormularioFacebook : UIViewController <FacebookDataManagerDelegate,UITextViewDelegate> {

	BLPinAnnotation *selectedPin;
	UILabel *label;
	UITextView *tv1;
	UIButton *ini;
	UIButton *fin;
	UIDatePicker *picker;
	NSDate *dateIni;
	NSDate *dateFin;
	BOOL isIni;
}

@property (nonatomic,retain) BLPinAnnotation *selectedPin;
@property (nonatomic,retain) IBOutlet UITextView *tv1;
@property (nonatomic,retain) IBOutlet UILabel *label;
@property (nonatomic,retain) IBOutlet UIButton *ini;
@property (nonatomic,retain) IBOutlet UIButton *fin;
@property (nonatomic,retain) IBOutlet UIDatePicker *picker;
@property (nonatomic,retain) NSDate *dateIni;
@property (nonatomic,retain) NSDate *dateFin;
@property (nonatomic,assign) BOOL isIni;

-(IBAction) post;
-(IBAction) fecInicio;
-(IBAction) fecFin;
-(void) valuChangePicker;
@end
