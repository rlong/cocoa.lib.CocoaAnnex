// Copyright (c) 2013 Richard Long & HexBeerium
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//


#import "CAJsonHandler.h"


@interface CAJsonStringHandler : CAJsonHandler {

	
}

+(CAJsonStringHandler*)getInstance;


#ifdef REMOTE_GATEWAY_CLIENT

// major hack to handle older builds of 'RemoteGateway'
+(void)doNotEscapeForwardSlashForOldRemoteGateway;

#endif



+(NSString*)readString:(CAJsonInput*)reader;
+(void)writeString:(NSString*)value writer:(id<CAJsonOutput>)writer;

@end
