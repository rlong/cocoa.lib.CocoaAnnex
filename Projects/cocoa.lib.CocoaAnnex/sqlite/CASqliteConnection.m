//
//  XPSqliteConnection.m
//  vlc_amigo
//
//  Created by rlong on 5/05/13.
//
//

#import "FALog.h"


#import "CASqliteConnection.h"
#import "CASqliteStatement.h"
#import "CASqliteUtilities.h"

@implementation CASqliteConnection

-(void)begin {
    
    // vvv http://stackoverflow.com/questions/416924/sqlite-3-c-api-transactions
    
    int resultCode = sqlite3_exec(_connection, "BEGIN", NULL, NULL, NULL);
    [CASqliteUtilities checkResultCodeIsOk:resultCode forConnection:_connection];
    
    
    // ^^^ http://stackoverflow.com/questions/416924/sqlite-3-c-api-transactions
    
    
}

-(void)close {
    
    int resultCode = sqlite3_close(_connection);
    [CASqliteUtilities checkResultCodeIsOk:resultCode forConnection:_connection];
    
    _connection = NULL;
    
}

-(void)commit {
    
    // vvv http://stackoverflow.com/questions/416924/sqlite-3-c-api-transactions
    
    int resultCode = sqlite3_exec(_connection, "COMMIT", NULL, NULL, NULL);
    [CASqliteUtilities checkResultCodeIsOk:resultCode forConnection:_connection];
    
    // ^^^ http://stackoverflow.com/questions/416924/sqlite-3-c-api-transactions
    
}


-(void)exec:(NSString*)statement {
    
    Log_debugString( statement );
    
    const char* utf8Statement = [statement UTF8String];
    
    int resultCode = sqlite3_exec(_connection, utf8Statement, NULL, NULL, NULL);
    [CASqliteUtilities checkResultCodeIsOk:resultCode forConnection:_connection];
    
}

-(long long)last_insert_rowid {
    
    return sqlite3_last_insert_rowid( _connection );
    
}

+(CASqliteConnection*)open:(NSString*)filename {
    
    const char* path = [filename UTF8String];
    sqlite3* connection;
    
	int resultCode = sqlite3_open( path, &connection );
    [CASqliteUtilities checkResultCodeIsOk:resultCode forConnection:connection];
    
    // http://www.sqlite.org/c3ref/get_autocommit.html ...
    //  Autocommit mode is on by default. Autocommit mode is disabled by a BEGIN statement
    //
    
    // all is well ... (we assume)
    

    CASqliteConnection* answer = [[CASqliteConnection alloc] initWithConnection:connection];
    
    return answer;
    
}

-(CASqliteStatement*)prepare:(NSString*)sql {
    
    sqlite3_stmt *statement;
    
    const char* utf8Sql = [sql UTF8String];
	
	//http://www.sqlite.org/c3ref/prepare.html
	int resultCode = sqlite3_prepare( _connection, utf8Sql, -1, &statement, 0);
	[CASqliteUtilities checkResultCodeIsOk:resultCode forConnection:_connection];
    
    CASqliteStatement* answer = [[CASqliteStatement alloc] initWithStatement:statement];

    return answer;
    
}

#pragma mark -
#pragma mark instance lifecycle

-(id)initWithConnection:(sqlite3*)connection {
    
    CASqliteConnection* answer = [super init];
    
    answer->_connection = connection;
    
    return answer;
    
}


-(void)dealloc {
    
    if( NULL != _connection ) {
        
        Log_warn( @"NULL != _connection" );
        [self close];
        _connection = NULL;
    }

}

@end
