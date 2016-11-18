//  Copyright (c) 2013 Richard Long & HexBeerium
//
//  Released under the MIT license ( http://opensource.org/licenses/MIT )
//


#import "CAKeychainUtilities.h"
#import "CAKeychainUtilitiesIntegrationTest.h"
#import "CALog.h"


@implementation CAKeychainUtilitiesIntegrationTest




-(void)test1 {
    Log_enteredMethod();
    
}


-(void)testGetSavedUsername {
    
    Log_enteredMethod();

    NSString* savedUsername = [JBKeychainUtilities getSavedUsername];
    Log_debugString(savedUsername);
    
}




@end
