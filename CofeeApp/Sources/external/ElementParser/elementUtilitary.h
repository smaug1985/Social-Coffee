//
//  elementUtilitary.h
//  HoroscopoTarotChic
//
//  Created by gali on 03/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "URLParser.h"
#import "ElementParser.h"

@interface elementUtilitary : NSObject {

}
+(void) getDataWithData:(NSString *)stringData withMark:(NSString *)mark withDelegate:(id)delegate;
@end
