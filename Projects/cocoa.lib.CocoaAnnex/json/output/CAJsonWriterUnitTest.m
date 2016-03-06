// Copyright (c) 2013 Richard Long & HexBeerium
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//

#import "CALog.h"
#import "CAJsonObject.h"
#import "CAJsonStringOutput.h"
#import "CAJsonWalker.h"
#import "CAJsonWriter.h"
#import "CAJsonWriterUnitTest.h"



@implementation CAJsonWriterUnitTest


-(void)test1 {
    Log_enteredMethod();
}

-(void)testEmptyObject {
    
    CAJsonStringOutput* output = [[CAJsonStringOutput alloc] init];
    {
        
        CAJsonWriter* writer = [[CAJsonWriter alloc] initWithOutput:output];
        
        
        CAJsonObject* target = [[CAJsonObject alloc] init];
        
        
        [CAJsonWalker walkJsonObjectDocument:target visitor:writer];
    }
    NSString* actual = [output toString];
    Log_debugString( actual );
    XCTAssertTrue([@"{}" isEqualToString:actual], @"actual = '%@'", actual);
    
}


-(void)testEmptyArray {
    
    CAJsonStringOutput* output = [[CAJsonStringOutput alloc] init];
    {
        
        CAJsonWriter* writer = [[CAJsonWriter alloc] initWithOutput:output];
        
        CAJsonArray* target = [[CAJsonArray alloc] init];
        
        [CAJsonWalker walkJsonArrayDocument:target visitor:writer];
    }
    NSString* actual = [output toString];
    Log_debugString( actual );
    XCTAssertTrue([@"[]" isEqualToString:actual], @"actual = '%@'", actual);
    
}

-(void)testSimpleObject {
    
    
    CAJsonStringOutput* output = [[CAJsonStringOutput alloc] init];
    {
        
        CAJsonWriter* writer = [[CAJsonWriter alloc] initWithOutput:output];
        
        
        CAJsonObject* target = [[CAJsonObject alloc] init];
        [target setObject:nil forKey:@"nullKey"];
        [target setBool:true forKey:@"booleanKey"];
        [target setInt:314 forKey:@"integerKey"];
        [target setObject:@"value" forKey:@"stringKey"];
        
        
        [CAJsonWalker walkJsonObjectDocument:target visitor:writer];
    }
    NSString* actual = [output toString];
    Log_debugString( actual );
    XCTAssertTrue([@"{\"stringKey\":\"value\",\"booleanKey\":true,\"integerKey\":314,\"nullKey\":null}" isEqualToString:actual], @"actual = '%@'", actual);

}

-(void)testSimpleArray {
    
    
    CAJsonStringOutput* output = [[CAJsonStringOutput alloc] init];
    {
        
        CAJsonWriter* writer = [[CAJsonWriter alloc] initWithOutput:output];
        
        
        CAJsonArray* target = [[CAJsonArray alloc] init];
        [target add:nil];
        [target addBoolean:true];
        [target addInt:314];
        [target add:@"value"];
        
        
        
        [CAJsonWalker walkJsonArrayDocument:target visitor:writer];
    }
    NSString* actual = [output toString];
    Log_debugString( actual );
    XCTAssertTrue([@"[null,true,314,\"value\"]" isEqualToString:actual], @"actual = '%@'", actual);

    
}




@end
