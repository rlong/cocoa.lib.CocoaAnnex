// Copyright (c) 2013 Richard Long & HexBeerium
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//


#import "CABaseException.h"
#import "CAJsonBuilder.h"
#import "CAJsonArrayHandler.h"
#import "CAJsonArrayHelper.h"
#import "CAFileUtilities.h"
#import "CAJsonReader.h"
#import "CAJsonStringOutput.h"
#import "CAJsonWalker.h"
#import "CAJsonWriter.h"
#import "CALog.h"
#import "CAStringHelper.h"


@implementation CAJsonArrayHelper

static CAJsonArrayHandler* _jsonArrayHandler = nil;

+(void)initialize {
	
    _jsonArrayHandler = [CAJsonArrayHandler getInstance];
	
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
    
    CAJsonBuilder* builder = [[CAJsonBuilder alloc] init];
    
    [CAJsonReader readFromData:jsonData handler:builder];
    
    return [builder arrayDocument];
    
    
}


+(CAJsonArray*)fromString:(NSString*)input {
    
    CAJsonBuilder* builder = [[CAJsonBuilder alloc] init];
    
    @try {
        
        
        NSData* data = [CAStringHelper toUtf8Data:input];
        [CAJsonReader readFromData:data handler:builder];
        
        CAJsonArray* answer = [builder arrayDocument];
        return  answer;
    }
    @finally {
    }
}






+(NSData*)toData:(CAJsonArray*)array {
    
    NSData* answer;
    
    CAJsonStringOutput* writer = [[CAJsonStringOutput alloc] init];
    
    @try {
        [_jsonArrayHandler writeValue:array writer:writer];
        
        NSString* json = [writer toString];
        
        answer = [CAStringHelper toUtf8Data:json];
        
    }
    @finally {
    }
    
    return answer;
    
}

+(NSString*)toString:(CAJsonArray*)array {
    
    CAJsonStringOutput* output = [[CAJsonStringOutput alloc] init];
    
    CAJsonWriter* writer = [[CAJsonWriter alloc] initWithOutput:output];
    
    [CAJsonWalker walkJsonArrayDocument:array visitor:writer];
    NSString* answer = [output toString];
    
    return answer;

    
}


+(void)write:(CAJsonArray*)array toFile:(NSString*)path {
    
    NSString* arrayText = [array toString];
    
    NSError* error = nil;

    [arrayText writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:&error];
    
    if( nil != error ) {
        
        CABaseException* e = [CABaseException baseExceptionWithOriginator:self line:__LINE__ callTo:@"[NSString writeToFile:atomically:encoding:error:]" failedWithError:error];
        [e addStringContext:path withName:@"path"];
        @throw e;


    }
    
}


@end
