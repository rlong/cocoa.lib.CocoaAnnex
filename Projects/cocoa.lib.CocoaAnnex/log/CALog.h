//  https://github.com/rlong/cocoa.lib.CocoaAnnex
//
//  Copyright (c) 2015 Richard Long
//
//  Released under the MIT license ( http://opensource.org/licenses/MIT )
//

//
// vvv derived from https://github.com/rlong/jsonbroker.objective_c/blob/master/src/jsonbroker.library/common/log/JBLog.h
//

#import <Foundation/Foundation.h>


@interface CALog : NSObject  {
}



#pragma mark -
#pragma mark Debug

#ifdef DEBUG
#define Log_isDebugEnabled() TRUE
#else
#define Log_isDebugEnabled() FALSE
#endif


+ (void)debug:(NSString *)message inFunction:(const char*)function;
#ifdef DEBUG
#define Log_debug(message) [CALog debug:message inFunction:__func__]
#else
#define Log_debug(message)
#endif


+(void)debugBool:(BOOL)value withName:(const char*)name inFunction:(const char*)function;
#ifdef DEBUG
#define Log_debugBool(value) [CALog debugBool:value withName:#value inFunction:__func__]
#else
#define Log_debugBool(value)
#endif



+ (void)debugData:(NSData *)value withName:(const char*)name inFunction:(const char*)function;
#ifdef DEBUG
#define Log_debugData(value) [CALog debugData:value withName:#value inFunction:__func__]
#else
#define Log_debugData(value)
#endif


+ (void)debugDate:(NSDate *)value withName:(const char*)name inFunction:(const char*)function;
#ifdef DEBUG
#define Log_debugDate(value) [CALog debugDate:value withName:#value inFunction:__func__]
#else
#define Log_debugDate(value)
#endif


+ (void)debugDouble:(double)value withName:(const char*)name inFunction:(const char*)function;
#ifdef DEBUG
#define Log_debugDouble(value) [CALog debugFloat:value withName:#value inFunction:__func__]
#else
#define Log_debugDouble(value)
#endif


+(void)debugError:(NSError*)error withName:(const char*)name inFunction:(const char*)function;
#ifdef DEBUG
#define Log_debugError(value) [CALog debugError:value withName:#value inFunction:__func__]
#else
#define Log_debugError(value)
#endif


+ (void)debugFloat:(double)value withName:(const char*)name inFunction:(const char*)function;
#ifdef DEBUG
#define Log_debugFloat(value) [CALog debugFloat:value withName:#value inFunction:__func__]
#else
#define Log_debugFloat(value)
#endif


+(void)debugForFunction:(const char*)function format:(NSString *)format, ...;
#ifdef DEBUG
#define Log_debugFormat(...) [CALog debugForFunction:__func__ format:__VA_ARGS__]
#else
#define Log_debugFormat(...)
#endif


+ (void)debugInt:(long)value withName:(const char*)name inFunction:(const char*)function;
#ifdef DEBUG
#define Log_debugInt(value) [CALog debugInt:value withName:#value inFunction:__func__]
#else
#define Log_debugInt(value)
#endif


+ (void)debugIp4Address:(in_addr_t)value withName:(const char*)name inFunction:(const char*)function;
#ifdef DEBUG
#define Log_debugIp4Address(value) [CALog debugIp4Address:value withName:#value inFunction:__func__]
#else
#define Log_debugIp4Address(value)
#endif



+ (void)debugLong:(long)value withName:(const char*)name inFunction:(const char*)function;
#ifdef DEBUG
#define Log_debugLong(value) [CALog debugInt:value withName:#value inFunction:__func__]
#else
#define Log_debugLong(value)
#endif

+ (void)debugLongLong:(long long)value withName:(const char*)name inFunction:(const char*)function;
#ifdef DEBUG
#define Log_debugLongLong(value) [CALog debugLongLong:value withName:#value inFunction:__func__]
#else
#define Log_debugLongLong(value)
#endif


+ (void)debugPointer:(void*)value withName:(const char*)name inFunction:(const char*)function;
#ifdef DEBUG
#define Log_debugPointer(value) [CALog debugPointer:value withName:#value inFunction:__func__]
#else
#define Log_debugPointer(value)
#endif

