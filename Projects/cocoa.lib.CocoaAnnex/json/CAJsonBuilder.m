// Copyright (c) 2013 Richard Long & HexBeerium
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//



#import "CAJsonArray.h"
#import "CAJsonBuilder.h"
#import "CAJsonObject.h"
#import "CAJsonStack.h"
#import "CALog.h"



////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

@interface CAJsonBuilder ()

// stack
//CAJsonStack* _stack;
@property (nonatomic, retain) CAJsonStack* stack;
//@synthesize stack = _stack;

// objectDocument
//CAJsonObject* _objectDocument;
//@property (nonatomic, readonly) CAJsonObject* objectDocument;
@property (nonatomic, retain, readwrite) CAJsonObject* objectDocument;
//@synthesize objectDocument = _objectDocument;

// arrayDocument
//CAJsonArray* _arrayDocument;
//@property (nonatomic, readonly) CAJsonArray* arrayDocument;
@property (nonatomic, retain, readwrite) CAJsonArray* arrayDocument;
//@synthesize arrayDocument = _arrayDocument;



@end

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////


#pragma mark -

@implementation CAJsonBuilder


#pragma mark -
#pragma mark document

-(void)onObjectDocumentStart {
    
    _objectDocument = [[CAJsonObject alloc] init];
    [_stack pushJsonObject:_objectDocument];
    
}

-(void)onObjectDocumentEnd {
    
    [_stack pop];
    
}


-(void)onArrayDocumentStart {
    _arrayDocument = [[CAJsonArray alloc] init];
    [_stack pushJsonArray:_arrayDocument];
}

-(void)onArrayDocumentEnd {
    [_stack pop];
    
}



#pragma mark -
#pragma mark object

-(void)onArrayStartWithKey:(NSString*)key {
    
    
    CAJsonArray* jsonArray = [[CAJsonArray alloc] init];
    {
        [[_stack currentObject] setObject:jsonArray forKey:key];
        [_stack pushJsonArray:jsonArray];
    }
    
}

-(void)onArrayEndWithKey:(NSString*)key {
    
    [_stack pop];
    
}


-(void)onBooleanWithKey:(NSString*)key value:(bool)value {
    
    [[_stack currentObject] setBool:value forKey:key];
    
}

-(void)onNullWithKey:(NSString*)key {
    
    [[_stack currentObject] setObject:nil forKey:key];
    
}

-(void)onNumberWithKey:(NSString*)key value:(NSNumber*)value {
    
    [[_stack currentObject] setObject:value forKey:key];
    
}


-(void)onObjectStartWithKey:(NSString*)key {
    
    CAJsonObject* jsonObject = [[CAJsonObject alloc] init];
    {
        [[_stack currentObject] setObject:jsonObject forKey:key];
        [_stack pushJsonObject:jsonObject];
    }

    
}

-(void)onObjectEndWithKey:(NSString*)key {
    
    [_stack pop];

}


-(void)onStringWithKey:(NSString*)key value:(NSString*)value {
    
    [[_stack currentObject] setObject:value forKey:key];
    
}


#pragma mark -
#pragma mark array

-(void)onArrayStartWithIndex:(NSUInteger)index {
    
    
    CAJsonArray* jsonArray = [[CAJsonArray alloc] init];
    {
        [[_stack currentArray] add:jsonArray];
        [_stack pushJsonArray:jsonArray];
    }
    
    
}

-(void)onArrayEndWithIndex:(NSUInteger)index {

    [_stack pop];

}



-(void)onBooleanWithIndex:(NSUInteger)index value:(bool)value {
    
    [[_stack currentArray] addBoolean:value];

}

-(void)onNullWithIndex:(NSUInteger)index {
    
    [[_stack currentArray] add:nil];
    
}

-(void)onNumberWithIndex:(NSUInteger)index value:(NSNumber*)value {
    
    [[_stack currentArray] add:value];
    
}


-(void)onObjectStartWithIndex:(NSUInteger)index {
    
    CAJsonObject* jsonObject = [[CAJsonObject alloc] init];
    {
        [[_stack currentArray] add:jsonObject];
        [_stack pushJsonObject:jsonObject];
    }
    
}

-(void)onObjectEndWithIndex:(NSUInteger)index {
    
    [_stack pop];

}


-(void)onStringWithIndex:(NSUInteger)index value:(NSString*)value {
    
    [[_stack currentArray] add:value];

}


#pragma mark -
#pragma mark instance lifecycle


-(id)init {
    
    CAJsonBuilder* answer = [super init];
    
    if( nil != answer ) {
        
        answer->_stack = [[CAJsonStack alloc] init];
    }
    
    return answer;
}


-(void)dealloc {
	
	[self setStack:nil];
	[self setObjectDocument:nil];
	[self setArrayDocument:nil];
	
}

#pragma mark -
#pragma mark fields

// stack
//CAJsonStack* _stack;
//@property (nonatomic, retain) CAJsonStack* stack;
@synthesize stack = _stack;

// objectDocument
//CAJsonObject* _objectDocument;
//@property (nonatomic, readonly) CAJsonObject* objectDocument;
//@property (nonatomic, retain, readwrite) CAJsonObject* objectDocument;
@synthesize objectDocument = _objectDocument;

// arrayDocument
//CAJsonArray* _arrayDocument;
//@property (nonatomic, readonly) CAJsonArray* arrayDocument;
//@property (nonatomic, retain, readwrite) CAJsonArray* arrayDocument;
@synthesize arrayDocument = _arrayDocument;


@end
