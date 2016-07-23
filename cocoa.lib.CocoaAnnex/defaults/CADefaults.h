// Copyright (c) 2013 Richard Long & HexBeerium
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//


#import <Foundation/Foundation.h>


@class CAJsonObject;


/* simply uses environment variables */
@interface CADefaults : NSObject {
    
    
    // environment
    CAJsonObject* _environment;
    //@property (nonatomic, retain) JBJsonObject* environment;
    //@synthesize environment = _environment;

    
    
}


-(bool)boolWithName:(NSString*)name defaultValue:(bool)defaultValue;



-(int)intWithName:(NSString*)name defaultValue:(int)defaultValue;

-(CAJsonObject*)jsonObjectWithName:(NSString*)name defaultValue:(CAJsonObject*)defaultValue;

+(CADefaults*)getDefaultsForScope:(NSString*)scope;


#pragma mark -
#pragma mark instance lifecycle

-(id)initWithEnvironment:(CAJsonObject*) environment;
//-(id)initWithScope:(NSString*)scope;

@end