+ (void)debugString:(NSString *)value withName:(const char*)name inFunction:(const char*)function;
#ifdef DEBUG
#define Log_debugString(value) [CALog debugString:value withName:#value inFunction:__func__]
#else
#define Log_debugString(value)
#endif

+ (void)debugUtf8String:(const char*)value withName:(const char*)name inFunction:(const char*)function;
#ifdef DEBUG
#define Log_debugUtf8String(value) [CALog debugUtf8String:value withName:#value inFunction:__func__]
#else
#define Log_debugUtf8String(value)
#endif

///////////////////////////////////////////////////////////

+(void)entered:(const char*)function;
#ifdef DEBUG
#define Log_enteredMethod() [CALog entered:__func__]
#else
#define Log_enteredMethod()
#endif


#pragma mark -
#pragma mark Information



+ (void)info:(NSString *)message inFunction:(const char*)function;
#define Log_info(message) [CALog info:message inFunction:__func__]


+(void)infoBool:(BOOL)value withName:(const char*)name inFunction:(const char*)function;
#define Log_infoBool(value) [CALog infoBool:value withName:#value inFunction:__func__]

+ (void)infoDouble:(double)value withName:(const char*)name inFunction:(const char*)function;
#define Log_infoDouble(value) [CALog infoFloat:value withName:#value inFunction:__func__]

+ (void)infoFloat:(double)value withName:(const char*)name inFunction:(const char*)function;
#define Log_infoFloat(value) [CALog infoFloat:value withName:#value inFunction:__func__]

+ (void)infoInt:(long)value withName:(const char*)name inFunction:(const char*)function;
#define Log_infoInt(value) [CALog infoInt:value withName:#value inFunction:__func__]

+ (void)infoLong:(long)value withName:(const char*)name inFunction:(const char*)function;
#define Log_infoLong(value) [CALog infoLong:value withName:#value inFunction:__func__]

+ (void)infoLongLong:(long long)value withName:(const char*)name inFunction:(const char*)function;
#define Log_infoLongLong(value) [CALog infoLongLong:value withName:#value inFunction:__func__]

+(void)infoPointer:(void*)value withName:(const char*)name inFunction:(const char*)function;
#define Log_infoPointer(value) [CALog infoPointer:value withName:#value inFunction:__func__]

+ (void)infoString:(NSString*)value withName:(const char*)name inFunction:(const char*)function;
#define Log_infoString(value) [CALog infoString:value withName:#value inFunction:__func__]

+(void)infoInFunction:(const char*)function format:(NSString*)format, ...;
#define Log_infoFormat( ... ) [CALog infoInFunction:__func__ format:__VA_ARGS__]


#pragma mark -
#pragma mark Warning

+ (void)warn:(NSString *)message inFunction:(const char*)function;
#define Log_warn(message) [CALog warn:message inFunction:__func__]

+(void)warnBool:(BOOL)value withName:(const char*)name inFunction:(const char*)function;
#define Log_warnBool(value) [CALog warnBool:value withName:#value inFunction:__func__]

+ (void)warnCallTo:(NSString*)methodName failedWithErrno:(int)value inFunction:(const char*)function;
#define Log_warnCallFailed(methodName,errorCode) [CALog warnCallTo:methodName failedWithErrno:errorCode inFunction:__func__]


+ (void)warnDouble:(double)value withName:(const char*)name inFunction:(const char*)function;
#define Log_warnDouble(value) [CALog warnFloat:value withName:#value inFunction:__func__]

+(void)warnError:(NSError*)error withName:(const char*)name inFunction:(const char*)function;
#define Log_warnError(error) [CALog warnError:error withName:#error inFunction:__func__]

+ (void)warnException:(NSException *)e withName:(const char*)name inFunction:(const char*)function;
#define Log_warnException(exception) [CALog warnException:exception withName:#exception inFunction:__func__]

+ (void)warnFloat:(double)value withName:(const char*)name inFunction:(const char*)function;
#define Log_warnFloat(value) [CALog warnFloat:value withName:#value inFunction:__func__]

