// Copyright (c) 2013 Richard Long & HexBeerium
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//

#import "CABaseException.h"
#import "CAFileUtilities.h"
#import "CAJsonBuilder.h"
#import "CAJsonObject.h"
#import "CAJsonObjectHelper.h"
#import "CAJsonReader.h"
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
    
    CAJsonBuilder* builder = [[CAJsonBuilder alloc] init];
    
    [CAJsonReader readFromData:jsonData handler:builder];
    
    return [builder objectDocument];
    
    
}


+(CAJsonObject*)buildFromData:(NSData*)jsonData {
    

    CAJsonBuilder* builder = [[CAJsonBuilder alloc] init];
    
    [CAJsonReader readFromData:jsonData handler:builder];
    
    return [builder objectDocument];
    
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



@end
