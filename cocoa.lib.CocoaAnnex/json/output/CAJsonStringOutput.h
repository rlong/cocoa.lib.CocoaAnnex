// Copyright (c) 2013 Richard Long & HexBeerium
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//


#import "CAJsonOutput.h"

@interface CAJsonStringOutput : NSObject <CAJsonOutput>{
	

	NSMutableString* _stringBuffer;
	//@property (nonatomic, retain) NSMutableString* stringBuffer;
	//@synthesize stringBuffer = _stringBuffer;
	
}


-(void)reset;
-(void)appendChar:(unichar)c;
-(void)appendString:(NSString*)string;
-(NSString*)toString;
	

@end
