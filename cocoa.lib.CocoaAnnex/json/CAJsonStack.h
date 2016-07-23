// Copyright (c) 2013 Richard Long & HexBeerium
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//



#import <Foundation/Foundation.h>

@class CAJsonArray;
@class CAJsonObject;


@interface CAJsonStack : NSObject {
    
    // stack
    NSMutableArray* _stack;
    //@property (nonatomic, retain) NSMutableArray* stack;
    //@synthesize stack = _stack;

    // currentObject
    CAJsonObject* _currentObject;
    //@property (nonatomic, retain) CAJsonObject* currentObject;
    //@synthesize currentObject = _currentObject;
    
    // currentArray
    CAJsonArray* _currentArray;
    //@property (nonatomic, retain) CAJsonArray* currentArray;
    //@synthesize currentArray = _currentArray;


}

-(id)pop;
-(void)pushJsonObject:(CAJsonObject*)top;
-(void)pushJsonArray:(CAJsonArray*)top;


#pragma mark -
#pragma mark fields

// currentObject
//CAJsonObject* _currentObject;
@property (nonatomic, readonly, retain) CAJsonObject* currentObject;
//@synthesize currentObject = _currentObject;

// currentArray
//CAJsonArray* _currentArray;
@property (nonatomic, readonly, retain) CAJsonArray* currentArray;
//@synthesize currentArray = _currentArray;

@end
