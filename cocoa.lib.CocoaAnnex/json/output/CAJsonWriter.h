// Copyright (c) 2013 Richard Long & HexBeerium
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//

#import <Foundation/Foundation.h>

#import "CAJsonDocumentHandler.h"
#import "CAJsonOutput.h"

@interface CAJsonWriter : NSObject <CAJsonDocumentHandler> {
    
    
    // output
    id<CAJsonOutput> _output;
    //@property (nonatomic, retain) id<CAJsonOutput> output;
    //@synthesize output = _output;

    bool _objectStarted;
    
    
    
}

#pragma mark -
#pragma mark instance lifecycle


-(id)initWithOutput:(id<CAJsonOutput>)output;

@end
