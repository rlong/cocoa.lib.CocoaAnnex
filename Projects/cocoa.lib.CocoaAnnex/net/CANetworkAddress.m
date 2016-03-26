// Copyright (c) 2013 Richard Long & HexBeerium
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//


#import "CAHostName.h"
#import "CAIPAddress.h"
#import "CAJsonObject.h"
#import "CANetworkAddress.h"
#import "CANetworkHost.h"

#import "CALog.h"

@implementation CANetworkAddress


-(CAHostName*)hostName {
    return [_networkHost hostName];
}

-(CAIPAddress*)ipAddress {
    return [_networkHost ipAddress];
}


-(NSString*)toString {
    
    CAIPAddress* ipAddress = [_networkHost ipAddress];
	
	return [NSString stringWithFormat:@"%@:%d", [ipAddress toString], _port];
	
}




-(NSString*)label {
	
    CAHostName* hostName = [_networkHost hostName];
	NSString* answer = [hostName toString];
	if( nil == answer ) {
        CAIPAddress* ipAddress = [_networkHost ipAddress];
		answer = [ipAddress toString];
	}
	return answer;
	
}



-(BOOL)isEqualToNetworkAddress:(CANetworkAddress*)other {
	
	if( other == self ) {
		return YES;
	}
	
	if( nil == other ) { 
		return NO;
	}
	
	if( _port != [other port] ) {
		return NO;
	}
    
    return [_networkHost isEqualToNetworkHost:[other networkHost]];
	
	
}

-(CAJsonObject*)toJsonObject {

    CAJsonObject* answer = [super toJsonObject];
	
    [answer setObject:[_networkHost toJSONObject] forKey:@"network_host"];
	
	return answer;
}

#pragma mark -
#pragma mark instance lifecycle

-(id)init {
	
	CANetworkAddress* answer = [super init];
	
	
    answer->_networkHost = [[CANetworkHost alloc] init];
	
	return answer;
}


-(id)initWithIp4Address:(NSString*)ip4Address port:(int)port { 

	CANetworkAddress* answer = [super init];	
	
	
    answer->_networkHost = [[CANetworkHost alloc] init];
    [[answer ipAddress] setIp4AddressWithString:ip4Address];
    [answer setPort:port];
	
	return answer;
}

-(id)initWithJsonObject:(CAJsonObject*)network_address {
    
	CANetworkAddress* answer = [super initWithJsonObject:network_address];
	
	
    CAJsonObject* network_host = [network_address jsonObjectForKey:@"network_host"];
    answer->_networkHost = [[CANetworkHost alloc] initWithJsonObject:network_host];
	
	return answer;
    

}


-(void)dealloc {
	
	
    [self setNetworkHost:nil];
    [self setExtension:nil];

	
}

#pragma mark -
#pragma mark fields


//NetworkHost* _networkHost;
//@property (nonatomic, retain) NetworkHost* networkHost;
@synthesize networkHost = _networkHost;

// extension
//id _extension;
//@property (nonatomic, retain) id extension;
@synthesize extension = _extension;



@end
