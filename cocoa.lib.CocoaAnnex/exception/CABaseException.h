// Copyright (c) 2013 Richard Long & HexBeerium
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//

#import <Foundation/Foundation.h>

#import "BaseException.h"
#import "JBBaseException.h"

#define exceptionWithReason( reasonValue ) [CABaseException baseExceptionWithOriginator:self line:__LINE__ faultString:reasonValue]
#define exceptionWithFormat( ... ) [CABaseException baseExceptionWithOriginator:self line:__LINE__ faultStringFormat:__VA_ARGS__]
#define exceptionWithMethodNameAndError( methodName, error ) [CABaseException baseExceptionWithOriginator:self line:__LINE__ callTo:methodName failedWithError:error]

@interface CABaseException : JBBaseException {
    
}


#pragma mark instance lifecycle


+(CABaseException*)baseExceptionWithOriginator:(id)originatingObject line:(int)line faultString:(NSString *)faultString;
+(CABaseException*)baseExceptionWithOriginator:(id)originatingObject line:(int)line faultStringFormat:(NSString *)format, ...;
+(CABaseException*)baseExceptionWithOriginator:(id)originatingObject line:(int)line callTo:(NSString*)methodName failedWithError:(NSError*)error;


@end


