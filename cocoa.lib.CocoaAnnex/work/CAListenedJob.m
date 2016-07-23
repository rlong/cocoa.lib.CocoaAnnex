//  Copyright (c) 2013 Richard Long & HexBeerium
//
//  Released under the MIT license ( http://opensource.org/licenses/MIT )
//

#import "CABaseException.h"

#import "CALog.h"
#import "CAListenedJob.h"
#import "CAMainThreadJob.h"
#import "CAMainThreadJobListener2.h"


////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

@interface CAListenedJob ()


// delegate
//id<Job> _delegate;
@property (nonatomic, retain) id<CAJob> delegate;
//@synthesize delegate = _delegate;

// listener
//id<JobListener> _listener;
@property (nonatomic, retain) id<CAJobListener> listener;
//@synthesize listener = _listener;

// exceptionCaughtDuringExecute
//CABaseException* _exceptionCaughtDuringExecute;
@property (nonatomic, retain) CABaseException* exceptionCaughtDuringExecute;
//@synthesize exceptionCaughtDuringExecute = _exceptionCaughtDuringExecute;


@end

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
#pragma mark -


@implementation CAListenedJob




-(void)callExecuteOnDelegate:(id)ignoredObject {
    
    @try {
        [_delegate execute];
    }
    @catch (CABaseException *exception) {
        
        [self setExceptionCaughtDuringExecute:exception];
    }
    
}

-(void)callJobCompletedOnListener:(id)ignoredObject {
    
    @try {
        
        if( [_listener conformsToProtocol:@protocol(CAMainThreadJobListener2)] ) {
            id<CAMainThreadJobListener2> mainThreadJobListener = (id<CAMainThreadJobListener2>)_listener;
            if( [mainThreadJobListener jobListenerIsRunning]) {
                [mainThreadJobListener jobCompleted:_delegate ];
            }
        } else {
            [_listener jobCompleted:_delegate];
        }

    }
    @catch (NSException *exception) {
        Log_errorException(exception);
    }
    
}

-(void)callJobFailedOnListener:(id)ignoredObject {
    
    @try {
        
        if( [_listener conformsToProtocol:@protocol(CAMainThreadJobListener2)] ) {
            id<CAMainThreadJobListener2> mainThreadJobListener = (id<CAMainThreadJobListener2>)_listener;
            if( [mainThreadJobListener jobListenerIsRunning]) {
                [mainThreadJobListener jobFailed:_delegate withException:_exceptionCaughtDuringExecute];
            } else {
                Log_warnException(_exceptionCaughtDuringExecute);
            }
        } else {
            [_listener jobFailed:_delegate withException:_exceptionCaughtDuringExecute];
        }
        
    }
    @catch (NSException *exception) {
        Log_errorException(exception);
    }
    
}


-(void)executeAllInMainThread:(id)ignoredObject {
    
    Log_enteredMethod();
    
    [self callExecuteOnDelegate:nil];
    
    //  make the callback to the listener
    if( nil == _exceptionCaughtDuringExecute ) {
        
        [self callJobCompletedOnListener:nil];
        
    } else {
        
        [self callJobFailedOnListener:nil];
        
    }
}




-(void)execute {
    
    // execute job and callback to listener in the main thread ?
    if( [_delegate conformsToProtocol:@protocol(CAMainThreadJob)] && [_listener conformsToProtocol:@protocol(CAMainThreadJobListener2)] ) {

        [self performSelectorOnMainThread:@selector(executeAllInMainThread:) withObject:nil waitUntilDone:NO];
        return;
    }

    // execute
    {
        if( [_delegate conformsToProtocol:@protocol(CAMainThreadJob)] ) {
            
            [self performSelectorOnMainThread:@selector(callExecuteOnDelegate:) withObject:nil waitUntilDone:YES];
            
        } else {
            
            [self callExecuteOnDelegate:nil];
        }
        
    }
    
    // callback
    {
        if( [_listener conformsToProtocol:@protocol(CAMainThreadJobListener2)] ) {
            
            if( nil == _exceptionCaughtDuringExecute ) {
                
                [self performSelectorOnMainThread:@selector(callJobCompletedOnListener:) withObject:nil waitUntilDone:YES];
                
            } else {

                [self performSelectorOnMainThread:@selector(callJobFailedOnListener:) withObject:nil waitUntilDone:YES];

            }
        
        } else {
            
            if( nil == _exceptionCaughtDuringExecute ) {
                
                [self callJobCompletedOnListener:nil];
                
            } else {
                
                [self callJobFailedOnListener:nil];
                
            }
            
        }
        
    }
    
}

#pragma mark -
#pragma mark instance lifecycle


-(id)initWithDelegate:(id<CAJob>)delegate listener:(id<CAJobListener>)listener {
    
    CAListenedJob* answer = [super init];
    if( nil != answer ) {
        [answer setDelegate:delegate];
        [answer setListener:listener];
    }
    return answer;
    
}

-(void)dealloc {
	
    [self setDelegate:nil];
	[self setListener:nil];
	[self setExceptionCaughtDuringExecute:nil];

	
}



#pragma mark -
#pragma mark fields



// delegate
//id<Job> _delegate;
//@property (nonatomic, retain) id<Job> delegate;
@synthesize delegate = _delegate;

// listener
//id<JobListener> _listener;
//@property (nonatomic, retain) id<JobListener> listener;
@synthesize listener = _listener;

// exceptionCaughtDuringExecute
//CABaseException* _exceptionCaughtDuringExecute;
//@property (nonatomic, retain) CABaseException* exceptionCaughtDuringExecute;
@synthesize exceptionCaughtDuringExecute = _exceptionCaughtDuringExecute;


@end
