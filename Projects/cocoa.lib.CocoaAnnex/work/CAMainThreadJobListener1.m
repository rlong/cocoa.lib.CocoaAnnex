//  Copyright (c) 2013 Richard Long & HexBeerium
//
//  Released under the MIT license ( http://opensource.org/licenses/MIT )
//

#import "CABaseException.h"
#import "CAMainThreadJobListener1.h"

#import "CALog.h"

@implementation CAMainThreadJobListener1


-(void)enable {
    _enabled = true;
}

-(void)disable {
    _enabled = false;
}

-(bool)isEnabled {
    return _enabled;
}

-(void)mainThreadJobCompleted:(id<CAJob>)job {

    if( !_enabled) {
        return;
    }

    if( nil != _delegate )  {
        
        [_delegate jobCompleted:job];
        
    }
}


-(void)jobCompleted:(id<CAJob>)job {

    if( !_enabled) {
        return;
    }

    if( nil != _delegate )  {
        
        [self performSelectorOnMainThread:@selector(mainThreadJobCompleted:) withObject:job waitUntilDone:NO];        

    }
    
    return;

}


-(void)mainThreadJobFailed:(NSArray*)params {
    
    Log_enteredMethod();

    if( !_enabled) {
        return;
    }

    if( nil != _delegate )  {

        id<CAJob> job = [params objectAtIndex:0];
        CABaseException* exception = [params objectAtIndex:1];

        [_delegate jobFailed:job withException:exception];
    }
}

-(void)jobFailed:(id<CAJob>)job withException:(BaseException*)exception {

    Log_enteredMethod();
    
    if( !_enabled) {
        return;
    }

    if( nil != _delegate )  {
        
        NSArray* params = [NSArray arrayWithObjects:job, exception, nil];
        [self performSelectorOnMainThread:@selector(mainThreadJobFailed:) withObject:params waitUntilDone:NO];
    
    }
    return;
}


#pragma mark instance lifecycle

-(id)initWithDelegate:(id<CAJobListener>)delegate {
    
    CAMainThreadJobListener1* answer = [super init];
    
    if( nil != answer ) {
        
        [answer setDelegate:delegate];
        answer->_enabled = true;
        
    }
    
    
    return answer;
}

-(id)init {
    
    return [self initWithDelegate:nil];
    
}

-(void)dealloc {
	
	[self setDelegate:nil];
	
	
}


#pragma mark -
#pragma mark fields



// delegate
//id<JobListener> _delegate;
//@property (nonatomic, retain) id<JobListener> delegate;
@synthesize delegate = _delegate;


@end
