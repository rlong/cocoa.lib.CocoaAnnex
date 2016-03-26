//  Copyright (c) 2013 Richard Long & HexBeerium
//
//  Released under the MIT license ( http://opensource.org/licenses/MIT )
//

#import "CAWorkQueue.h"

#import "CALog.h"


#define NO_MESSAGES_PENDING 1
#define MESSAGES_PENDING 2


////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

@interface CAWorkQueue () 


//NSConditionLock* _inqueueLock;
@property (nonatomic, retain) NSConditionLock* inqueueLock;
//@synthesize inqueueLock = _inqueueLock;

//NSMutableArray* _inqueue;
@property (nonatomic, retain) NSMutableArray* inqueue;
//@synthesize inqueue = _inqueue;

@end 

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

@implementation CAWorkQueue


-(uint32_t)count {
    
    return (uint32_t)[_inqueue count];
}

-(void)enqueue:(id<CAJob>)request {
	
	[_inqueueLock lock];
	
	[_inqueue addObject:request];
	
	[_inqueueLock unlockWithCondition:MESSAGES_PENDING];
}

-(id<CAJob>)dequeue {
    
    
	[_inqueueLock lockWhenCondition:MESSAGES_PENDING];
	
	id<CAJob> answer = [_inqueue objectAtIndex:0];
	
	[_inqueue removeObjectAtIndex:0];
	
	if( 0 == [_inqueue count] ) { 
		
		[_inqueueLock unlockWithCondition:NO_MESSAGES_PENDING];
		
	} else {
		[_inqueueLock unlockWithCondition:MESSAGES_PENDING];
		
	}
	
	return answer;
}


#pragma mark instance lifecycle


-(id)init {
	CAWorkQueue* answer = [super init];
	
	
	answer->_inqueueLock = [[NSConditionLock alloc] initWithCondition:NO_MESSAGES_PENDING]; 
	answer->_inqueue = [[NSMutableArray alloc] init];
	
	return answer;
}

-(void)dealloc {
	
	
	[self setInqueueLock:nil];
	[self setInqueue:nil];
	
}

#pragma mark fields

//NSConditionLock* _inqueueLock;
//@property (nonatomic, retain) NSConditionLock* inqueueLock;
@synthesize inqueueLock = _inqueueLock;

//NSMutableArray* _inqueue;
//@property (nonatomic, retain) NSMutableArray* inqueue;
@synthesize inqueue = _inqueue;


@end
