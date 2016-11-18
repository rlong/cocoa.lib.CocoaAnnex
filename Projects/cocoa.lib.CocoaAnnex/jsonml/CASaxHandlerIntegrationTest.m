// Copyright (c) 2014 Richard Long & HexBeerium
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//

#import "CALog.h"
#import "CAJsonArray.h"
#import "CAJsonBuilder.h"
#import "CASaxHandler.h"
#import "CASaxHandlerIntegrationTest.h"


@implementation CASaxHandlerIntegrationTest



-(NSData*)resolve :(NSString*)xmlFile {
	
	NSString *path = [[NSBundle mainBundle] pathForResource:xmlFile ofType: @"xml"];
    Log_debugString( path );
    
	XCTAssertTrue( nil != path  );
	
	NSURL* url = [NSURL fileURLWithPath:path];
	NSData* answer = [NSData dataWithContentsOfURL:url];
	return answer;
	
}

-(void)test1 {
    Log_enteredMethod();
}

-(void)testSimple {
    
    NSData* xml = [self resolve:@"CASaxHandlerIntegrationTest.testSimple"];
	XCTAssertTrue( nil != xml, @"actual = %p", xml);
    
    
    CAJsonBuilder* jsonBuilder = [[CAJsonBuilder alloc] init];
    CASaxHandler* handler = [[CASaxHandler alloc] initWithJsonHandler:jsonBuilder];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:xml];

    [parser setDelegate:handler];
    [parser parse];
    
    CAJsonArray* jsonArray = [jsonBuilder arrayDocument];
	XCTAssertTrue( nil != jsonArray, @"actual = %p", jsonArray);

    Log_debugString( [jsonArray toString] );
    
    NSString* rootElementName = [jsonArray getString:0];
    XCTAssertTrue( [@"company" isEqualToString:rootElementName],  @"actual = %@", rootElementName );
    
    
}

-(void)testRss {

    
    NSData* xml = [self resolve:@"CASaxHandlerIntegrationTest.testRss"];
	XCTAssertTrue( nil != xml, @"actual = %p", xml);
    
    
    CAJsonBuilder* jsonBuilder = [[CAJsonBuilder alloc] init];
    CASaxHandler* handler = [[CASaxHandler alloc] initWithJsonHandler:jsonBuilder];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:xml];
    
    [parser setDelegate:handler];
    [parser parse];
    
    CAJsonArray* jsonArray = [jsonBuilder arrayDocument];
	XCTAssertTrue( nil != jsonArray, @"actual = %p", jsonArray);
    
    
}


@end
