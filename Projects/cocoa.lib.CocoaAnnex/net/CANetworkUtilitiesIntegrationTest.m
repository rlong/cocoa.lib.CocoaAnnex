// Copyright (c) 2013 Richard Long & HexBeerium
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//

#import "CANetworkUtilities.h"
#import "CANetworkUtilitiesIntegrationTest.h"


#import "CALog.h"

@implementation CANetworkUtilitiesIntegrationTest


-(void)testGetWifiIpAddress {

	
	
	CAIPAddress* networkHost = [CANetworkUtilities getWifiIpAddress];
    
    Log_debugString([networkHost toString]);

	
}



-(void)testGetWifiNetworkName {
    
	NSString* wifiNetworkName = [CANetworkUtilities getWifiNetworkName];
    Log_debugString( wifiNetworkName );
    
	
}




@end
