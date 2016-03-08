// Copyright (c) 2013 Richard Long & HexBeerium
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//


#import <Foundation/Foundation.h>

@class CAIPAddress;


@interface CANetworkUtilities : NSObject {
    
	
	
}

+(CAIPAddress*)getWifiIpAddress;

// can return nil
+(NSString*)getWifiNetworkName;

@end
