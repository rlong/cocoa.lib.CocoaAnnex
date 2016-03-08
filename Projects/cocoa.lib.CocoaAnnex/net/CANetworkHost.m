// Copyright (c) 2013 Richard Long & HexBeerium
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//

#import "CAHostName.h"
#import "CAIPAddress.h"
#import "CAJsonObject.h"
#import "CANetworkHost.h"
#import "CAObjectTracker.h"

@implementation CANetworkHost



-(BOOL)isEqualToNetworkHost:(CANetworkHost*)other {
	
	if( other == self ) {
		return YES;
	}
	
	if( nil == other ) { 
		return NO;
	}
	
	
	if( [_ipAddress ip4Address] != [[other ipAddress] ip4Address] ) {
		return NO;
	}
	
	
	NSString* hostName = [_hostName toString];
	NSString* otherHostName = [[other hostName] toString];
	if( nil == hostName ) {
		if( nil != otherHostName ) {
			return NO;
		}
	} else {
		if( ! [hostName isEqualToString:otherHostName] ) {
			return NO;
		}
	}
	
	// ip address, hostName all match ... 
	return YES;
	
}


-(CAJsonObject*)toJSONObject {
	
    CAJsonObject* answer = [_hostName toJsonObject];
    
    [answer setObject:[_ipAddress toJSONArray] forKey:@"inet_address"];
    
	return answer;
	
	
}


#pragma mark -
#pragma mark instance lifecycle

-(id)init {
	
	CANetworkHost* answer = [super init];
	
	
	[CAObjectTracker allocated:answer];
	
	answer->_ipAddress = [[CAIPAddress alloc] init];
	answer->_hostName = [[CAHostName alloc] init];
	
	return answer;
}

-(id)initWithJsonObject:(CAJsonObject*)network_host {
    
    CANetworkHost* answer = [super init];
    
	[CAObjectTracker allocated:answer];
	
    CAJsonArray* inet_address = [network_host jsonArrayForKey:@"inet_address"];
	answer->_ipAddress = [[CAIPAddress alloc] initWithJsonArray:inet_address];
	answer->_hostName = [[CAHostName alloc] initWithJsonObject:network_host];

	return answer;

}

-(void)dealloc {
	
	[CAObjectTracker deallocated:self];
	
	
	[self setIpAddress:nil];
	[self setHostName:nil];
	
}


#pragma mark -
#pragma fields

//IPAddress* _ipAddress;
//@property (nonatomic, retain) IPAddress* ipAddress;
@synthesize ipAddress = _ipAddress;

//HostName* _hostName;
//@property (nonatomic, retain) HostName* hostName;
@synthesize hostName = _hostName;

@end
