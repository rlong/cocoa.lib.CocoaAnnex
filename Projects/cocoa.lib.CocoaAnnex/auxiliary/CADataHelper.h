// Copyright (c) 2013 Richard Long & HexBeerium
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//

#import <Foundation/Foundation.h>



@interface CADataHelper : NSObject



+(NSString*)toUtf8String:(NSData*)data;

// DEPRECATED: use [StringHelper toUtf8Data]
+(NSData*)getUtf8Data:(NSString*)input;


@end
