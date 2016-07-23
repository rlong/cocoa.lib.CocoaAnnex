// Copyright (c) 2013 Richard Long & HexBeerium
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//

#import <Foundation/Foundation.h>

#import "CAJsonDocumentHandler.h"
#import "CAJsonInput.h"

@interface CAJsonReader : NSObject {
    
    bool _continue;

}


-(void)readFromData:(NSData*)data handler:(id<CAJsonDocumentHandler>)handler;
+(void)readFromData:(NSData*)data handler:(id<CAJsonDocumentHandler>)handler;

-(void)stop;

@end
