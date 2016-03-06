// Copyright (c) 2013 Richard Long & HexBeerium
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//

#import <Foundation/Foundation.h>

@interface CAJsonInput : NSObject {
    
	

}


-(BOOL)hasNextByte;
-(UInt8)currentByte;
-(UInt8)nextByte;


-(UInt8)scanToNextToken;


#pragma mark pool management

-(NSMutableData*)reserveMutableData;
-(void)releaseMutableData:(NSMutableData*)freedMutableData;


@end
