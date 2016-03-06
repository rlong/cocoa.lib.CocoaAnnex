// Copyright (c) 2013 Richard Long & HexBeerium
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//


#import "CAJsonHandler.h"
#import "CAJsonObject.h"


@interface CAJsonObjectHandler : CAJsonHandler {

}


+(CAJsonObjectHandler*)getInstance;


-(CAJsonObject*)readJSONObject:(CAJsonInput*)reader;

@end
