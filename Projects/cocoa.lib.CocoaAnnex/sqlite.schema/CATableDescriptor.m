//
//  NDTableDescriptor.m
//  prototype
//
//  Created by rlong on 4/12/12.
//  Copyright (c) 2012 HexBeerium. All rights reserved.
//




#import "CATableDescriptor.h"


////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

@interface CATableDescriptor ()


@end

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
#pragma mark -

@implementation CATableDescriptor




#pragma mark instance lifecycle


-(id)initWithName:(NSString*)name {
    
    CATableDescriptor* answer = [super init];
    
    if( nil != answer ) {
    
        [answer setConstraints:[NSArray array]];
        [answer setIndexes:[NSArray array]];
        [answer setName:name];
        [answer setProperties:[NSArray array]];
        
    }
    
    return answer;
    
}


-(void)dealloc {
	
	[self setConstraints:nil];
	[self setName:nil];
	[self setIndexes:nil];
    [self setProperties:nil];

	
}

#pragma mark fields

// constraints
//NSArray* _constraints;
//@property (nonatomic, retain) NSArray* constraints;
@synthesize constraints = _constraints;

// name
//NSString* _name;
//@property (nonatomic, retain) NSString* name;
@synthesize name = _name;

// indexes
//NSArray* _indexes;
//@property (nonatomic, retain) NSArray* indexes;
@synthesize indexes = _indexes;


// properties
//NSArray* _properties;
//@property (nonatomic, retain) NSArray* properties;
@synthesize properties = _properties;





@end
