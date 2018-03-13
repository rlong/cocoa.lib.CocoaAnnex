// Copyright (c) 2013 Richard Long & HexBeerium
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//


#import <Foundation/Foundation.h>


#import "CAJsonArray.h"

@interface CAJsonArrayHelper : NSObject

// can return nil
+(CAJsonArray*)fromFile:(NSString*)path;

+(CAJsonArray*)fromString:(NSString*)input;

//+(NSData*)toData:(CAJsonArray*)array;
//+(NSString*)toString:(CAJsonArray*)array;

//+(void)write:(CAJsonArray*)array toFile:(NSString*)path;

+(NSData*)toData:(CAJsonArray*)array;


@end
