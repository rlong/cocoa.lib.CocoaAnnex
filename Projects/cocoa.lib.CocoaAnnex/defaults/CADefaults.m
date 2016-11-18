// Copyright (c) 2013 Richard Long & HexBeerium
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//


#import "CALog.h"
#import "CADefaults.h"
#import "CAJsonObject.h"
#import "CAJsonObjectHelper.h"



////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

@interface CADefaults ()

// environment
//CAJsonObject* _environment;
@property (nonatomic, retain) CAJsonObject* environment;
//@synthesize environment = _environment;

@end

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
#pragma mark -


@implementation CADefaults






-(bool)boolWithName:(NSString*)name defaultValue:(bool)defaultValue {

    return [_environment boolForKey:name defaultValue:defaultValue];
    
}

-(int)intWithName:(NSString*)name defaultValue:(int)defaultValue {

    
    return [_environment intForKey:name defaultValue:defaultValue];
    
}

-(CAJsonObject*)jsonObjectWithName:(NSString*)name defaultValue:(CAJsonObject*)defaultValue {
    
    return [_environment jsonObjectForKey:name defaultValue:defaultValue];

}




+(CADefaults*)getDefaultsForScope:(NSString*)scope {
    
    // environment ...
    {
        
        // vvv http://stackoverflow.com/questions/2821043/allowed-characters-in-linux-environment-variable-names
        
        NSString* environmentName = [scope stringByReplacingOccurrencesOfString:@"." withString:@"_"];
        Log_debugString( environmentName );
        
        // ^^^ http://stackoverflow.com/questions/2821043/allowed-characters-in-linux-environment-variable-names
        
        NSString* environmentValue = [[[NSProcessInfo processInfo] environment] objectForKey:environmentName];
        
        if( nil != environmentValue ) {
            Log_debugString( environmentValue );
            CAJsonObject* environment = [CAJsonObjectHelper buildFromString:environmentValue];
            CADefaults* answer = [[CADefaults alloc] initWithEnvironment:environment];
            return answer;
            
        }
    }
    
    
    // appplication plist ...
    {
        NSBundle* mainBundle = [NSBundle mainBundle];
        NSString* bundleValue = [mainBundle objectForInfoDictionaryKey:scope];
        
        if( nil != bundleValue ) {
            Log_debugString( bundleValue );
            CAJsonObject* environment = [CAJsonObjectHelper buildFromString:bundleValue];
            CADefaults* answer = [[CADefaults alloc] initWithEnvironment:environment];
            return answer;
            
        }
    }
    
    // empty ...
    
    
    CAJsonObject* environment = [[CAJsonObject alloc] init];
    
    CADefaults* answer = [[CADefaults alloc] initWithEnvironment:environment];
    
    return answer;
    
}


#pragma mark -
#pragma mark instance lifecycle


-(id)initWithEnvironment:(CAJsonObject*) environment {
    
    CADefaults* answer  = [super init];
    
    if( nil != answer ) {
        
        [answer setEnvironment:environment];

    }
    
    return answer;
    
}

-(id)initWithScope:(NSString*)scope {
    
    CADefaults* answer  = [super init];
    
    if( nil != answer ) {
        
        // vvv http://stackoverflow.com/questions/2821043/allowed-characters-in-linux-environment-variable-names
        
        scope = [scope stringByReplacingOccurrencesOfString:@"." withString:@"_"];
        Log_debugString( scope );
        
        // ^^^ http://stackoverflow.com/questions/2821043/allowed-characters-in-linux-environment-variable-names
        
        NSString* environmentVariable = [[[NSProcessInfo processInfo] environment] objectForKey:scope];
        Log_debugString( environmentVariable );
        
        if( nil == environmentVariable ) {
            answer->_environment = [[CAJsonObject alloc] init];
        } else {

            CAJsonObject* environment = [CAJsonObjectHelper buildFromString:environmentVariable];
            [answer setEnvironment:environment];
        }
        
    }
    
    return answer;
    
}

-(void)dealloc {
	
	[self setEnvironment:nil];
	
	
}

#pragma mark -
#pragma mark fields

// environment
//CAJsonObject* _environment;
//@property (nonatomic, retain) CAJsonObject* environment;
@synthesize environment = _environment;


@end
