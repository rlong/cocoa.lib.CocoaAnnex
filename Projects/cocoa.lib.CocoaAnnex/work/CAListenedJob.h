//  Copyright (c) 2013 Richard Long & HexBeerium
//
//  Released under the MIT license ( http://opensource.org/licenses/MIT )
//

#import <Foundation/Foundation.h>


@class CABaseException;
#import "CAJob.h"
@protocol CAJobListener;

@interface CAListenedJob : NSObject <CAJob> {
    
    // delegate
	id<CAJob> _delegate;
	//@property (nonatomic, retain) id<Job> delegate;
	//@synthesize delegate = _delegate;

    // listener
	id<CAJobListener> _listener;
	//@property (nonatomic, retain) id<JobListener> listener;
	//@synthesize listener = _listener;
    
    
    // exceptionCaughtDuringExecute
    CABaseException* _exceptionCaughtDuringExecute;
    //@property (nonatomic, retain) CABaseException* exceptionCaughtDuringExecute;
    //@synthesize exceptionCaughtDuringExecute = _exceptionCaughtDuringExecute;


    
}


#pragma mark -
#pragma mark instance lifecycle


-(id)initWithDelegate:(id<CAJob>)delegate listener:(id<CAJobListener>)listener;

@end
