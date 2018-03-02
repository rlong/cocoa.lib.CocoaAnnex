// Copyright (c) 2015 Richard Long & HexBeerium
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//




#import "CABaseException.h"
#import "CAJsonArray.h"
#import "CAJsonArrayHandler.h"
#import "CAJsonObject.h"
#import "CAJsonStringOutput.h"

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

@interface CAJsonArray () 




@end 

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
#pragma mark -

@implementation CAJsonArray {
    
    NSMutableDictionary* _wrappedValues;
}


static NSObject* _NULL_OBJECT = nil;


+(NSString*)NULL_VALUE_REFERENCED {
    return @"jsonbroker.JsonArray.NULL_VALUE_REFERENCED";
}



+(void)initialize {
	
	_NULL_OBJECT = [NSNull null];
    
}



#pragma mark instance lifecycle

-(instancetype)init {
    
    self = [super init];
    
    
    if( nil != self ) {
        
        self->_values = [[NSMutableArray alloc] init];
        _wrappedValues = [[NSMutableDictionary alloc] init];

        
    }
    
    return self;
}

-(instancetype)initWithCapacity:(long)capacity {
    
    self = [super init];
    
    
    if( nil != self ) {
        
        self->_values = [[NSMutableArray alloc] initWithCapacity:capacity];
        _wrappedValues = [[NSMutableDictionary alloc] init];

    }
    
    return self;
    
}


