// Copyright (c) 2013 Richard Long & HexBeerium
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//



#import "CABaseException.h"
#import "CAJsonArray.h"
#import "CAJsonObject.h"
#import "CAJsonObjectHandler.h"
#import "CAJsonDataInput.h"
#import "CAJsonStringOutput.h"
#import "CAStringHelper.h"

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

@interface CAJsonObject () 

//NSMutableDictionary* _values;
@property (nonatomic, retain) NSMutableDictionary* values;
//@synthesize values = _values;

@end 

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
#pragma mark -


@implementation CAJsonObject


static NSObject* _NULL_OBJECT = nil;



+(void)initialize {
	
    _NULL_OBJECT = [NSNull null];

}


+(CAJsonObject*)buildWithData:(NSData*)data {
	
	CAJsonObject* answer = nil;
    
	CAJsonDataInput* reader = [[CAJsonDataInput alloc] initWithData:data];
	{
		[reader scanToNextToken];
		
		answer = [[CAJsonObjectHandler getInstance] readJSONObject:reader];
		
		
	}
	
	return answer;
	
}


+(CAJsonObject*)buildWithString:(NSString*)jsonString {
    
    NSData* data = [CAStringHelper toUtf8Data:jsonString];
    return [self buildWithData:data];
	
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

	
	if( ![blob isKindOfClass:[CAJsonArray class]] ) { 
		
        NSString* technicalError = [NSString stringWithFormat:@"![blob isKindOfClass:[JSONArray class]]; NSStringFromClass([blob class]) = %@", NSStringFromClass([blob class])];

		BaseException *e = [[BaseException alloc] initWithOriginator:self line:__LINE__ faultMessage:technicalError];
		@throw e;
	}
	
	CAJsonArray* answer = (CAJsonArray*)blob;
	return answer;
	
}


-(CAJsonArray*)jsonArrayForKey:(NSString*)key defaultValue:(CAJsonArray*)defaultValue {

    id blob = [self getBlob:key throwExceptionOnNil:false];
    
    if( nil == blob ) { 
        return defaultValue;
    }
    
	if( ![blob isKindOfClass:[CAJsonArray class]] ) { 
    
        return defaultValue;
    }
    
	CAJsonArray* answer = (CAJsonArray*)blob;
	return answer;
    

}

-(CAJsonObject*)jsonObjectForKey:(NSString*)key {
    
    id blob = [self getBlob:key throwExceptionOnNil:true];
    
	if( ![blob isKindOfClass:[CAJsonObject class]] ) { 

        NSString* technicalError = [NSString stringWithFormat:@"![blob isKindOfClass:[JSONObject class]]; NSStringFromClass([blob class]) = %@", NSStringFromClass([blob class])];

		BaseException *e = [[BaseException alloc] initWithOriginator:self line:__LINE__ faultMessage:technicalError];
		@throw e;
	}
	
	CAJsonObject* answer = (CAJsonObject*)blob;
	return answer;
    
}

-(CAJsonObject*)jsonObjectForKey:(NSString*)key defaultValue:(CAJsonObject*)defaultValue {
    
    id blob = [self getBlob:key throwExceptionOnNil:false];
    
    if( nil == blob ) {
		return defaultValue;
	}
    
	if( ![blob isKindOfClass:[CAJsonObject class]] ) { 
        
        NSString* technicalError = [NSString stringWithFormat:@"![blob isKindOfClass:[JSONObject class]]; NSStringFromClass([blob class]) = %@", NSStringFromClass([blob class])];
        
		BaseException *e = [[BaseException alloc] initWithOriginator:self line:__LINE__ faultMessage:technicalError];
		@throw e;
	}
	
	CAJsonObject* answer = (CAJsonObject*)blob;
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
		[_values setObject:object forKey:key];
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
	
	NSString* answer = nil;
	
	
	//JSONWriter writer = new JSONWriter();
	CAJsonStringOutput* writer = [[CAJsonStringOutput alloc] init];
	{
		//_jsonObjectHandler.writeValue( this, jsonWriter);
		[[CAJsonObjectHandler getInstance] writeValue:self writer:writer];
		
		//return jsonWriter.toString();
		answer = [writer toString];
        
	}
	
	return answer;
	
}

#pragma mark -
#pragma mark <NSFastEnumeration> implementation


- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id __unsafe_unretained [])buffer count:(NSUInteger)len {

    return [_values countByEnumeratingWithState:state objects:buffer count:len];
    
}


#pragma mark -
#pragma mark instance lifecycle



-(id)init {
	
	CAJsonObject* answer = [super init];
	
	
	answer->_values = [[NSMutableDictionary alloc] init];
	
	return answer;
}

-(id)initWithCapacity:(int)numItems {
	
	CAJsonObject* answer = [super init];
	
	
	answer->_values = [[NSMutableDictionary alloc] initWithCapacity:numItems];
	
	return answer;
	
}

-(void)dealloc {
	
	
	[self setValues:nil];
    
}


//NSMutableDictionary* _values;
//@property (nonatomic, retain) NSMutableDictionary* values;
@synthesize values = _values;


@end
