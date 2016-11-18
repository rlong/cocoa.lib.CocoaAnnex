// Copyright (c) 2013 Richard Long & HexBeerium
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//


#import "CAJsonArray.h"
#import "CAJsonHandler.h"
#import "CAJsonDataInput.h"

@interface CAJsonArrayHandler : CAJsonHandler {

}


+(CAJsonArrayHandler*)getInstance;


-(CAJsonArray*)readJSONArray:(CAJsonDataInput*)reader;


@end
