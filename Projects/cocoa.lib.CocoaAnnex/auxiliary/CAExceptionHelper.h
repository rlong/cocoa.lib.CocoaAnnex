// Copyright (c) 2013 Richard Long & HexBeerium
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//

#import <Foundation/Foundation.h>

@class CAJsonArray;

@interface CAExceptionHelper : NSObject


+(CAJsonArray*)getStackTrace:(NSException*)e;

+(NSString*)getAtosCommand:(NSException*)e;


@end
