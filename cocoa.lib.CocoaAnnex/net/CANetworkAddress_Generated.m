// Copyright (c) 2013 Richard Long & HexBeerium
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//

#import "CAJsonObject.h"
#import "CANetworkAddress_Generated.h"

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

@interface CANetworkAddress_Generated ()

@end

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

@implementation CANetworkAddress_Generated 


-(CAJsonObject*)toJsonObject {
	CAJsonObject* answer = [[CAJsonObject alloc] init];
	[answer setInt:_port forKey:@"port"];
	return answer;
    
}

#pragma mark -
#pragma mark instance lifecycle

-(id)init {
	return [super init];
}

-(id)initWithJsonObject:(CAJsonObject*)jsonObject {
	
	CANetworkAddress_Generated* answer = [super init];
	
	[answer setPort:[jsonObject intForKey:@"port"]];
	
	return answer;
	
}


-(void)dealloc {
    
    
    
}


#pragma mark -
#pragma mark fields


//////////////////////////////////////////////////////
// port
//int _port;
//@property (nonatomic, assign) int port;
@synthesize port = _port;

@end
