// Copyright (c) 2013 Richard Long & HexBeerium
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//

#import "CABaseException.h"

@implementation CABaseException




+(CABaseException*)baseExceptionWithOriginator:(id)originatingObject line:(int)line faultString:(NSString *)faultString {
    

    CABaseException* answer = [[CABaseException alloc] initWithOriginator:originatingObject line:line faultMessage:faultString];
    return answer;

    
}


+(CABaseException*)baseExceptionWithOriginator:(id)originatingObject line:(int)line faultStringFormat:(NSString *)format, ... {
    
    
    CABaseException* answer;
    
    va_list vaList;
	va_start(vaList, format);
	{
        answer = [[CABaseException alloc] initWithOriginator:originatingObject line:line faultStringFormat:format arguments:vaList];
	}
	va_end(vaList);

    return answer;
    
}


+(CABaseException*)baseExceptionWithOriginator:(id)originatingObject line:(int)line callTo:(NSString*)methodName failedWithError:(NSError*)error {
    
    CABaseException* answer = [[CABaseException alloc] initWithOriginator:originatingObject line:line callTo:methodName failedWithError:error];
    
    return answer;
    
}




@end
