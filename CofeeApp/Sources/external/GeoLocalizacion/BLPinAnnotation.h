//
//  BLPinAnnotation.h
//  Business Listings Part 3
//
//  Created by Zack Ensign on 9/21/10.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface BLPinAnnotation : MKAnnotationView {
	UIView *calloutView;
	UILabel *titleLabel;
	UILabel *subtitleLabel;
	UIImage *normalPin;
	UIImage *selectedPin;
}

@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UILabel *subtitleLabel;

-(void)setSelected:(BOOL)selected animated:(BOOL)animated;
-(CGPathRef)roundedRectPath:(CGRect)rect radius:(CGFloat)radius;

@end
