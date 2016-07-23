// Copyright (c) 2013 Richard Long & HexBeerium
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//

#import <Foundation/Foundation.h>


@class CAJsonArray;

@interface CAIPAddress : NSObject {

	
    in_addr_t _ip4Address; 
    //@property (nonatomic, setter=setIp4Address:)in_addr_t ip4Address;
    //@synthesize ip4Address = _ip4Address;
	

	NSString* _toString;
	//@property (nonatomic, retain) NSString* toString;
	//@synthesize toString = _toString;
	

}


+(CAIPAddress*)localhost;

-(BOOL)isLocalhost;


-(void)setIp4AddressWithString:(NSString*)ip4Address;

-(CAJsonArray*)toJSONArray;

#pragma mark instance lifecycle

-(id)initWithAddress:(in_addr_t)ip4Address;

-(id)initWithJsonArray:(CAJsonArray*)jsonArray;


#pragma mark fields

//in_addr_t _ip4Address; 
@property (nonatomic, setter=setIp4Address:)in_addr_t ip4Address;
//@synthesize ip4Address = _ip4Address;


//NSString* _toString;
@property (nonatomic, readonly) NSString* toString;
//@synthesize toString = _toString;



@end
