// Copyright (c) 2013 Richard Long & HexBeerium
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//

#import "CABaseException.h"
#import "CAFileUtilities.h"
#import "CAJsonObject.h"
#import "CAJsonObjectHelper.h"
#import "CALog.h"
#import "CAStringHelper.h"

@implementation CAJsonObjectHelper




// can return nil
+(CAJsonObject*)fromFile:(NSString*)path {
    
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


+(CAJsonObject*)buildFromData:(NSData*)jsonData {
    

    NSJSONReadingOptions options = NSJSONReadingMutableContainers;
    
    NSError *error = nil;
    id blob = [NSJSONSerialization
               JSONObjectWithData:jsonData
               options:options
               error:&error];
    
    if( nil != error ) {
        
        
        @throw exceptionWithMethodNameAndError(@"[NSJSONSerialization JSONObjectWithData:options:error:]", error);
    }
    
    if(![blob isKindOfClass:[NSMutableDictionary class]]) {
        
        NSString* reason = [NSString stringWithFormat:@"![object isKindOfClass:[NSMutableDictionary class]]; NSStringFromClass([blob class]) = %@", NSStringFromClass([blob class])];
        @throw exceptionWithReason( reason );
        
    }
    
    NSMutableDictionary* mutableDictionary = (NSMutableDictionary*)blob;
    return [[CAJsonObject alloc] initWithValue:mutableDictionary];

}


+(CAJsonObject*)buildFromString:(NSString*)jsonString {
    
    
    NSData* jsonData = [CAStringHelper toUtf8Data:jsonString];
    return [self buildFromData:jsonData];
    
    
}



+(void)write:(CAJsonObject*)object toFile:(NSString*)path {
    
    NSString* objectText = [object toString];
    
    NSError* error = nil;
    
    [objectText writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:&error];
    
    if( nil != error ) {
        
        CABaseException* e = [CABaseException baseExceptionWithOriginator:self line:__LINE__ callTo:@"[NSString writeToFile:atomically:encoding:error:]" failedWithError:error];
        [e addStringContext:path withName:@"path"];
        @throw e;
        
    }
    
}

+(NSData*)toData:(CAJsonObject*)object;
{
    
    
    NSJSONWritingOptions options = 0;
    NSError *error = nil;
    
    NSData* answer = [NSJSONSerialization dataWithJSONObject:[object values] options:options error:&error];
    if( nil != error ) {
        
        @throw exceptionWithMethodNameAndError(@"[NSJSONSerialization JSONObjectWithData:options:error:]", error);
    }
    
    return answer;
}


@end
