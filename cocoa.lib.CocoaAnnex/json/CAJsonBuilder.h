// Copyright (c) 2013 Richard Long & HexBeerium
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//


#import <Foundation/Foundation.h>

@class CAJsonArray;
@class CAJsonObject;
#import "CAJsonDocumentHandler.h"
@class CAJsonStack;

@interface CAJsonBuilder : NSObject <CAJsonDocumentHandler> {
    
    // stack
    CAJsonStack* _stack;
    //@property (nonatomic, retain) CAJsonStack* stack;
    //@synthesize stack = _stack;
    
    
    // objectDocument
    CAJsonObject* _objectDocument;
    //@property (nonatomic, readonly) CAJsonObject* objectDocument;
    //@property (nonatomic, retain, readwrite) CAJsonObject* objectDocument;
    //@synthesize objectDocument = _objectDocument;


    // arrayDocument
    CAJsonArray* _arrayDocument;
    //@property (nonatomic, readonly) CAJsonArray* arrayDocument;
    //@property (nonatomic, retain, readwrite) CAJsonArray* arrayDocument;
    //@synthesize arrayDocument = _arrayDocument;

}


#pragma mark -
#pragma mark fields

// objectDocument
//CAJsonObject* _objectDocument;
@property (nonatomic, readonly) CAJsonObject* objectDocument;
//@property (nonatomic, retain, readwrite) CAJsonObject* objectDocument;
//@synthesize objectDocument = _objectDocument;


// arrayDocument
//CAJsonArray* _arrayDocument;
@property (nonatomic, readonly) CAJsonArray* arrayDocument;
//@property (nonatomic, retain, readwrite) CAJsonArray* arrayDocument;
//@synthesize arrayDocument = _arrayDocument;

@end
