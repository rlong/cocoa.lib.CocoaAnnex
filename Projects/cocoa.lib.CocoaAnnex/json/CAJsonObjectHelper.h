// Copyright (c) 2013 Richard Long & HexBeerium
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//


#import <Foundation/Foundation.h>

@class CAJsonObject;

@interface CAJsonObjectHelper : NSObject


// can return nil
+(CAJsonObject*)fromFile:(NSString*)path;

+(CAJsonObject*)buildFromData:(NSData*)jsonData;
+(CAJsonObject*)buildFromString:(NSString*)jsonString;


+(void)write:(CAJsonObject*)object toFile:(NSString*)path;

@end
