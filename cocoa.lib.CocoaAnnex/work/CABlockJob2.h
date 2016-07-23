//
//  CABlockJob2.h
//  jsonbroker
//
//  Created by rlong on 5/03/2014.
//
//

#import <Foundation/Foundation.h>


#import "CABaseException.h"
#import "CAJob.h"


typedef id(^CABlock2)();
typedef void(^CABlockDone2)();
typedef void(^CABlockFailed2)(CABaseException* exceptionThrown);


@interface CABlockJob2 : NSObject <CAJob> {
    
    // block
    CABlock2 _block;
    //@property (nonatomic, copy) CABlock block;
    //@synthesize block = _block;
    
    // blockDone
    CABlockDone2 _blockDone;
    //@property (nonatomic, copy) CABlockDone blockDone;
    //@synthesize blockDone = _blockDone;
    
    // blockFailed
    CABlockFailed2 _blockFailed;
    //@property (nonatomic, copy) CABlockFailed blockFailed;
    //@synthesize blockFailed = _blockFailed;
    
    // blockResponse
    id _blockResponse;
    //@property (nonatomic, retain) id blockResponse;
    //@synthesize blockResponse = _blockResponse;


    
}


+(void)executeWithBlock:(CABlock2)block;
+(void)executeWithBlock:(CABlock2)block onBlockDone:(CABlockDone2)blockDone onBlockFailed:(CABlockFailed2) blockFailed;


@end
