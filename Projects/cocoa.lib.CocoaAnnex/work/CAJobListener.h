//  Copyright (c) 2013 Richard Long & HexBeerium
//
//  Released under the MIT license ( http://opensource.org/licenses/MIT )
//

#import <Foundation/Foundation.h>

#import "CABaseException.h"

#import "CAJob.h"

@protocol CAJobListener <NSObject>

-(void)jobCompleted:(id<CAJob>)job;
-(void)jobFailed:(id<CAJob>)job withException:(CABaseException*)exception;


@end
