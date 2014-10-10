//
//  Connection.h
//  Agility
//
//  Created by gali on 22/06/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Connection : NSObject {

	NSMutableData		*receivedData;
	NSMutableURLRequest	*theRequest;
	NSURLConnection		*theConnection;
	id					delegate;
	SEL					callback;
	SEL					errorCallback;
	
	BOOL				isPost;
	NSString			*requestBody;
	
	NSString			*user;
	NSString			*password;
}

@property(nonatomic, retain) NSMutableData *receivedData;
@property(nonatomic, retain) id			    delegate;
@property(nonatomic) SEL					callback;
@property(nonatomic) SEL					errorCallback;
@property(nonatomic, retain) NSString *requestBody;
@property(assign) BOOL isPost;

@property(nonatomic, retain) NSString *user;
@property(nonatomic, retain) NSString *password;


-(void)request:(NSURL *) url;
-(id)initWhitUser:(NSString *)u password:(NSString *)p;

@end
