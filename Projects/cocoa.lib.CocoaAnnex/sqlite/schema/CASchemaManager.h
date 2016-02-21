//
//  NDSchemaManager.h
//  prototype
//
//  Created by rlong on 5/12/12.
//  Copyright (c) 2012 HexBeerium. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>


@class CASqliteConnection;
@class CATableDescriptor;

@interface CASchemaManager : NSObject

+(void)buildTables:(CASqliteConnection*)connection tables:(__strong CATableDescriptor*[])tables;
+(void)dropTables:(CASqliteConnection*)connection tables:(__strong CATableDescriptor*[])tables;

@end
