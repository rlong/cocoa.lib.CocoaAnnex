// Copyright (c) 2013 Richard Long & HexBeerium
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//

#import "CAHostName.h"
#import "CAObjectTracker.h"


////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

@interface CAHostName () 

@end 

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////


@implementation CAHostName

-(NSString*)toString {

	
	if( nil != [self applicationName] ) {
		return [self applicationName];
	}
	
	if( nil != [self zeroconfName] ) {
		return [self zeroconfName];
	}
	
	if( nil != [self dnsName] ) {
		return [self dnsName];
	}
	
	return nil;
	
}



#pragma mark instance lifecycle


-(void)dealloc {
	
	
}



#pragma mark fields



@end
