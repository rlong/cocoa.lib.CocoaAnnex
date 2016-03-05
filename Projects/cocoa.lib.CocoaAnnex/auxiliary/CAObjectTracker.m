// Copyright (c) 2013 Richard Long & HexBeerium
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//

#import "CALog.h"
#import "CAObjectReference.h"
#import "CAObjectTracker.h"

@implementation CAObjectTracker

static NSMutableDictionary* _objects;

+(void)initialize {
	_objects = [[NSMutableDictionary alloc] init];
}


+(NSString*)keyForObject:(id)object {
	
	NSString* className = NSStringFromClass([object class]);
	NSString* answer = [NSString stringWithFormat:@"%@.%p", className, object];
	return answer;
	
}

+(void)allocated:(id)object {
	
#ifdef DEBUG
    
    
    
    
    @synchronized(_objects) {

        NSString* key = [self keyForObject:object];

        if( nil != [_objects objectForKey:key] ) {
            
            Log_warnFormat( @"nil != [_objects objectForKey:key]; key = '%@'", key );
            
            
        } else {
            
            CAObjectReference* reference = [[CAObjectReference alloc] initWithObject:object];
            {
                [_objects setObject:reference forKey:key];
            }
        }
    }
	
	
#endif
	
}

+(void)deallocated:(id)object {
	
#ifdef DEBUG
    

    @synchronized(_objects) {
        
        NSString* key = [self keyForObject:object];

        if( nil == [_objects objectForKey:key] ) {
            Log_warnFormat( @"nil == [_objects objectForKey:key]; key = '%@'", key );
            
        } else {
            [_objects removeObjectForKey:key];
        }
    }
    
#endif

}

+(void)reportForCaller:(const char*)caller {
	
    
    
#ifdef DEBUG

    
#if __has_feature(objc_arc)
    Log_info(@"__has_feature(objc_arc)");
#endif

    
#if ! __has_feature(objc_arc)
    Log_info(@"! __has_feature(objc_arc)");
#endif

    
    @synchronized(_objects) {
        
        Log_debugUtf8String( caller );
        
        
        NSArray* allKeys = [_objects allKeys];
        Log_debugInt( [allKeys count]);
        Log_debug( @"{" );
        for( NSString* key in allKeys ) {
            
//            CAObjectReference* reference = [_objects objectForKey:key];
            
            printf("key = %s", [key UTF8String] );
            
            
        }
        Log_debug( @"}" );
        
    }
    

#endif

}



@end
