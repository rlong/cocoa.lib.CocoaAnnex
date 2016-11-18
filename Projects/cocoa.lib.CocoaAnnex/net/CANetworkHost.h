// Copyright (c) 2013 Richard Long & HexBeerium
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//


@class CAHostName;
@class CAIPAddress;

@interface CANetworkHost : NSObject {
    
    CAIPAddress* _ipAddress;
    //@property (nonatomic, retain) IPAddress* ipAddress;
    //@synthesize ipAddress = _ipAddress;
    
    CAHostName* _hostName;
	//@property (nonatomic, retain) HostName* hostName;
	//@synthesize hostName = _hostName;

}


-(BOOL)isEqualToNetworkHost:(CANetworkHost*)other;


-(CAJsonObject*)toJSONObject;

#pragma mark instance lifecycle

-(id)init;

-(id)initWithJsonObject:(CAJsonObject*)network_host;


#pragma fields


//IPAddress* _ipAddress;
@property (nonatomic, retain) CAIPAddress* ipAddress;
//@synthesize ipAddress = _ipAddress;

//HostName* _hostName;
@property (nonatomic, retain) CAHostName* hostName;
//@synthesize hostName = _hostName;


@end
