//  Copyright (c) 2013 Richard Long & HexBeerium
//
//  Released under the MIT license ( http://opensource.org/licenses/MIT )
//

#import <Foundation/Foundation.h>

#import "CAJob.h"

@class CABaseException;

typedef id(^CABlock)(id context);
typedef void(^CABlockDone)(id context, id blockResponse);
typedef void(^CABlockFailed)(id context, CABaseException* exceptionThrown);


@interface CABlockJob : NSObject <CAJob> {
    
    // context
    id _context;
    //@property (nonatomic, retain) id context;
    //@synthesize context = _context;

    // block
    CABlock _block;
    //@property (nonatomic, copy) CABlock block;
    //@synthesize block = _block;
    
    // blockResponse
    id _blockResponse;
    //@property (nonatomic, retain) id blockResponse;
    //@synthesize blockResponse = _blockResponse;

    
    // blockDone
    CABlockDone _blockDone;
    //@property (nonatomic, copy) CABlockDone blockDone;
    //@synthesize blockDone = _blockDone;

    // blockFailed
    CABlockFailed _blockFailed;
    //@property (nonatomic, copy) CABlockFailed blockFailed;
    //@synthesize blockFailed = _blockFailed;

    
}

+(void)executeWithContext:(id)context block:(CABlock)block;
+(void)executeWithContext:(id)context block:(CABlock)block onBlockDone:(CABlockDone)blockDone onBlockFailed:(CABlockFailed) blockFailed;

#pragma mark -
#pragma mark instance lifecycle

-(id)initWithContext:(id)context block:(CABlock)block;
-(id)initWithContext:(id)context block:(CABlock)block onBlockDone:(CABlockDone)blockDone onBlockFailed:(CABlockFailed) blockFailed;

@end
