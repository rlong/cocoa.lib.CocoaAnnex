// Copyright (c) 2013 Richard Long & HexBeerium
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//


#import "CAJsonArray.h"
#import "CAJsonObject.h"
#import "CAJsonStack.h"


////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

@interface CAJsonStack ()

// stack
//NSMutableArray* _stack;
@property (nonatomic, retain) NSMutableArray* stack;
//@synthesize stack = _stack;

// currentObject
//CAJsonObject* _currentObject;
@property (nonatomic, readwrite, retain) CAJsonObject* currentObject;
//@synthesize currentObject = _currentObject;

// currentArray
//CAJsonArray* _currentArray;
@property (nonatomic, readwrite, retain) CAJsonArray* currentArray;
//@synthesize currentArray = _currentArray;

@end

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
#pragma mark -

@implementation CAJsonStack


-(id)pop {
    
    
    id popped = [_stack lastObject];
    {
        [_stack removeLastObject];
    }
    
    [self setCurrentObject:nil];
    [self setCurrentArray:nil];
    
    if( 0 != [_stack count] ) {
        
        id current = [_stack lastObject];
        if( [current isKindOfClass:[CAJsonObject class]] ) {
            [self setCurrentObject:current];
        } else {
            [self setCurrentArray:current];
        }
    }
    
    return popped;
    
}

-(void)pushJsonObject:(CAJsonObject*)top {
    
    [_stack addObject:top];
    [self setCurrentObject:top];
    [self setCurrentArray:nil];
    
}

-(void)pushJsonArray:(CAJsonArray*)top {

    [_stack addObject:top];
    [self setCurrentObject:nil];
    [self setCurrentArray:top];
}



#pragma mark -
#pragma mark instance lifecycle


-(id)init {
    
    CAJsonStack* answer = [super init];
    
    if( nil != answer ) {
        
        answer->_stack = [[NSMutableArray alloc] init];
    }
    
    return answer;
}

-(void)dealloc {
	
	[self setStack:nil];
    [self setCurrentObject:nil];
	[self setCurrentArray:nil];

	
}

#pragma mark -
#pragma mark fields

// stack
//NSMutableArray* _stack;
//@property (nonatomic, retain) NSMutableArray* stack;
@synthesize stack = _stack;

// currentObject
//CAJsonObject* _currentObject;
//@property (nonatomic, retain) CAJsonObject* currentObject;
@synthesize currentObject = _currentObject;

// currentArray
//CAJsonArray* _currentArray;
//@property (nonatomic, retain) CAJsonArray* currentArray;
@synthesize currentArray = _currentArray;


@end
