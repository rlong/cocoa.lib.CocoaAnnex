// Copyright (c) 2013 Richard Long & HexBeerium
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//


#import <Foundation/Foundation.h>

@class CAJsonObject;

@interface CANetworkAddress_Generated  : NSObject {
    
    
	// port
	int _port;
	//@property (nonatomic, assign) int port;
	//@synthesize port = _port;
    
}

-(CAJsonObject*)toJsonObject;

#pragma mark -
#pragma mark instance lifecycle

-(id)init;
-(id)initWithJsonObject:(CAJsonObject*)jsonObject;

#pragma mark -
#pragma mark fields

// port
//int _port;
@property (nonatomic, assign) int port;
//@synthesize port = _port;

@end
