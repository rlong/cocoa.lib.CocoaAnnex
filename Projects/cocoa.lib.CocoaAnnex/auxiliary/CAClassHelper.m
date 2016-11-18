// Copyright (c) 2013 Richard Long & HexBeerium
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//




#import "CAClassHelper.h"


@implementation CAClassHelper {

}


+(NSString*)getClassName:(id)object {
    if( nil == object ) { 
        return @"NULL";
    }
    
    return NSStringFromClass( [object class] );
}


@end
