//
//  Connection.m
//  Agility
//
//  Created by gali on 22/06/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Connection.h"


@implementation Connection

@synthesize receivedData;
@synthesize delegate;
@synthesize callback;
@synthesize errorCallback;
@synthesize requestBody, isPost;

@synthesize user,password;

-(id)initWhitUser:(NSString *)u password:(NSString *)p{

	if (self = [super init]) {
		self.user = u;
		self.password = p;
	}
	return self;
}

-(void)request:(NSURL *) url {
	theRequest   = [[NSMutableURLRequest alloc] initWithURL:url];
	
	if(isPost) {
		//NSLog(@"ispost   %@",[requestBody stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]);
		
		NSData *data = [[requestBody stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] dataUsingEncoding:NSUTF8StringEncoding];
		NSString *postLength = [NSString stringWithFormat:@"%d", [data length]];
		
		[theRequest setHTTPMethod:@"POST"];
		[theRequest setValue:postLength forHTTPHeaderField:@"Content-Length"];
		[theRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Current-Type"];
		[theRequest setHTTPBody:data];
	}
	
	theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
	
	if (theConnection) {
		// Create the NSMutableData that will hold
		// the received data
		// receivedData is declared as a method instance elsewhere
		receivedData=[[NSMutableData data] retain];
	} else {
		// inform the user that the download could not be made
	}
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
	NSLog(@"Connection menssage - challenged %@",[challenge proposedCredential] );
	
	if ([challenge previousFailureCount] == 0) {
        NSURLCredential *newCredential;
        newCredential=[NSURLCredential credentialWithUser:self.user password:self.password persistence:NSURLCredentialPersistencePermanent];
        [[challenge sender] useCredential:newCredential forAuthenticationChallenge:challenge];
		
    } else {
        [[challenge sender] cancelAuthenticationChallenge:challenge];
		NSLog(@"Connection menssage - Invalid Username or Password");
    }
	
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // this method is called when the server has determined that it
    // has enough information to create the NSURLResponse
	
    // it can be called multiple times, for example in the case of a
    // redirect, so each time we reset the data.
    // receivedData is declared as a method instance elsewhere
    //[receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	//NSLog([[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
	// append the new data to the receivedData
    // receivedData is declared as a method instance elsewhere
    [receivedData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    // release the connection, and the data object
    [connection release];
    // receivedData is declared as a method instance elsewhere
    [receivedData release];
	
	[theRequest release];
	
    // inform the user
    NSLog(@"Connection failed! Error - %@ %@",[error localizedDescription],[[error userInfo] objectForKey:NSErrorFailingURLStringKey]);
	
	if(errorCallback) {
		[delegate performSelector:errorCallback withObject:error];
	}
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	
	if(delegate && callback) {
		if([delegate respondsToSelector:self.callback]) {
			[delegate performSelector:self.callback withObject:receivedData];
		} else {
			NSLog(@"Connection menssage - No response from delegate");
		}
	} 
	
	// release the connection, and the data object
	//[theConnection release];
    //[receivedData release];
	//[theRequest release];
}

-(void) dealloc {
	[self.receivedData release];
	[self.password release];
	[self.user release];
	[self.requestBody release];
	[theRequest release];
	[theConnection release];
	
	[super dealloc];
}


@end
