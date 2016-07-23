//  Copyright (c) 2013 Richard Long & HexBeerium
//
//  Released under the MIT license ( http://opensource.org/licenses/MIT )
//


#import "CABaseException.h"
#import "CABlockJob.h"
#import "CALog.h"
#import "CAWorkManager.h"

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

@interface CABlockJob ()

// context
//id _context;
@property (nonatomic, retain) id context;
//@synthesize context = _context;

// block
//CABlock _block;
@property (nonatomic, copy) CABlock block;
//@synthesize block = _block;

// blockResponse
//id _blockResponse;
@property (nonatomic, retain) id blockResponse;
//@synthesize blockResponse = _blockResponse;

// blockDone
//CABlockDone _blockDone;
@property (nonatomic, copy) CABlockDone blockDone;
//@synthesize blockDone = _blockDone;

// blockFailed
//CABlockFailed _blockFailed;
@property (nonatomic, copy) CABlockFailed blockFailed;
//@synthesize blockFailed = _blockFailed;



@end

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
#pragma mark -


@implementation CABlockJob


#pragma mark -
#pragma mark <CAJob> implementation

-(void)execute {
    
    if( nil == _block ) {
        Log_warn(@"nil == _block");
        return;
    }
    
    
    CABaseException *exceptionCaught = nil;
    
    @try {
        
        id blockResponse = _block(_context);
        [self setBlockResponse:blockResponse];
    }
    @catch (CABaseException *exception) {
        
        exceptionCaught = exception;
        
        if( nil != _blockFailed ) {
            
            // vvv http://stackoverflow.com/questions/7364169/how-to-dispatch-a-block-with-parameter-on-main-queue-or-thread
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                @try {
                    _blockFailed( _context, exception );
                }
                @catch (NSException *exception) {
                    Log_errorException( exception );
                }
                
            });
            
            // ^^^ http://stackoverflow.com/questions/7364169/how-to-dispatch-a-block-with-parameter-on-main-queue-or-thread
            
        } else {
            Log_errorException( exception );
        }
        
        // we are not 'done' so we return ...
        return;
        
    }
    
    if( nil == exceptionCaught ) { // if we completed the call to '_asyncAdaptee' successfully ...
        if( nil != _blockDone ) {
            
            // vvv http://stackoverflow.com/questions/7364169/how-to-dispatch-a-block-with-parameter-on-main-queue-or-thread
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                @try {
                    _blockDone( _context, _blockResponse );
                }
                @catch (NSException *exception) {
                    Log_errorException( exception );
                }
            });
            // ^^^ http://stackoverflow.com/questions/7364169/how-to-dispatch-a-block-with-parameter-on-main-queue-or-thread
            
        }
    }

}



+(void)executeWithContext:(id)context block:(CABlock)block {
    
    CABlockJob* job = [[CABlockJob alloc] initWithContext:context block:block];
    {
        
        [CAWorkManager enqueue:job];
        
    }


}

+(void)executeWithContext:(id)context block:(CABlock)block onBlockDone:(CABlockDone)blockDone onBlockFailed:(CABlockFailed) blockFailed {

    CABlockJob* job = [[CABlockJob alloc] initWithContext:context block:(CABlock)block onBlockDone:(CABlockDone)blockDone onBlockFailed:(CABlockFailed) blockFailed];
    {
        
        [CAWorkManager enqueue:job];
        
    }
    

}

#pragma mark -
#pragma mark instance lifecycle

-(id)initWithContext:(id)context block:(CABlock)block {
    
    CABlockJob* answer = [super init];
    
    if( nil != answer ) {
        [answer setContext:context];
        [answer setBlock:block];
        [answer setBlockDone:nil];
        [answer setBlockFailed:nil];
    }
    
    return answer;
    
}

-(id)initWithContext:(id)context block:(CABlock)block onBlockDone:(CABlockDone)blockDone onBlockFailed:(CABlockFailed) blockFailed {
    
    CABlockJob* answer = [super init];
    
    if( nil != answer ) {
        [answer setContext:context];
        [answer setBlock:block];
        [answer setBlockDone:blockDone];
        [answer setBlockFailed:blockFailed];
    }
    
    return answer;
    
}

-(void)dealloc {
	
	[self setContext:nil];
    [self setBlock:nil];
	[self setBlockResponse:nil];
	[self setBlockDone:nil];
	[self setBlockFailed:nil];

	
}



#pragma mark -
#pragma mark fields

// context
//id _context;
//@property (nonatomic, retain) id context;
@synthesize context = _context;


// block
//CABlock _block;
//@property (nonatomic, copy) CABlock block;
@synthesize block = _block;


// blockResponse
//id _blockResponse;
//@property (nonatomic, retain) id blockResponse;
@synthesize blockResponse = _blockResponse;

// blockDone
//CABlockDone _blockDone;
//@property (nonatomic, copy) CABlockDone blockDone;
@synthesize blockDone = _blockDone;

// blockFailed
//CABlockFailed _blockFailed;
//@property (nonatomic, copy) CABlockFailed blockFailed;
@synthesize blockFailed = _blockFailed;


@end
