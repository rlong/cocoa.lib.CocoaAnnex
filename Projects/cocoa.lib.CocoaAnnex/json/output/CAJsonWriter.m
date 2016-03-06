// Copyright (c) 2013 Richard Long & HexBeerium
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//

#import "CAJsonBooleanHandler.h"
#import "CAJsonNullHandler.h"
#import "CAJsonNumberHandler.h"
#import "CAJsonStringHandler.h"
#import "CAJsonWriter.h"

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

@interface CAJsonWriter ()

// output
//id<CAJsonOutput> _output;
@property (nonatomic, retain) id<CAJsonOutput> output;
//@synthesize output = _output;


@end

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
#pragma mark -


@implementation CAJsonWriter



#pragma mark -
#pragma mark <CAJsonDocumentHandler> implementation



#pragma mark -
#pragma mark document

-(void)onObjectDocumentStart {
    
    [_output appendChar:'{'];
    _objectStarted = true;
    
    
}

-(void)onObjectDocumentEnd {
    
    [_output appendChar:'}'];
    _objectStarted = false;
    
    
}


-(void)onArrayDocumentStart {
    
    [_output appendChar:'['];
    
    
}

-(void)onArrayDocumentEnd {
    
    [_output appendChar:']'];

}



#pragma mark -
#pragma mark object

-(void)onArrayStartWithKey:(NSString*)key {
    
    if( _objectStarted ) {
        _objectStarted = false;
    } else {
        [_output appendChar:','];
    }
    
    
    [CAJsonStringHandler writeString:key writer:_output];
    [_output appendString:@":["];
    
    
    
}

-(void)onArrayEndWithKey:(NSString*)key {
    
    [_output appendChar:']'];

}


-(void)onBooleanWithKey:(NSString*)key value:(bool)value {

    if( _objectStarted ) {
        _objectStarted = false;
    } else {
        [_output appendChar:','];
    }
    
    
    [CAJsonStringHandler writeString:key writer:_output];
    [_output appendChar:':'];
    [CAJsonBooleanHandler writeBoolean:value writer:_output];

    
}

-(void)onNullWithKey:(NSString*)key {
    
    if( _objectStarted ) {
        _objectStarted = false;
    } else {
        [_output appendChar:','];
    }
    
    
    [CAJsonStringHandler writeString:key writer:_output];
    [_output appendChar:':'];
    [CAJsonNullHandler writeNullTo:_output];

    
}

-(void)onNumberWithKey:(NSString*)key value:(NSNumber*)value {

    if( _objectStarted ) {
        _objectStarted = false;
    } else {
        [_output appendChar:','];
    }
    
    
    [CAJsonStringHandler writeString:key writer:_output];
    [_output appendChar:':'];
    [CAJsonNumberHandler writeNumber:value writer:_output];
    
}


-(void)onObjectStartWithKey:(NSString*)key {
    
    if( _objectStarted ) {
        _objectStarted = false;
    } else {
        [_output appendChar:','];
    }
    
    
    [CAJsonStringHandler writeString:key writer:_output];
    [_output appendString:@":{"];
    _objectStarted = true;
    
    
    
}

-(void)onObjectEndWithKey:(NSString*)key {
    
    [_output appendChar:'}'];
    _objectStarted = false;


}


-(void)onStringWithKey:(NSString*)key value:(NSString*)value {
    
    
    if( _objectStarted ) {
        _objectStarted = false;
    } else {
        [_output appendChar:','];
    }
    
    
    [CAJsonStringHandler writeString:key writer:_output];
    [_output appendChar:':'];
    [CAJsonStringHandler writeString:value writer:_output];

}


#pragma mark -
#pragma mark array

-(void)onArrayStartWithIndex:(NSUInteger)index {
    
    if( 0 != index ) {
        [_output appendChar:','];
    }
    
    [_output appendChar:'['];
    
    
}

-(void)onArrayEndWithIndex:(NSUInteger)index {
    
    [_output appendChar:']'];

}



-(void)onBooleanWithIndex:(NSUInteger)index value:(bool)value {
    
    if( 0 != index ) {
        [_output appendChar:','];
    }

    [CAJsonBooleanHandler writeBoolean:value writer:_output];

}

-(void)onNullWithIndex:(NSUInteger)index {
    
    if( 0 != index ) {
        [_output appendChar:','];
    }

    [CAJsonNullHandler writeNullTo:_output];

}

-(void)onNumberWithIndex:(NSUInteger)index value:(NSNumber*)value {
    
    if( 0 != index ) {
        [_output appendChar:','];
    }

    [CAJsonNumberHandler writeNumber:value writer:_output];

}


-(void)onObjectStartWithIndex:(NSUInteger)index {
    
    if( 0 != index ) {
        [_output appendChar:','];
    }

    [_output appendChar:'{'];
    _objectStarted = true;

    
}

-(void)onObjectEndWithIndex:(NSUInteger)index {
    
    [_output appendChar:'}'];
    _objectStarted = false;

}


-(void)onStringWithIndex:(NSUInteger)index value:(NSString*)value {
    
    if( 0 != index ) {
        [_output appendChar:','];
    }

    [CAJsonStringHandler writeString:value writer:_output];
    
}


#pragma mark -
#pragma mark instance lifecycle


-(id)initWithOutput:(id<CAJsonOutput>)output {
    
    CAJsonWriter* answer = [super init];
    
    if( nil != answer ) {
        
        [answer setOutput:output];
    }
    
    return answer;
    
}

-(void)dealloc {
	[self setOutput:nil];
	
	
}


#pragma mark -
#pragma mark fields



// output
//id<CAJsonOutput> _output;
//@property (nonatomic, retain) id<CAJsonOutput> output;
@synthesize output = _output;

@end
