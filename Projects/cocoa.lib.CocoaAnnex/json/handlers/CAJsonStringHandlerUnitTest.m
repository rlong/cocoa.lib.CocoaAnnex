// Copyright (c) 2013 Richard Long & HexBeerium
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//




#import "CAJsonObject.h"
#import "CAStringHelper.h"
#import "CAJsonDataInput.h"
#import "CAJsonStringOutput.h"
#import "CAJsonStringHandler.h"
#import "CAJsonStringHandlerUnitTest.h"

#import "CALog.h"

@implementation CAJsonStringHandlerUnitTest



-(void)test1 {
    Log_enteredMethod();
}




-(NSString*)encodeJsonStringValue:(NSString*)input {
    
    
    
    CAJsonStringOutput* output = [[CAJsonStringOutput alloc] init];
    
    
    CAJsonStringHandler* handler = [CAJsonStringHandler getInstance];
    
    
    [handler writeValue:input writer:output];
    
    return [output toString];
    
}


-(NSString*)decodeJsonStringValue:(NSString*)input {
    
    
    NSData* data = [CAStringHelper toUtf8Data:input];
    
    
    CAJsonDataInput* jsonDataInput = [[CAJsonDataInput alloc] initWithData:data];
    
    NSString* answer = [CAJsonStringHandler readString:jsonDataInput];
    
    return answer;
    
    
}

-(void)testWriteABC {
    
    Log_enteredMethod();
    
    NSString* actual = [self encodeJsonStringValue:@"ABC"];
    
    XCTAssertTrue( [@"\"ABC\"" isEqualToString:actual], @"actual = '%@'", actual );
    
}

-(void)testReadABC {

    Log_enteredMethod();
    
    NSString* actual = [self decodeJsonStringValue:@"\"ABC\""];
    XCTAssertTrue( [@"ABC" isEqualToString:actual], @"actual = '%@'", actual );
    
    
}


-(void)testReadWriteSlashes {
    
    Log_enteredMethod();
    
    
    {
        NSString* encodedValue = [self encodeJsonStringValue:@"\\"];
        XCTAssertTrue( [@"\"\\\\\"" isEqualToString:encodedValue], @"encodedValue = '%@'", encodedValue );
        NSString* decodedValue = [self decodeJsonStringValue:encodedValue];
        XCTAssertTrue( [@"\\" isEqualToString:decodedValue], @"decodedValue = '%@'", decodedValue );
    }

    
    {
        NSString* encodedValue = [self encodeJsonStringValue:@"/"];
        XCTAssertTrue( [@"\"\\/\"" isEqualToString:encodedValue], @"encodedValue = '%@'", encodedValue );
        NSString* decodedValue = [self decodeJsonStringValue:encodedValue];
        XCTAssertTrue( [@"/" isEqualToString:decodedValue], @"decodedValue = '%@'", decodedValue );
    }

    
}





-(void)testHebrew {

    NSString* input = @"עולמו של יובל המבולבל.mp4";
    
    CAJsonObject* obj = [[CAJsonObject alloc] init];
    [obj setObject:input forKey:@"input"];
    
    
    NSString* objToString = [obj toString];
    Log_debugString(objToString );


    
    XCTAssertTrue( NSNotFound != [objToString rangeOfString:@"input"].location, @"" );
    XCTAssertTrue( NSNotFound != [objToString rangeOfString:@"עולמו של יובל המבולבל"].location, @"" );
    
}

@end
