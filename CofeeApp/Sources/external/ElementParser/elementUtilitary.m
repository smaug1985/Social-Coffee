//
//  elementUtilitary.m
//  HoroscopoTarotChic
//
//  Created by gali on 03/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "elementUtilitary.h"


@implementation elementUtilitary

+(void) getDataWithData:(NSString *)stringData withMark:(NSString *)mark withDelegate:(id)delegate{

	ElementParser *parser = [[ElementParser alloc] init];
	parser.delegate = delegate;
	[parser performSelector:@selector(gotFeedElement:) forElementsMatching:mark];
	[parser parseXML:stringData];
}

//CallBack para cuando encuentre un elemento. Implementar en la clase delegada.
/*
 - (NSString *) gotFeedElement:(Element*)element{
 
 NSArray* arraOfElements = [element childElements];
 
 //Recorrer hijos de Players
 for (Element * e in arraOfElements) {
 NSLog(@"---------------------------------------------");
 NSLog(@"AplleID jugador: %@",[e contentsTextOfChildElement:@"appleid"]);
 NSLog(@"ID jugador: %@",[e contentsTextOfChildElement:@"id"]);
 NSLog(@"Nombre jugador: %@",[e contentsTextOfChildElement:@"name"]);
 NSLog(@"Score jugador: %@",[e contentsTextOfChildElement:@"score"]);
 NSLog(@"Avatar jugador: %@",[e contentsTextOfChildElement:@"avatar"]);
 }
 return @"nil";
 
 }
*/
@end
