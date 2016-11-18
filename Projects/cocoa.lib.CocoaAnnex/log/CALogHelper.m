//  Copyright (c) 2013 Richard Long & HexBeerium
//
//  Released under the MIT license ( http://opensource.org/licenses/MIT )
//



#import "CALog.h"
#import "CALogHelper.h"
#import "CASimpleLogConsumer.h"

@implementation CALogHelper



+(CASimpleLogConsumer*)setupSimpleLogConsumer {
    
    CASimpleLogConsumer* answer = [[CASimpleLogConsumer alloc] init];
    {
        [CALog setLogConsumer:answer forCaller:__func__];
    }
    
    return answer;

}

@end