+ (void)warnInt:(long)value withName:(const char*)name inFunction:(const char*)function;
#define Log_warnInt(value) [CALog warnInt:value withName:#value inFunction:__func__]

+ (void)warnLong:(long)value withName:(const char*)name inFunction:(const char*)function;
#define Log_warnLong(value) [CALog warnLong:value withName:#value inFunction:__func__]

+ (void)warnLongLong:(long long)value withName:(const char*)name inFunction:(const char*)function;
#define Log_warnLongLong(value) [CALog warnLongLong:value withName:#value inFunction:__func__]

+ (void)warnPointer:(void*)value withName:(const char*)name inFunction:(const char*)function;
#define Log_warnPointer(value) [CALog warnPointer:value withName:#value inFunction:__func__]

+ (void)warnString:(NSString *)value withName:(const char*)name inFunction:(const char*)function;
#define Log_warnString(value) [CALog warnString:value withName:#value inFunction:__func__]

+ (void)warnUtf8String:(const char*)value withName:(const char *)name inFunction:(const char*)function;
#define Log_warnUtf8String(value) [CALog warnUtf8String:value withName:#value inFunction:__func__]


+(void)warnInFunction:(const char*)function format:(NSString *)format, ...;
#define Log_warnFormat( ... ) [CALog warnInFunction:__func__ format:__VA_ARGS__]

#pragma mark -
#pragma mark Error

+ (void)error:(NSString *)message inFunction:(const char*)function;
#define Log_error(message) [CALog error:message inFunction:__func__]

+(void)errorBool:(BOOL)value withName:(const char*)name inFunction:(const char*)function;
#define Log_errorBool(value) [CALog errorBool:value withName:#value inFunction:__func__]

+ (void)errorCallTo:(NSString*)methodName failedWithErrno:(int)value inFunction:(const char*)function;
#define Log_errorCallFailed(methodName,errorCode) [CALog errorCallTo:methodName failedWithErrno:errorCode inFunction:__func__]

+ (void)errorDouble:(double)value withName:(const char*)name inFunction:(const char*)function;
#define Log_errorDouble(value) [CALog errorDouble:value withName:#value inFunction:__func__]

+(void)errorError:(NSError*)error withName:(const char*)name inFunction:(const char*)function;
#define Log_errorError(error) [CALog errorError:error withName:#error inFunction:__func__]

+ (void)errorException:(NSException *)e withName:(const char*)name inFunction:(const char*)function;
#define Log_errorException(exception) [CALog errorException:exception withName:#exception inFunction:__func__] 

+ (void)errorFloat:(double)value withName:(const char*)name inFunction:(const char*)function;
#define Log_errorFloat(value) [CALog errorFloat:value withName:#value inFunction:__func__]

+(void)errorInFunction:(const char*)function format:(NSString *)format, ...;
#define Log_errorFormat( ... ) [CALog errorInFunction:__func__ format:__VA_ARGS__]

+ (void)errorInt:(long)value withName:(const char*)name inFunction:(const char*)function;
#define Log_errorInt(value) [CALog errorInt:value withName:#value inFunction:__func__]


+ (void)errorLong:(long)value withName:(const char*)name inFunction:(const char*)function;
#define Log_errorLong(value) [CALog errorLong:value withName:#value inFunction:__func__]

+ (void)errorLongLong:(long long)value withName:(const char*)name inFunction:(const char*)function;
#define Log_errorLongLong(value) [CALog errorLongLong:value withName:#value inFunction:__func__]

+ (void)errorString:(NSString *)value withName:(const char*)name inFunction:(const char*)function;
#define Log_errorString(value) [CALog errorString:value withName:#value inFunction:__func__]

+ (void)errorUtf8String:(const char*)value withName:(const char*)name inFunction:(const char*)function;
#define Log_errorUtf8String(value) [CALog errorUtf8String:value withName:#value inFunction:__func__]

@end


// ^^^ derived from https://github.com/rlong/jsonbroker.objective_c/blob/master/src/jsonbroker.library/common/log/JBLog.h

