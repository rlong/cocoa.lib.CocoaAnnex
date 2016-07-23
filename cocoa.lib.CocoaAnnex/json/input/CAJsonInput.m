// Copyright (c) 2013 Richard Long & HexBeerium
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//

#import "CABaseException.h"
#import "CAJsonInput.h"
#import "CAObjectTracker.h"


#define POOL_SIZE 5 

@implementation CAJsonInput {
    
    NSMutableArray* _mutableDataPool;
    int _mutableDataPoolIndex;

}



-(id)init {
    
    CAJsonInput* answer = [super init];
    
    _mutableDataPool = nil; // just to explicit about our intent
    answer->_mutableDataPoolIndex = 0; // the next free MutableData
    
    return answer;
    
}



-(BOOL)hasNextByte {
    
    CABaseException* e = [[CABaseException alloc] initWithOriginator:self line:__LINE__ faultMessage:@"unimplmeneted"];
    @throw e;
    
}
-(UInt8)currentByte {
    CABaseException* e = [[CABaseException alloc] initWithOriginator:self line:__LINE__ faultMessage:@"unimplmeneted"];
    @throw e;

}

-(UInt8)nextByte {
    CABaseException* e = [[CABaseException alloc] initWithOriginator:self line:__LINE__ faultMessage:@"unimplmeneted"];
    @throw e;

}



-(BOOL)doesByteBeginToken:(UInt8)candidateByte { 
	
	if( ' ' == candidateByte ) { 
		return false;
	}

    if( '\t' == candidateByte) {
		return false;
	}

    
	if( '\n' == candidateByte) {
		return false;
	}
    
	if( '\r' == candidateByte) {
		return false;
	}
	
	
	if( ',' == candidateByte) {
		return false;
	}
	
	if( ':' == candidateByte) {
		return false;
	}
	
	
	return true;
	
}

-(UInt8)scanToNextToken { 
    
	UInt8 currentByte = [self currentByte];
	
	if( [self doesByteBeginToken:currentByte] ) {
		
		return currentByte;
		
	}
	
	do {
		currentByte = [self nextByte];
		
        
	} while( ![self doesByteBeginToken:currentByte] );
	
	
	return currentByte;
	
	
    
}


#pragma mark pool management



-(NSMutableData*)reserveMutableData {
	
	if( nil == _mutableDataPool ) {
        _mutableDataPool = [[NSMutableArray alloc] initWithCapacity:POOL_SIZE];
        for( NSInteger i = 0; i < POOL_SIZE; i++ ) {
            [_mutableDataPool addObject:[NSNull null]];
        }
        
	}
	
	if( _mutableDataPoolIndex >= POOL_SIZE ) { 
		
		// revert to disposable MutableData objects
		
		_mutableDataPoolIndex++;
		
		NSMutableData* answer = [[NSMutableData alloc] init];
		return answer;
		
	}
	
    
    id pooledObject = [_mutableDataPool objectAtIndex:_mutableDataPoolIndex];
    
    if( [NSNull null] == pooledObject ) {
       
        pooledObject = [[NSMutableData alloc] init];
        [_mutableDataPool setObject:pooledObject atIndexedSubscript:_mutableDataPoolIndex];
    }
    
	NSMutableData* answer = pooledObject;
	_mutableDataPoolIndex++;
	
	return answer;
	
	
}


-(void)releaseMutableData:(NSMutableData*)freedMutableData {
	
	
	if( _mutableDataPoolIndex > POOL_SIZE ) {
		
		// release of disposable MutableData objects
		
		_mutableDataPoolIndex--;
        
		return;
	}
	
	_mutableDataPoolIndex--;
    
    NSMutableData* mutableData = [_mutableDataPool objectAtIndex:_mutableDataPoolIndex];
	[mutableData setLength:0];
    
}


@end
