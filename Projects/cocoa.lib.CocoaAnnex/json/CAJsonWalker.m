// Copyright (c) 2013 Richard Long & HexBeerium
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//



#import "CAJsonWalker.h"

@implementation CAJsonWalker


static NSObject* _NULL_OBJECT = nil;



+(void)initialize {
	
    _NULL_OBJECT = [NSNull null];
    
}



-(void)walkJsonArray:(CAJsonArray*)jsonArray visitor:(id<CAJsonDocumentHandler>)visitor {
    
    
    
    for( NSUInteger index = 0, count = [jsonArray count]; index < count; index++ ) {
        
        if( !_continue ) {
            return;
        }

        NSObject* value = [jsonArray objectAtIndex:index defaultValue:nil];

        if( nil == value ) {
            [visitor onNullWithIndex:index];
            continue;
        }
        
        
        if( [value isKindOfClass:[NSNumber class]] ) {
            
            NSNumber* number = (NSNumber*)value;
            
            const char* objCType = [number objCType];
            
            /// vvv http://stackoverflow.com/questions/2518761/get-type-of-nsnumber
            
            if (strcmp(objCType, @encode(BOOL)) == 0) {
                
                /// ^^^ http://stackoverflow.com/questions/2518761/get-type-of-nsnumber
                [visitor onBooleanWithIndex:index value:[number boolValue]];
                continue;
                
            }
            
            [visitor onNumberWithIndex:index value:number];
            continue;
        }
        
        if( [value isKindOfClass:[NSString class]] ) {
            
            [visitor onStringWithIndex:index value:(NSString*)value];
            continue;
        }
        
        if( [value isKindOfClass:[CAJsonObject class]] ) {
            [visitor onObjectStartWithIndex:index];
            [self walkJsonObject:(CAJsonObject*)value visitor:visitor];
            [visitor onObjectEndWithIndex:index];
            continue;
        }
        
        if( [value isKindOfClass:[CAJsonArray class]] ) {
            [visitor onArrayStartWithIndex:index];
            [self walkJsonArray:(CAJsonArray*)value visitor:visitor];
            [visitor onArrayEndWithIndex:index];
            continue;
        }
    }
    
    
}


-(void)walkJsonObject:(CAJsonObject*)jsonObject visitor:(id<CAJsonDocumentHandler>)visitor {
    
    
    NSArray* allKeys = [jsonObject allKeys];
	
	for( NSUInteger i = 0, count = [allKeys count]; i < count; i++ ) {
        
        
        if( !_continue ) {
            return;
        }
        
		NSString* key = [allKeys objectAtIndex:i];
        
        NSObject* value = [jsonObject objectForKey:key defaultValue:nil];
        
        if( nil == value || _NULL_OBJECT == value ) {
            [visitor onNullWithKey:key];
            continue;
        }
        
        if( [value isKindOfClass:[NSNumber class]] ) {
            
            NSNumber* number = (NSNumber*)value;
            
            const char* objCType = [number objCType];
            
            /// vvv http://stackoverflow.com/questions/2518761/get-type-of-nsnumber
            
            if (strcmp(objCType, @encode(BOOL)) == 0) {
                
                /// ^^^ http://stackoverflow.com/questions/2518761/get-type-of-nsnumber
                
                [visitor onBooleanWithKey:key value:[number boolValue]];
                continue;
                
            }
            
            [visitor onNumberWithKey:key value:number];
            continue;
        }
        
        if( [value isKindOfClass:[NSString class]] ) {
            
            [visitor onStringWithKey:key value:(NSString*)value];
            continue;
        }
        
        if( [value isKindOfClass:[CAJsonObject class]] ) {
            [visitor onObjectStartWithKey:key];
            [self walkJsonObject:(CAJsonObject*)value visitor:visitor];
            [visitor onObjectEndWithKey:key];
            continue;
        }
        
        if( [value isKindOfClass:[CAJsonArray class]] ) {
            [visitor onArrayStartWithKey:key];
            [self walkJsonArray:(CAJsonArray*)value visitor:visitor];
            [visitor onArrayEndWithKey:key];
            continue;
        }
        
        
        
    }
    

}


-(void)stop {
    _continue = false;
}



-(void)walkJsonArrayDocument:(CAJsonArray*)jsonArray visitor:(id<CAJsonDocumentHandler>)visitor {
    
    _continue = true;
    [visitor onArrayDocumentStart];
    
    [self walkJsonArray:jsonArray visitor:visitor];
    
    [visitor onArrayDocumentEnd];
    
    
}


-(void)walkJsonObjectDocument:(CAJsonObject*)jsonObject visitor:(id<CAJsonDocumentHandler>)visitor {

    _continue = true;

    [visitor onObjectDocumentStart];
    
    [self walkJsonObject:jsonObject visitor:visitor];
    
    [visitor onObjectDocumentEnd];
    
    
}

+(void)walkJsonArrayDocument:(CAJsonArray*)jsonArray visitor:(id<CAJsonDocumentHandler>)visitor {
    
    CAJsonWalker* walker = [[CAJsonWalker alloc] init];

    @try {
        [walker walkJsonArrayDocument:jsonArray visitor:visitor];
    }
    @finally {
    }

    
}




+(void)walkJsonObjectDocument:(CAJsonObject*)jsonObject visitor:(id<CAJsonDocumentHandler>)visitor {
    
    CAJsonWalker* walker = [[CAJsonWalker alloc] init];

    @try {
        [walker walkJsonObjectDocument:jsonObject visitor:visitor];
    }
    @finally {
    }
    
    
    
}


#pragma mark -
#pragma mark instance lifecycle

-(id)init {
    
    CAJsonWalker* answer = [super init];
    if( nil != answer ) {

        answer->_continue = true;
        
    }
    
    return answer;
}

@end
