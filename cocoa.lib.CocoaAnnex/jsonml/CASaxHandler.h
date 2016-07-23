// Copyright (c) 2014 Richard Long & HexBeerium
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//


#import <Foundation/Foundation.h>

#import "CAJsonDocumentHandler.h"

@interface CASaxHandler : NSObject <NSXMLParserDelegate> {

    
    
    int _currentIndex;
    
    // elementText
    NSMutableString* _elementText;
    //@property (nonatomic, retain) NSMutableString* elementText;
    //@synthesize elementText = _elementText;

    
    bool _ignoreEmptyStrings;
    
    // indices
    NSMutableArray* _indices;
    //@property (nonatomic, retain) NSMutableArray* indices;
    //@synthesize indices = _indices;

    // jsonHandler
    id<CAJsonDocumentHandler> _jsonHandler;
    //@property (nonatomic, retain) id<CAJsonDocumentHandler> jsonHandler;
    //@synthesize jsonHandler = _jsonHandler;

    bool _trim;
    
    
}



#pragma mark -
#pragma mark instance lifecycle


-(id)initWithJsonHandler:(id<CAJsonDocumentHandler>)jsonHandler;



@end
