//  Copyright (c) 2013 Richard Long & HexBeerium
//
//  Released under the MIT license ( http://opensource.org/licenses/MIT )
//

#import <Foundation/Foundation.h>

#import "CAJobListener.h"

@interface CAMainThreadJobListener1 : NSObject <CAJobListener> {
    
    // delegate
	__unsafe_unretained  id<CAJobListener> _delegate;
	//@property (nonatomic, retain) id<JobListener> delegate;
	//@synthesize delegate = _delegate;

    bool _enabled;
    
}


-(void)enable;
-(void)disable;
-(bool)isEnabled;


#pragma mark -
#pragma mark instance lifecycle

-(id)initWithDelegate:(id<CAJobListener>)delegate;
-(id)init;


#pragma mark -
#pragma mark fields


// delegate
//id<JobListener> _delegate;
@property (nonatomic, assign) id<CAJobListener> delegate;
//@synthesize delegate = _delegate;



@end
