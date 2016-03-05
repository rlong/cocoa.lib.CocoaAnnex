//
//  NDSchemaManager.m
//  prototype
//
//  Created by rlong on 5/12/12.
//  Copyright (c) 2012 HexBeerium. All rights reserved.
//


#import "CALog.h"
#import "CASchemaManager.h"
#import "CASqliteConnection.h"
#import "CASqliteUtilities.h"
#import "CASqliteStatement.h"
#import "CATableDescriptor.h"
#import "CATableProperty.h"


@implementation CASchemaManager



+(void)addIndexes:(CASqliteConnection*)connection tableDescriptor:(CATableDescriptor*)tableDescriptor {
    
    NSArray* indexes = [tableDescriptor indexes];
    
    for( NSString* createIndex in indexes ) {
        [connection exec:createIndex];
    }
    
}

+(void)buildTables:(CASqliteConnection*)connection tables:(__strong CATableDescriptor*[])tables {
    
    for( int i = 0; NULL != tables[i]; i++ ) {
        
        CATableDescriptor* tableDescriptor = tables[i];
  
        NSString* createTable = [self createTableDdl:tableDescriptor];
        
        [connection exec:createTable];
        
    }

    for( int i = 0; NULL != tables[i]; i++ ) {
        
        CATableDescriptor* tableDescriptor = tables[i];
        [self addIndexes:connection tableDescriptor:tableDescriptor];
    }
}



//////////////////////////////////////////////////////////////////////////

+(NSString*)createTableDdl:(CATableDescriptor*)tableDescriptor {
    
    
    NSMutableString* answer = [[NSMutableString alloc] initWithString:@"create table if not exists "];
    [answer appendString:[tableDescriptor name]];
    [answer appendString:@"(\n"];
    
    // properties ...
    {

        NSArray* properties = [tableDescriptor properties];
        
        BOOL firstProperty = true;
        
        for( CATableProperty* tableProperty in properties ) {
            
            if( firstProperty ) {
                firstProperty = false;
                [answer appendString:@"\t"];
            } else {
                [answer appendString:@",\n\t"];
            }
            
            [answer appendString:[tableProperty toString]];
        }

    }
    
    // constraints
    {
        NSArray* constraints = [tableDescriptor constraints];
        for( NSString* constraint in constraints ) {
            
            [answer appendString:@",\n\t"];
            [answer appendString:constraint];
        }
    }
    
    [answer appendString:@"\n);"];
    
    return answer;
}



+(NSString*)dropTableDdl:(CATableDescriptor*)tableDescriptor {
    

    NSMutableString* answer = [[NSMutableString alloc] initWithString:@"drop table if exists "];
    [answer appendString:[tableDescriptor name]];
    [answer appendString:@";"];
    
    return answer;
    
}


+(void)dropTables:(CASqliteConnection*)connection tables:(__strong CATableDescriptor*[])tables {
    

    for( int i = 0; NULL != tables[i]; i++ ) {
        
        CATableDescriptor* tableDescriptor = tables[i];
        NSString* dropStatement = [self dropTableDdl:tableDescriptor];
        Log_debugString( dropStatement );
        
        [connection exec:dropStatement];

        
    }
    
}


@end
