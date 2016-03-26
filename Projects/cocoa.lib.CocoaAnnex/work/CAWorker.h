//  Copyright (c) 2013 Richard Long & HexBeerium
//
//  Released under the MIT license ( http://opensource.org/licenses/MIT )
//

#import "CAWorkQueue.h"

@interface CAWorker : NSObject {
    
    NSString* _name;
	//@property (nonatomic, retain) NSString* name;
	//@synthesize name = _name;
	
	CAWorkQueue* _workQueue;
	//@property (nonatomic, retain) WorkQueue* workQueue;
	//@synthesize workQueue = _workQueue;

}


-(void)start;

#pragma mark instance lifecycle

-(id)initWithName:(NSString*)name workQueue:(CAWorkQueue*)queue;

@end
