//
//  CABlockJob2.m
//  jsonbroker
//
//  Created by rlong on 5/03/2014.
//
//

#import "CABaseException.h"
#import "CABlockJob2.h"
#import "CALog.h"
#import "CAWorkManager.h"

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

@interface CABlockJob2 ()

// block
//CABlock _block;
@property (nonatomic, copy) CABlock2 block;
//@synthesize block = _block;

// blockDone
//CABlockDone _blockDone;
@property (nonatomic, copy) CABlockDone2 blockDone;
//@synthesize blockDone = _blockDone;

// blockFailed
//CABlockFailed _blockFailed;
@property (nonatomic, copy) CABlockFailed2 blockFailed;
//@synthesize blockFailed = _blockFailed;

// blockResponse
//id _blockResponse;
@property (nonatomic, retain) id blockResponse;
//@synthesize blockResponse = _blockResponse;



@end

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
#pragma mark -


@implementation CABlockJob2



#pragma mark -
#pragma mark <CAJob> implementation

-(void)execute {
    
    if( nil == _block ) {
        Log_warn(@"nil == _block");
        return;
    }
    
    CABaseException *exceptionCaught = nil;
    
    @try {
        id blockResponse = _block();
        [self setBlockResponse:blockResponse];
    }
    @catch (CABaseException *exception) {
        
        exceptionCaught = exception;
        
        if( nil != _blockFailed ) {
            
            // vvv http://stackoverflow.com/questions/7364169/how-to-dispatch-a-block-with-parameter-on-main-queue-or-thread
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                @try {
                    _blockFailed( exception );
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
                    _blockDone();
                }
                @catch (NSException *exception) {
                    Log_errorException( exception );
                }
            });
            // ^^^ http://stackoverflow.com/questions/7364169/how-to-dispatch-a-block-with-parameter-on-main-queue-or-thread
            
        }
    }

}



+(void)executeWithBlock:(CABlock2)block {
    
    CABlockJob2* job = [[CABlockJob2 alloc] initWithBlock:block];
    {
        
        [CAWorkManager enqueue:job];
        
    }
    
    
}

+(void)executeWithBlock:(CABlock2)block onBlockDone:(CABlockDone2)blockDone onBlockFailed:(CABlockFailed2) blockFailed {
    
    CABlockJob2* job = [[CABlockJob2 alloc] initWithBlock:(CABlock2)block onBlockDone:(CABlockDone2)blockDone onBlockFailed:(CABlockFailed2) blockFailed];
    {
        
        [CAWorkManager enqueue:job];
        
    }
    
    
}


#pragma mark -
#pragma mark instance lifecycle



-(id)initWithBlock:(CABlock2)block {
    
    CABlockJob2* answer = [super init];
    
    if( nil != answer ) {
        [answer setBlock:block];
        [answer setBlockDone:nil];
        [answer setBlockFailed:nil];
    }
    
    return answer;
    
}


-(id)initWithBlock:(CABlock2)block onBlockDone:(CABlockDone2)blockDone onBlockFailed:(CABlockFailed2)blockFailed {
    
    CABlockJob2* answer = [super init];
    
    if( nil != answer ) {
        [answer setBlock:block];
        [answer setBlockDone:blockDone];
        [answer setBlockFailed:blockFailed];
    }
    
    return answer;
    
}

-(void)dealloc {
	
    [self setBlock:nil];
	[self setBlockDone:nil];
	[self setBlockFailed:nil];
    [self setBlockResponse:nil];

	
}



#pragma mark -
#pragma mark fields


// block
//CABlock _block;
//@property (nonatomic, copy) CABlock block;
@synthesize block = _block;


// blockDone
//CABlockDone _blockDone;
//@property (nonatomic, copy) CABlockDone blockDone;
@synthesize blockDone = _blockDone;

// blockFailed
//CABlockFailed _blockFailed;
//@property (nonatomic, copy) CABlockFailed blockFailed;
@synthesize blockFailed = _blockFailed;

// blockResponse
//id _blockResponse;
//@property (nonatomic, retain) id blockResponse;
@synthesize blockResponse = _blockResponse;

@end
