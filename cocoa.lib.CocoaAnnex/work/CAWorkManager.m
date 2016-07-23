//  Copyright (c) 2013 Richard Long & HexBeerium
//
//  Released under the MIT license ( http://opensource.org/licenses/MIT )
//


#import "CAJob.h"
#import "CAJobListener.h"
#import "CAListenedJob.h"
#import "CALog.h"
#import "CAWorkManager.h"
#import "CAWorker.h"
#import "CAWorkQueue.h"


#define NUM_WORKERS 5


@implementation CAWorkManager

static CAWorkQueue* _workQueue = nil;
static NSMutableArray* _workers = nil;


+(void)initialize {
	
	_workQueue = [[CAWorkQueue alloc] init];
    
	
}


+(void)start {
	
	Log_enteredMethod();
    
    if( nil != _workers ) {
        Log_warn( @"nil != _workers" );
        return;
    }
    
    _workers = [[NSMutableArray alloc] init];
    
	for( int i = 0; i < NUM_WORKERS; i++ ) {
		NSString* name = [NSString stringWithFormat:@"Worker.%d",i+1];
        
        CAWorker* worker = [[CAWorker alloc] initWithName:name workQueue:_workQueue];
        [worker start];
        [_workers addObject:worker];
	}
	
}

+(void)enqueue:(id<CAJob>)request {
	
    if( nil == _workers ) {
        Log_warn( @"nil == _workers" );
    }
    
    
	[_workQueue enqueue:request];
    
}

+(void)enqueue:(id<CAJob>)request listener:(id<CAJobListener>)listener {

    if( nil == _workers ) {
        Log_warn( @"nil == _workers" );
    }

    CAListenedJob* wrapper  = [[CAListenedJob alloc] initWithDelegate:request listener:listener];
    {
        [_workQueue enqueue:wrapper];
    }
    
}


@end

