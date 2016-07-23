// Copyright (c) 2013 Richard Long & HexBeerium
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//


#import "CADefaultJsonHandler.h"
#import "CAJsonBuilder.h"
#import "CAJsonDataInput.h"
#import "CAJsonReader.h"
#import "CAJsonReaderUnitTest.h"
#import "CALog.h"
#import "CAStringHelper.h"


@implementation CAJsonReaderUnitTest


static CADefaultJsonHandler* _handler;

+(void)initialize {
    
    _handler = [[CADefaultJsonHandler alloc] init];
}


-(void)test1 {
    Log_enteredMethod();
}



-(void)testBrokerRequest {
    
    
    NSData* data = [CAStringHelper toUtf8Data:@"[\"request\",{},\"jsonbroker.TestService\",1,0,\"ping\",{},[]]"];
    [CAJsonReader readFromData:data handler:_handler];
    
    
}


-(void)testEmptyObject {
    
    
    NSData* data = [CAStringHelper toUtf8Data:@"{}"];
    [CAJsonReader readFromData:data handler:_handler];
    
    
}

-(void)testEmptyArray {

    NSData* data = [CAStringHelper toUtf8Data:@"[]"];
    [CAJsonReader readFromData:data handler:_handler];


}

-(void)testSimpleObject {
    
    
    NSData* data = [CAStringHelper toUtf8Data:@"{\"nullKey\":null,\"booleanKey\":true,\"integerKey\":314,\"stringKey\":\"value\"}"];
    [CAJsonReader readFromData:data handler:_handler];

}

-(void)testSimpleArray {
    
    NSData* data = [CAStringHelper toUtf8Data:@"[null,true,314,\"value\"]"];
    [CAJsonReader readFromData:data handler:_handler];

}



-(NSData*)readData:(NSString*)resourceName {

    NSString *absoluteFilePath = [[NSBundle mainBundle] pathForResource:resourceName ofType:nil];
    Log_debugString(absoluteFilePath);
    XCTAssertTrue(nil != absoluteFilePath, @"absoluteFilePath = %p", absoluteFilePath );

    NSData* answer = [NSData dataWithContentsOfFile:absoluteFilePath];
    return answer;
    
}

-(void)testStatusPaused {
    
    NSData* data = [self readData:@"CAJsonReaderUnitTest.testStatusPaused.json"];
    [CAJsonReader readFromData:data handler:_handler];
    
}

-(void)testStatusPlaying {

    NSData* data = [self readData:@"CAJsonReaderUnitTest.testStatusPlaying.json"];
    [CAJsonReader readFromData:data handler:_handler];

}

-(void)testStatusStopped {
    
    NSData* data = [self readData:@"CAJsonReaderUnitTest.testStatusStopped.json"];
    [CAJsonReader readFromData:data handler:_handler];
    
}



@end