-(instancetype)initWithValue:(NSMutableArray*)values;
{
    
    self = [super init];
    
    if( self ) {
        self->_values = values;
        _wrappedValues = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}



-(void)dealloc {
    
    
    [self setValues:nil];
    _wrappedValues = nil;
    
}

#pragma mark -



-(id)getBlobAtIndex:(NSUInteger)index throwExceptionOnNil:(bool)throwExceptionOnNil{
    
    
	
	id answer = [_values objectAtIndex:index];
    
    if( _NULL_OBJECT == answer ) {
        answer = nil;
    }
	
	if( nil == answer && throwExceptionOnNil ) {
        NSString* technicalError = [NSString stringWithFormat:@"nil == answer; index = %ld",(unsigned long)index];
		BaseException *e = [[BaseException alloc] initWithOriginator:self line:__LINE__ faultMessage:technicalError];
        [e setErrorDomain:[CAJsonArray NULL_VALUE_REFERENCED]];
		@throw e;
		
	}
	
	return answer;
	
}



-(void)add:(id)object { 
	
	if( nil == object ) {
		[_values addObject:_NULL_OBJECT];
		return;
	}
	
    if( [object isKindOfClass:[CAJsonObject class]] ) {
        
        CAJsonObject* jsonObject = (CAJsonObject*)object;
        [_values addObject:[jsonObject values]];
        
        NSUInteger index = [_values count]-1;
        NSNumber* key = [NSNumber numberWithUnsignedInteger:index];
        [_wrappedValues setObject:jsonObject forKey:key];
    } else if( [object isKindOfClass:[CAJsonArray class]] ) {
        
        CAJsonArray* jsonArray = (CAJsonArray*)object;
        [_values addObject:[jsonArray values]];

        NSUInteger index = [_values count]-1;
        NSNumber* key = [NSNumber numberWithUnsignedInteger:index];
        [_wrappedValues setObject:jsonArray forKey:key];
        
    } else {
        
        [_values addObject:object];
//        [_values setObject:object forKey:key];
    }

	
}


-(void)addBoolean:(bool)value { 
    
    
    NSNumber* boolean = [NSNumber numberWithBool:value];
    
    [_values addObject:boolean];

    
}

-(bool)getBoolean:(NSUInteger)index {
    
    id blob = [self getBlobAtIndex:index throwExceptionOnNil:true];
    

    if( ![blob isKindOfClass:[NSNumber class]] ) { 
		
        NSString* technicalError = [NSString stringWithFormat:@"![blob isKindOfClass:[NSNumber class]]; NSStringFromClass([blob class]) = %@", NSStringFromClass([blob class])];
		BaseException *e = [[BaseException alloc] initWithOriginator:self line:__LINE__ faultMessage:technicalError];
		@throw e;
	}
	
	NSNumber* answer = (NSNumber*)blob;
	return [answer boolValue];
    
    
}


-(void)addInt:(int)value {
    
    [_values addObject:[NSNumber numberWithInt:value]];
    
}

-(void)addUnsignedInteger:(NSUInteger)value {

    [_values addObject:[NSNumber numberWithUnsignedInteger:value]];

}

-(int)getInt:(NSUInteger)index {
	
    id blob = [self getBlobAtIndex:index throwExceptionOnNil:true];
	
	if( ![blob isKindOfClass:[NSNumber class]] ) {

        NSString* technicalError = [NSString stringWithFormat:@"![blob isKindOfClass:[NSNumber class]]; NSStringFromClass([blob class]) = %@", NSStringFromClass([blob class])];
		BaseException *e = [[BaseException alloc] initWithOriginator:self line:__LINE__ faultMessage:technicalError];
		@throw e;
	}
	
	NSNumber* number = (NSNumber*)blob;
	return [number intValue];
}




-(void)addInteger:(NSInteger)value {
    
    [_values addObject:[NSNumber numberWithInteger:value]];
    
}

// deprecated: use integerAtIndex
-(NSInteger)getInteger:(NSUInteger)index {
	
    id blob = [self getBlobAtIndex:index throwExceptionOnNil:true];
	
	if( ![blob isKindOfClass:[NSNumber class]] ) { 
		
        NSString* technicalError = [NSString stringWithFormat:@"![blob isKindOfClass:[NSNumber class]]; NSStringFromClass([blob class]) = %@", NSStringFromClass([blob class])];
		BaseException *e = [[BaseException alloc] initWithOriginator:self line:__LINE__ faultMessage:technicalError];
		@throw e;
	}
	
	NSNumber* number = (NSNumber*)blob;
	return [number integerValue];
}



-(NSUInteger)getUnsignedInteger:(NSUInteger)index {
	
    id blob = [self getBlobAtIndex:index throwExceptionOnNil:true];
	
	if( ![blob isKindOfClass:[NSNumber class]] ) {
		
        NSString* technicalError = [NSString stringWithFormat:@"![blob isKindOfClass:[NSNumber class]]; NSStringFromClass([blob class]) = %@", NSStringFromClass([blob class])];
		BaseException *e = [[BaseException alloc] initWithOriginator:self line:__LINE__ faultMessage:technicalError];
		@throw e;
	}
	
	NSNumber* number = (NSNumber*)blob;
	return [number unsignedIntegerValue];
}


-(NSInteger)integerAtIndex:(NSUInteger)index {

    id blob = [self getBlobAtIndex:index throwExceptionOnNil:true];
    
    if( ![blob isKindOfClass:[NSNumber class]] ) {
        
        NSString* technicalError = [NSString stringWithFormat:@"![blob isKindOfClass:[NSNumber class]]; NSStringFromClass([blob class]) = %@", NSStringFromClass([blob class])];
        BaseException *e = [[BaseException alloc] initWithOriginator:self line:__LINE__ faultMessage:technicalError];
        @throw e;
    }
    
    NSNumber* number = (NSNumber*)blob;
    return [number integerValue];

}


-(CAJsonArray*)jsonArrayAtIndex:(NSUInteger)index {
	
	
    id blob = [self getBlobAtIndex:index throwExceptionOnNil:true];

    
    if( ![blob isKindOfClass:[NSMutableArray class]] ) {
        NSString* technicalError = [NSString stringWithFormat:@"![blob isKindOfClass:[NSMutableArray class]]; NSStringFromClass([blob class]) = %@", NSStringFromClass([blob class])];
        
        BaseException *e = [[BaseException alloc] initWithOriginator:self line:__LINE__ faultMessage:technicalError];
        @throw e;
    }

    NSNumber* key = [NSNumber numberWithUnsignedInteger:index];
    CAJsonArray* answer = [_wrappedValues objectForKey:key];
    if( nil == answer ) {
        
        NSMutableArray* mutableArray = (NSMutableArray*)blob;
        answer = [[CAJsonArray alloc] initWithValue:mutableArray];
        [_wrappedValues setObject:answer forKey:key];
    }
    
    return answer;
}

-(CAJsonObject*)jsonObjectAtIndex:(NSUInteger)index {
	
    id blob = [self getBlobAtIndex:index throwExceptionOnNil:true];
    

    if( ![blob isKindOfClass:[NSMutableDictionary class]] ) {
        
        NSString* technicalError = [NSString stringWithFormat:@"![blob isKindOfClass:[NSMutableDictionary class]]; NSStringFromClass([blob class]) = %@", NSStringFromClass([blob class])];
        
        BaseException *e = [[BaseException alloc] initWithOriginator:self line:__LINE__ faultMessage:technicalError];
        @throw e;
        
    }

    NSNumber* key = [NSNumber numberWithUnsignedInteger:index];
    CAJsonObject* answer = [_wrappedValues objectForKey:key];
    if( nil == answer ) {
        
        NSMutableDictionary* mutableArray = (NSMutableDictionary*)blob;
        answer = [[CAJsonObject alloc] initWithValue:mutableArray];
        [_wrappedValues setObject:answer forKey:key];
    }
    
    return answer;

}

-(NSNumber*)numberAtIndex:(NSUInteger)index {
    
    id blob = [self getBlobAtIndex:index throwExceptionOnNil:true];
    
    if( ![blob isKindOfClass:[NSNumber class]] ) {
		
        NSString* technicalError = [NSString stringWithFormat:@"![blob isKindOfClass:[NSNumber class]]; NSStringFromClass([blob class]) = %@", NSStringFromClass([blob class])];
		BaseException *e = [[BaseException alloc] initWithOriginator:self line:__LINE__ faultMessage:technicalError];
		@throw e;
	}
	
	NSNumber* answer = (NSNumber*)blob;
    return answer;

    
}


-(id)objectAtIndex:(NSUInteger)index {
	
    id blob = [self getBlobAtIndex:index throwExceptionOnNil:true];
	
	return blob;
	
}

-(id)objectAtIndex:(NSUInteger)index defaultValue:(id)defaultValue {

    id blob = [self getBlobAtIndex:index throwExceptionOnNil:false];
    
    if( nil == blob ) {
        return defaultValue;
    }
	
	return blob;

}

-(NSString*)getString:(NSUInteger)index {
	
    id blob = [self getBlobAtIndex:index throwExceptionOnNil:true];
	
	if( ![blob isKindOfClass:[NSString class]] ) { 
		
        NSString* technicalError = [NSString stringWithFormat:@"![blob isKindOfClass:[NSString class]]; NSStringFromClass([blob class]) = %@", NSStringFromClass([blob class])];
		BaseException *e = [[BaseException alloc] initWithOriginator:self line:__LINE__ faultMessage:technicalError];
		@throw e;
	}
	
	NSString* answer = (NSString*)blob;
	return answer;
}


-(NSString*)getString:(NSUInteger)index defaultValue:(NSString*)defaultValue{
	
    id blob = [self getBlobAtIndex:index throwExceptionOnNil:false];
    
    if( nil == blob ) {
        return defaultValue;
    }
	
	if( ![blob isKindOfClass:[NSString class]] ) { 
		
        NSString* technicalError = [NSString stringWithFormat:@"![blob isKindOfClass:[NSString class]]; NSStringFromClass([blob class]) = %@", NSStringFromClass([blob class])];
		BaseException *e = [[BaseException alloc] initWithOriginator:self line:__LINE__ faultMessage:technicalError];
		@throw e;
	}
	
	NSString* answer = (NSString*)blob;
	return answer;
	
	
}



-(int)length {
    
	return (int)[_values count];
    
}

-(int)count { 
	return (int)[_values count];
}


-(void)removeAllObjects {
    [_values removeAllObjects];
}

-(void)removeObjectAtIndex:(int)index {
    [_values removeObjectAtIndex:index];
}

-(NSString*)stringAtIndex:(NSUInteger)index {
    
    
    id blob = [self getBlobAtIndex:index throwExceptionOnNil:true];
    
    if( ![blob isKindOfClass:[NSString class]] ) {
        
        NSString* technicalError = [NSString stringWithFormat:@"![blob isKindOfClass:[NSString class]]; NSStringFromClass([blob class]) = %@", NSStringFromClass([blob class])];
        BaseException *e = [[BaseException alloc] initWithOriginator:self line:__LINE__ faultMessage:technicalError];
        @throw e;
    }
    
    NSString* answer = (NSString*)blob;
    return answer;

    
}


-(NSString*)toString { 
	
	NSString* answer = nil;
	
	
	CAJsonStringOutput* writer = [[CAJsonStringOutput alloc] init];
	{
		[[CAJsonArrayHandler getInstance] writeValue:self writer:writer];
		
		answer = [writer toString];
		
	}
	
	return answer;
	
}




//NSMutableArray* _values;
//@property (nonatomic, retain) NSMutableArray* values;
@synthesize values = _values;

@end
