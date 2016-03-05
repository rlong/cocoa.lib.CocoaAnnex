// Copyright (c) 2013 Richard Long & HexBeerium
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//

#import "CALog.h"
#import "CAStringHelper.h"
#import "CAStringHelperUnitTest.h"


@implementation CAStringHelperUnitTest

-(void)test1 {
    Log_enteredMethod();
}




-(void)testUnescapeHtmlCodes {

    NSString* expected = @"A & B";
    NSString* actual = [CAStringHelper unescapeHtmlCodes:@"A &#38; B"];
    XCTAssertTrue( [expected isEqualToString:actual], @"actual = %@", actual );

    expected = @"& B";
    actual = [CAStringHelper unescapeHtmlCodes:@"&#38; B"];    
    XCTAssertTrue( [expected isEqualToString:actual], @"actual = %@", actual );

    expected = @"A &";
    actual = [CAStringHelper unescapeHtmlCodes:@"A &#38;"];
    XCTAssertTrue( [expected isEqualToString:actual], @"actual = %@", actual );

    expected = @"A & B &";
    actual = [CAStringHelper unescapeHtmlCodes:@"A &#38; B &#38;"];
    XCTAssertTrue( [expected isEqualToString:actual], @"actual = %@", actual );

}
@end
