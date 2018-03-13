// Copyright (c) 2013 Richard Long & HexBeerium
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//


#import "CABaseException.h"
#import "CAJsonArrayHelper.h"
#import "CAFileUtilities.h"
#import "CALog.h"
#import "CAStringHelper.h"


@implementation CAJsonArrayHelper




+(CAJsonArray*)buildFromData:(NSData*)jsonData {
    
    
    NSJSONReadingOptions options = NSJSONReadingMutableContainers;
    
    NSError *error = nil;
    id blob = [NSJSONSerialization
               JSONObjectWithData:jsonData
               options:options
               error:&error];
    
    if( nil != error ) {
        
        
        @throw exceptionWithMethodNameAndError(@"[NSJSONSerialization JSONObjectWithData:options:error:]", error);
    }
    
    if(![blob isKindOfClass:[NSMutableArray class]]) {
        
        NSString* reason = [NSString stringWithFormat:@"![object isKindOfClass:[NSMutableArray class]]; NSStringFromClass([blob class]) = %@", NSStringFromClass([blob class])];
        @throw exceptionWithReason( reason );
        
    }
    
    NSMutableArray* mutableArray = (NSMutableArray*)blob;
    return [[CAJsonArray alloc] initWithValue:mutableArray];

}


// can return nil
+(CAJsonArray*)fromFile:(NSString*)path {
    
    if( ![CAFileUtilities fileExistsAtPath:path] ) {
        return nil;
    }
    
    NSData* jsonData = [NSData dataWithContentsOfFile:path];
    
    if( nil == jsonData ) {
        Log_warnFormat(@"nil == jsonData; path = '%@'", path);
        return nil;
    }

    return [self buildFromData:jsonData];
    
}


+(CAJsonArray*)fromString:(NSString*)input {

    NSData* data = [CAStringHelper toUtf8Data:input];
    return [self buildFromData:data];
}



+(NSData*)toData:(CAJsonArray*)array;
{
    
    
    NSJSONWritingOptions options = 0;
    NSError *error = nil;
    
    NSData* answer = [NSJSONSerialization dataWithJSONObject:[array values] options:options error:&error];
    if( nil != error ) {
        
        @throw exceptionWithMethodNameAndError(@"[NSJSONSerialization JSONObjectWithData:options:error:]", error);
    }
    
    return answer;
}


//
//+(void)write:(CAJsonArray*)array toFile:(NSString*)path {
//
//    NSString* arrayText = [array toString];
//
//    NSError* error = nil;
//
//    [arrayText writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:&error];
//
//    if( nil != error ) {
//
//        CABaseException* e = [CABaseException baseExceptionWithOriginator:self line:__LINE__ callTo:@"[NSString writeToFile:atomically:encoding:error:]" failedWithError:error];
//        [e addStringContext:path withName:@"path"];
//        @throw e;
//
//
//    }
//
//}


@end
