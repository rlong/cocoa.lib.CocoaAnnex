// Copyright (c) 2013 Richard Long & HexBeerium
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//


#import "CADataHelper.h"

@implementation CADataHelper



+(NSString*)toUtf8String:(NSData*)data { 
    NSString* answer = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return answer;
}



// DEPRECATED: use [StringHelper toUtf8Data]
+(NSData*)getUtf8Data:(NSString*)input { 
    
	const char* bytes = [input UTF8String];
	
	NSData* answer = [NSData dataWithBytes:bytes length:[input lengthOfBytesUsingEncoding:NSUTF8StringEncoding]];
    
    return answer;

}


@end
