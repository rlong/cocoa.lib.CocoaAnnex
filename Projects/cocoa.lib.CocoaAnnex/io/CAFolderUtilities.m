// Copyright (c) 2013 Richard Long & HexBeerium
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//

#import "CABaseException.h"
#import "CAFolderUtilities.h"
#import "CALog.h"

@implementation CAFolderUtilities



static NSString* _applicationSupportDirectory = nil;
static NSString* _cachesDirectory = nil;
static NSString* _documentDirectory = nil;
static NSString* _libraryDirectory = nil;

+(BOOL)directoryExistsAtPath:(NSString*)path {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    BOOL isDirectory;
    
    BOOL fileExists = [fileManager fileExistsAtPath:path isDirectory:&isDirectory];
    
    if( !fileExists ) {
        return false;
    }
    
    return isDirectory;

    
}

+(NSString*)getApplicationSupportDirectory {
    
    if( nil != _applicationSupportDirectory ) {
        return _applicationSupportDirectory;
    }
    

    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
    if( 0 == [paths count] ) {
        
        @throw  [CABaseException baseExceptionWithOriginator:self line:__LINE__ faultStringFormat:@"0 == [paths count], searching for `NSApplicationSupportDirectory`"];
        
    } else if( 1 == [paths count] ) {
        _applicationSupportDirectory = [paths objectAtIndex:0];
    } else {
        Log_warnInt([paths count]);
        _applicationSupportDirectory = [paths objectAtIndex:0];
    }

    Log_debugString(_applicationSupportDirectory);
    return _applicationSupportDirectory;
    
}





+(NSString*)getCachesDirectory {
    
    if( nil != _cachesDirectory ) {
        return _cachesDirectory;
    }
    
    
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    if( 0 == [paths count] ) {
        
        @throw  [CABaseException baseExceptionWithOriginator:self line:__LINE__ faultStringFormat:@"0 == [paths count], searching for `NSCachesDirectory`"];
        
    } else if( 1 == [paths count] ) {
        _cachesDirectory = [paths objectAtIndex:0];
    } else {
        Log_warnInt([paths count]);
        _cachesDirectory = [paths objectAtIndex:0];
    }

    Log_debugString(_cachesDirectory);
    return _cachesDirectory;
    
}

+(NSString*)getDocumentDirectory {
    
    if( nil != _documentDirectory ) {
        return _documentDirectory;
    }
    
    
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    if( 0 == [paths count] ) {
        
        @throw  [CABaseException baseExceptionWithOriginator:self line:__LINE__ faultStringFormat:@"0 == [paths count], searching for `NSDocumentDirectory`"];
        
    } else if( 1 == [paths count] ) {
        _documentDirectory = [paths objectAtIndex:0];
    } else {
        Log_warnInt([paths count]);
        _documentDirectory = [paths objectAtIndex:0];
    }
    
    Log_debugString(_documentDirectory);
    return _documentDirectory;
    
}


+(NSString*)getLibraryDirectory {
    
    if( nil != _libraryDirectory ) {
        return _libraryDirectory;
    }
    
    
    NSArray* paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    if( 0 == [paths count] ) {
        
        @throw  [CABaseException baseExceptionWithOriginator:self line:__LINE__ faultStringFormat:@"0 == [paths count], searching for `NSLibraryDirectory`"];
        
    } else if( 1 == [paths count] ) {
        _libraryDirectory = [paths objectAtIndex:0];
    } else {
        Log_warnInt([paths count]);
        _libraryDirectory = [paths objectAtIndex:0];
    }
    
    Log_debugString(_libraryDirectory);
    return _libraryDirectory;
    
}

+(void)mkdirs:(NSString*)pathname {
    
    NSError* error = nil;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    [fileManager createDirectoryAtPath:pathname withIntermediateDirectories:TRUE attributes:nil error:&error];
    
    if( nil != error ) {
        
        CABaseException* e = [CABaseException baseExceptionWithOriginator:self line:__LINE__ callTo:@"[NSFileManager createDirectoryAtPath:withIntermediateDirectories:attributes:error:]" failedWithError:error];
        [e addStringContext:pathname withName:@"pathname"];
        @throw e;
        
    }
    
    
}

@end
