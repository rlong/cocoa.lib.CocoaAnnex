//  Copyright (c) 2013 Richard Long & HexBeerium
//
//  Released under the MIT license ( http://opensource.org/licenses/MIT )
//


@protocol CAJob;
@protocol CAJobListener;


@interface CAWorkManager : NSObject

+(void)start;

+(void)enqueue:(id<CAJob>)request;
+(void)enqueue:(id<CAJob>)request listener:(id<CAJobListener>)listener;


@end
