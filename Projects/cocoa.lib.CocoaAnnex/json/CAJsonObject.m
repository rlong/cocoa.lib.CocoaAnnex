// Copyright (c) 2013 Richard Long & HexBeerium
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//



#import "CABaseException.h"
#import "CAJsonArray.h"
#import "CAJsonObject.h"
#import "CAStringHelper.h"

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

@interface CAJsonObject () 



@end 

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
#pragma mark -


@implementation CAJsonObject {
    
    NSMutableDictionary* _wrappedValues;
}


static NSObject* _NULL_OBJECT = nil;




+(void)initialize {
	
    _NULL_OBJECT = [NSNull null];

}

#pragma mark - instance lifecycle


-(id)init {
    
    self = [super init];


    if( self ) {
        _values = [[NSMutableDictionary alloc] init];
        _wrappedValues = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

-(instancetype)initWithCapacity:(int)numItems {
    
    self = [super init];

    
    if( self ) {
        self->_values = [[NSMutableDictionary alloc] initWithCapacity:numItems];
        _wrappedValues = [[NSMutableDictionary alloc] init];
    }
    
    return self;

}


-(instancetype)initWithValue:(NSMutableDictionary*)values;
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


+(CAJsonObject*)fromData:(NSData*)jsonData;
{
    
    
    NSJSONReadingOptions options = NSJSONReadingMutableContainers;
    
    NSError *error = nil;
    id blob = [NSJSONSerialization
               JSONObjectWithData:jsonData
               options:options
               error:&error];
    
    if( nil != error ) {
        
        
        @throw exceptionWithMethodNameAndError(@"[NSJSONSerialization JSONObjectWithData:options:error:]", error);
    }
    
    if(![blob isKindOfClass:[NSMutableDictionary class]]) {
        
        NSString* reason = [NSString stringWithFormat:@"![object isKindOfClass:[NSMutableDictionary class]]; NSStringFromClass([blob class]) = %@", NSStringFromClass([blob class])];
        @throw exceptionWithReason( reason );
        
    }
    
    NSMutableDictionary* mutableDictionary = (NSMutableDictionary*)blob;
    return [[CAJsonObject alloc] initWithValue:mutableDictionary];
    
}



+(CAJsonObject*)fromString:(NSString*)jsonString;
{
    
    NSData* data = [CAStringHelper toUtf8Data:jsonString];
    return [CAJsonObject fromData:data];
	
}



-(NSEnumerator*)keyEnumerator {
	return [_values keyEnumerator];
}

-(NSArray*)allKeys {
	return [_values allKeys];
}


-(id)getBlob:(NSString*)key throwExceptionOnNil:(bool)throwExceptionOnNil{
    
    
	
	id answer = [_values objectForKey:key];
    
    if( _NULL_OBJECT == answer ) { 
        answer = nil;
    }
	
	if( nil == answer && throwExceptionOnNil ) {
        NSString* technicalError = [NSString stringWithFormat:@"nil == answer; key = '%@'",key];
		BaseException *e = [[BaseException alloc] initWithOriginator:self line:__LINE__ faultMessage:technicalError];
		@throw e;
		
	}
	
	return answer;
	
}


#pragma mark -
#pragma mark getters


-(BOOL)boolForKey:(NSString*)key {
    
    id blob = [self getBlob:key throwExceptionOnNil:true];
    
    if( ![blob isKindOfClass:[NSNumber class]] ) {
		
        NSString* technicalError = [NSString stringWithFormat:@"![blob isKindOfClass:[NSNumber class]]; NSStringFromClass([blob class]) = %@", NSStringFromClass([blob class])];
		BaseException *e = [[BaseException alloc] initWithOriginator:self line:__LINE__ faultMessage:technicalError];
		@throw e;
	}
	
	NSNumber* answer = (NSNumber*)blob;
	return [answer boolValue];
}

-(BOOL)boolForKey:(NSString*)key defaultValue:(bool)defaultValue{
    
    id blob = [self getBlob:key throwExceptionOnNil:false];
    
    if( nil == blob ) {
        return defaultValue;
    }
    
    if( ![blob isKindOfClass:[NSNumber class]] ) { 
		
        NSString* technicalError = [NSString stringWithFormat:@"![blob isKindOfClass:[NSNumber class]]; NSStringFromClass([blob class]) = %@", NSStringFromClass([blob class])];
		BaseException *e = [[BaseException alloc] initWithOriginator:self line:__LINE__ faultMessage:technicalError];
		@throw e;
	}
	
	NSNumber* answer = (NSNumber*)blob;
	return [answer boolValue];
}




-(double)doubleForKey:(NSString*)key {

    id blob = [self getBlob:key throwExceptionOnNil:true];
	
	if( ![blob isKindOfClass:[NSNumber class]] ) {
		
		BaseException *e = [[BaseException alloc] initWithOriginator:self line:__LINE__ faultStringFormat:@"![blob isKindOfClass:[NSNumber class]]; key = '%@'", key];
		@throw e;
	}
	
	NSNumber* number = (NSNumber*)blob;
	return [number doubleValue];

}

-(double)doubleForKey:(NSString*)key defaultValue:(double)defaultValue{
    
    
	id blob = [self getBlob:key throwExceptionOnNil:false];
	
	if( nil == blob ) {
		return defaultValue;
	}
	
	if( ![blob isKindOfClass:[NSNumber class]] ) {
		
		BaseException *e = [[BaseException alloc] initWithOriginator:self line:__LINE__ faultStringFormat:@"![blob isKindOfClass:[NSNumber class]]; key = '%@'", key];
		@throw e;
	}
	
	NSNumber* number = (NSNumber*)blob;
	return [number doubleValue];
}



-(NSInteger)integerForKey:(NSString*)key {
    
    id blob = [self getBlob:key throwExceptionOnNil:true];
	
	if( ![blob isKindOfClass:[NSNumber class]] ) {
		
		BaseException *e = [[BaseException alloc] initWithOriginator:self line:__LINE__ faultStringFormat:@"![blob isKindOfClass:[NSNumber class]]; key = '%@'", key];
		@throw e;
	}
	
	NSNumber* number = (NSNumber*)blob;
	return [number integerValue];
}


-(NSInteger)integerForKey:(NSString*)key defaultValue:(NSInteger)defaultValue{

    
	id blob = [self getBlob:key throwExceptionOnNil:false];
	
	if( nil == blob ) {
		return defaultValue;
	}
	
	if( ![blob isKindOfClass:[NSNumber class]] ) { 
		
		BaseException *e = [[BaseException alloc] initWithOriginator:self line:__LINE__ faultStringFormat:@"![blob isKindOfClass:[NSNumber class]]; key = '%@'", key];
		@throw e;
	}
	
	NSNumber* number = (NSNumber*)blob;
	return [number integerValue];
}

-(int)intForKey:(NSString*)key {

	id blob = [self getBlob:key throwExceptionOnNil:true];
    
    if( ![blob isKindOfClass:[NSNumber class]] ) { 
		
        NSString* technicalError = [NSString stringWithFormat:@"![blob isKindOfClass:[NSNumber class]]; NSStringFromClass([blob class]) = %@", NSStringFromClass([blob class])];
		BaseException *e = [[BaseException alloc] initWithOriginator:self line:__LINE__ faultMessage:technicalError];
		@throw e;
	}
	
	NSNumber* answer = (NSNumber*)blob;
	return [answer intValue];


}


-(int)intForKey:(NSString*)key defaultValue:(int)defaultValue {
    id blob = [self getBlob:key throwExceptionOnNil:false];
	
	if( nil == blob ) {
		return defaultValue;
	}
	
	if( ![blob isKindOfClass:[NSNumber class]] ) {
		
		BaseException *e = [[BaseException alloc] initWithOriginator:self line:__LINE__ faultStringFormat:@"![blob isKindOfClass:[NSNumber class]]; key = '%@'", key];
		@throw e;
	}
	
	NSNumber* number = (NSNumber*)blob;
	return [number intValue];
}





-(CAJsonArray*)jsonArrayForKey:(NSString*)key {

    id blob = [self getBlob:key throwExceptionOnNil:true];
    
    if( ![blob isKindOfClass:[NSMutableArray class]] ) {
        NSString* technicalError = [NSString stringWithFormat:@"![blob isKindOfClass:[NSMutableArray class]]; NSStringFromClass([blob class]) = %@", NSStringFromClass([blob class])];
        
        BaseException *e = [[BaseException alloc] initWithOriginator:self line:__LINE__ faultMessage:technicalError];
        @throw e;
    }

    CAJsonArray* answer = [_wrappedValues objectForKey:key];
    if( nil == answer ) {
        
        NSMutableArray* mutableArray = (NSMutableArray*)blob;
        answer = [[CAJsonArray alloc] initWithValue:mutableArray];
        [_wrappedValues setObject:answer forKey:key];
    }

    return answer;
}


-(CAJsonArray*)jsonArrayForKey:(NSString*)key defaultValue:(CAJsonArray*)defaultValue {

    id blob = [self getBlob:key throwExceptionOnNil:false];
    
    if( nil == blob ) { 
        return defaultValue;
    }
    
    if( ![blob isKindOfClass:[NSMutableArray class]] ) {
        NSString* technicalError = [NSString stringWithFormat:@"![blob isKindOfClass:[NSMutableArray class]]; NSStringFromClass([blob class]) = %@", NSStringFromClass([blob class])];
        
        BaseException *e = [[BaseException alloc] initWithOriginator:self line:__LINE__ faultMessage:technicalError];
        @throw e;
    }
    
    CAJsonArray* answer = [_wrappedValues objectForKey:key];
    if( nil == answer ) {
        
        NSMutableArray* mutableArray = (NSMutableArray*)blob;
        answer = [[CAJsonArray alloc] initWithValue:mutableArray];
        [_wrappedValues setObject:answer forKey:key];
    }
    
    return answer;

}

-(CAJsonObject*)jsonObjectForKey:(NSString*)key {
    
    id blob = [self getBlob:key throwExceptionOnNil:true];
    
    if( ![blob isKindOfClass:[NSMutableDictionary class]] ) {

        NSString* technicalError = [NSString stringWithFormat:@"![blob isKindOfClass:[NSMutableDictionary class]]; NSStringFromClass([blob class]) = %@", NSStringFromClass([blob class])];
        
        BaseException *e = [[BaseException alloc] initWithOriginator:self line:__LINE__ faultMessage:technicalError];
        @throw e;

    }

    CAJsonObject* answer = [_wrappedValues objectForKey:key];
    if( nil == answer ) {
        
        NSMutableDictionary* mutableArray = (NSMutableDictionary*)blob;
        answer = [[CAJsonObject alloc] initWithValue:mutableArray];
        [_wrappedValues setObject:answer forKey:key];
    }
    
    return answer;
    
}

-(CAJsonObject*)jsonObjectForKey:(NSString*)key defaultValue:(CAJsonObject*)defaultValue {
    
    id blob = [self getBlob:key throwExceptionOnNil:false];
    
    if( nil == blob ) {
		return defaultValue;
	}
    
    if( ![blob isKindOfClass:[NSMutableDictionary class]] ) {
        
        NSString* technicalError = [NSString stringWithFormat:@"![blob isKindOfClass:[NSMutableDictionary class]]; NSStringFromClass([blob class]) = %@", NSStringFromClass([blob class])];
        
        BaseException *e = [[BaseException alloc] initWithOriginator:self line:__LINE__ faultMessage:technicalError];
        @throw e;
        
    }
    
    CAJsonObject* answer = [_wrappedValues objectForKey:key];
    if( nil == answer ) {
        
        NSMutableDictionary* mutableArray = (NSMutableDictionary*)blob;
        answer = [[CAJsonObject alloc] initWithValue:mutableArray];
        [_wrappedValues setObject:answer forKey:key];
    }
    
    return answer;

}

-(long)longForKey:(NSString*)key {
    
    id blob = [self getBlob:key throwExceptionOnNil:true];
    
    if( ![blob isKindOfClass:[NSNumber class]] ) { 
		
        NSString* technicalError = [NSString stringWithFormat:@"![blob isKindOfClass:[NSNumber class]]; NSStringFromClass([blob class]) = %@", NSStringFromClass([blob class])];
		BaseException *e = [[BaseException alloc] initWithOriginator:self line:__LINE__ faultMessage:technicalError];
		@throw e;
	}
	
	NSNumber* answer = (NSNumber*)blob;
	return [answer longValue];

}




-(long long)longLongForKey:(NSString*)key {
    
    id blob = [self getBlob:key throwExceptionOnNil:true];
    
    if( ![blob isKindOfClass:[NSNumber class]] ) {
		
        NSString* technicalError = [NSString stringWithFormat:@"![blob isKindOfClass:[NSNumber class]]; NSStringFromClass([blob class]) = %@", NSStringFromClass([blob class])];
		BaseException *e = [[BaseException alloc] initWithOriginator:self line:__LINE__ faultMessage:technicalError];
		@throw e;
	}
	
	NSNumber* answer = (NSNumber*)blob;
	return [answer longLongValue];
    
}


-(long long)longLongForKey:(NSString*)key defaultValue:(long long)defaultValue {
    
    id blob = [self getBlob:key throwExceptionOnNil:false];
    
    if( nil == blob ) {
		return defaultValue;
	}
    
    if( ![blob isKindOfClass:[NSNumber class]] ) {
		
        NSString* technicalError = [NSString stringWithFormat:@"![blob isKindOfClass:[NSNumber class]]; NSStringFromClass([blob class]) = %@", NSStringFromClass([blob class])];
		BaseException *e = [[BaseException alloc] initWithOriginator:self line:__LINE__ faultMessage:technicalError];
		@throw e;
	}
	
	NSNumber* answer = (NSNumber*)blob;
	return [answer longLongValue];

}




-(id)objectForKey:(NSString*)key {

    id answer = [self getBlob:key throwExceptionOnNil:true];

	return answer;
	
}

-(id)objectForKey:(NSString*)key defaultValue:(id)defaultValue{
    
    id answer = [self getBlob:key throwExceptionOnNil:false];
    
    if( nil == answer ) { 
        return defaultValue;
    }
    
	return answer;
	
}





-(NSString*)stringForKey:(NSString*)key defaultValue:(NSString*)defaultValue{
	
    id blob = [self getBlob:key throwExceptionOnNil:false];
	
	if( nil == blob ) {
		return defaultValue;
	}
	
	if( ![blob isKindOfClass:[NSString class]] ) { 
		
		BaseException *e = [[BaseException alloc] initWithOriginator:self line:__LINE__ faultMessage:@"![blob isKindOfClass:[NSString class]]"];
		@throw e;
	}
	
	NSString* answer = (NSString*)blob;
	return answer;
	
	
}


-(NSString*)stringForKey:(NSString*)key {
	
    id blob = [self getBlob:key throwExceptionOnNil:true];

	if( nil == blob ) {
		return nil;
	}

	if( ![blob isKindOfClass:[NSString class]] ) { 
		
		BaseException *e = [[BaseException alloc] initWithOriginator:self line:__LINE__ faultMessage:@"![blob isKindOfClass:[NSString class]]"];
		@throw e;
	}
	
	NSString* answer = (NSString*)blob;
	return answer;
	
}


-(NSUInteger)unsignedIntegerForKey:(NSString*)key {
    
    id blob = [self getBlob:key throwExceptionOnNil:true];
    
    if( ![blob isKindOfClass:[NSNumber class]] ) {
		
        NSString* technicalError = [NSString stringWithFormat:@"![blob isKindOfClass:[NSNumber class]]; NSStringFromClass([blob class]) = %@", NSStringFromClass([blob class])];
		BaseException *e = [[BaseException alloc] initWithOriginator:self line:__LINE__ faultMessage:technicalError];
		@throw e;
	}
	
	NSNumber* answer = (NSNumber*)blob;
	return [answer unsignedIntegerValue];

}





#pragma mark -
#pragma mark setters

-(void)setBool:(BOOL)value forKey:(NSString*)key {
    
    NSNumber* boolean = [NSNumber numberWithBool:value];
	
	[_values setObject:boolean forKey:key];
    
}



-(void)setDoubleForKey:(double)value forKey:(NSString*)key {
    
    NSNumber* number = [NSNumber numberWithDouble:value];
	
	[_values setObject:number forKey:key];
    
}


-(void)setInt:(int)value forKey:(NSString*)key {
	
	NSNumber* number = [NSNumber numberWithInt:value];
	
	[_values setObject:number forKey:key];
}


-(void)setInteger:(NSInteger)value forKey:(NSString*)key {
	
	NSNumber* number = [NSNumber numberWithInteger:value];
	
	[_values setObject:number forKey:key];
}

-(void)setLong:(long)value forKey:(NSString*)key {
    
    
    NSNumber* number = [NSNumber numberWithLong:value];
	
	[_values setObject:number forKey:key];
    
}


-(void)setLongLong:(long long)value forKey:(NSString*)key {
    
    
    NSNumber* number = [NSNumber numberWithLongLong:value];
	
	[_values setObject:number forKey:key];
    
    
    
}


-(void)setObject:(id)object forKey:(NSString*)key {
	
	if( nil == object ) {
        
		[_values setObject:_NULL_OBJECT forKey:key];
	} else {
        
        
        if( [object isKindOfClass:[CAJsonObject class]] ) {
            
            CAJsonObject* jsonObject = (CAJsonObject*)object;
            [_values setObject:[jsonObject values] forKey:key];
            [_wrappedValues setObject:jsonObject forKey:key];
        } else if( [object isKindOfClass:[CAJsonArray class]] ) {
            
            CAJsonArray* jsonArray = (CAJsonArray*)object;
            [_values setObject:[jsonArray values] forKey:key];
            [_wrappedValues setObject:jsonArray forKey:key];

        } else {
            
            [_values setObject:object forKey:key];
        }

        
	}
}


-(void)setUnsignedInteger:(NSUInteger)value forKey:(NSString*)key {
	
	NSNumber* number = [NSNumber numberWithUnsignedInteger:value];
	
	[_values setObject:number forKey:key];
}

-(void)setUnsignedLongLong:(unsigned long long)value forKey:(NSString*)key {
    
    NSNumber* number = [NSNumber numberWithUnsignedLongLong:value];
	
	[_values setObject:number forKey:key];
    
}

#pragma mark -


-(BOOL)hasOwnProperty:(NSString*)key {
    
	id blob = [_values objectForKey:key];
	if( nil == blob ) { 
		return FALSE;
	}
	return TRUE;    
}

-(BOOL)contains:(NSString*)key {
	
	id blob = [_values objectForKey:key];
	if( nil == blob ) { 
		return FALSE;
	}
	return TRUE;
	
}


#pragma mark -
#pragma mark Alphabetically sorted


// http://www.ecma-international.org/ecma-262/5.1/#sec-11.4.1
-(void)delete:(NSString*)key {
    
    [_values removeObjectForKey:key];
    
}

-(NSString*)toString {
	
    
    return [CAStringHelper getUtf8String:[self toData]];
	
}

-(NSData*)toData;
{
    
    
    NSJSONWritingOptions options = 0;
    NSError *error = nil;
    
    NSData* answer = [NSJSONSerialization dataWithJSONObject:[self values] options:options error:&error];
    if( nil != error ) {
        
        @throw exceptionWithMethodNameAndError(@"[NSJSONSerialization JSONObjectWithData:options:error:]", error);
    }
    
    return answer;
}



#pragma mark -
#pragma mark <NSFastEnumeration> implementation


- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id __unsafe_unretained [])buffer count:(NSUInteger)len {

    return [_values countByEnumeratingWithState:state objects:buffer count:len];
    
}





@end
