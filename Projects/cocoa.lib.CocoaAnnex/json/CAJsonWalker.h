// Copyright (c) 2013 Richard Long & HexBeerium
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//



#import <Foundation/Foundation.h>

#import "CAJsonArray.h"
#import "CAJsonDocumentHandler.h"
#import "CAJsonObject.h"


@interface CAJsonWalker : NSObject {
    
    bool _continue;
    
}

-(void)walkJsonArrayDocument:(CAJsonArray*)jsonArray visitor:(id<CAJsonDocumentHandler>)visitor;
-(void)walkJsonObjectDocument:(CAJsonObject*)jsonObject visitor:(id<CAJsonDocumentHandler>)visitor;

+(void)walkJsonArrayDocument:(CAJsonArray*)jsonArray visitor:(id<CAJsonDocumentHandler>)visitor;
+(void)walkJsonObjectDocument:(CAJsonObject*)jsonObject visitor:(id<CAJsonDocumentHandler>)visitor;


@end
