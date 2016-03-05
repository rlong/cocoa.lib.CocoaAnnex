// Copyright (c) 2013 Richard Long & HexBeerium
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//

#import <Foundation/Foundation.h>

#import "BaseException.h"

@interface CABaseException : BaseException {
    
}



#pragma mark instance lifecycle


+(CABaseException*)baseExceptionWithOriginator:(id)originatingObject line:(int)line faultString:(NSString *)faultString;
+(CABaseException*)baseExceptionWithOriginator:(id)originatingObject line:(int)line faultStringFormat:(NSString *)format, ...;
+(CABaseException*)baseExceptionWithOriginator:(id)originatingObject line:(int)line callTo:(NSString*)methodName failedWithError:(NSError*)error;


@end


