// Copyright (c) 2013 Richard Long & HexBeerium
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//


#import "CALoggable.h"

@interface BaseException  : NSException <CALoggable>
{

    // cause
	NSException* _cause;
	//@property (nonatomic, retain) NSException* cause;
	//@synthesize cause = _cause;

    // errorDomain
    NSString* _errorDomain;
    //@property (nonatomic, retain) NSString* errorDomain;
    //@synthesize errorDomain = _errorDomain;

    ///////////////////////////////////////////////////////////////////////
    // from XML-RPC ... faultCode
	int _faultCode;
	//@property (nonatomic) int faultCode;
	//@synthesize faultCode = _faultCode;

	NSMutableDictionary *_faultContext;
	//@property (nonatomic, retain) NSMutableDictionary* faultContext;
	//@synthesize faultContext = _faultContext;

    
	NSError *_error;
	//@property (nonatomic, retain) NSError* error;
	//@synthesize error = _error;

    NSString* _file;
	//@property (nonatomic, retain) NSString* file;
	//@synthesize file = _file;

    
	NSString* _function;
	//@property (nonatomic, retain) NSString* function;
	//@synthesize function = _function;

	NSString* _originator;
	//@property (nonatomic, retain) NSString* originator;
	//@synthesize originator = _originator;

    
    // underlyingFaultMessage
	NSString* _underlyingFaultMessage;
	//@property (nonatomic, retain) NSString* underlyingFaultMessage;
	//@synthesize underlyingFaultMessage = _underlyingFaultMessage;

    

	
}


+(int)defaultFaultCode;


-(void)addStringContext:(NSString*)value withName:(NSString*)name;
-(void)addIntContext:(long)value withName:(NSString*)name;

-(void)addContext:(NSDictionary*)moreContext;


#pragma mark -
#pragma mark instance lifecycle

-(id)initWithOriginator:(NSString*)originator faultMessage:(NSString *)faultMessage;
-(id)initWithOriginator:(id)originatingObject line:(int)line faultMessage:(NSString *)faultString;
-(id)initWithOriginator:(id)originatingObject line:(int)line faultStringFormat:(NSString *)faultStringFormat arguments:(va_list)argList;
-(id)initWithOriginator:(id)originatingObject line:(int)line faultStringFormat:(NSString *)faultStringFormat, ...;
-(id)initWithOriginator:(id)originatingObject line:(int)line callTo:(NSString*)methodName failedWithErrno:(int)value;
-(id)initWithOriginator:(id)originatingObject line:(int)line callTo:(NSString*)methodName failedWithError:(NSError*)error;
-(id)initWithOriginator:(id)originatingObject line:(int)line cause:(NSException*)cause;



#pragma mark -
#pragma mark fields


// cause
//NSException* _cause;
@property (nonatomic, retain) NSException* cause;
//@synthesize cause = _cause;


//NSError *_error;
@property (nonatomic, retain) NSError* error;
//@synthesize error = _error;

// originally from XML-RPC ... faultCode

// errorDomain
//NSString* _errorDomain;
@property (nonatomic, retain) NSString* errorDomain;
//@synthesize errorDomain = _errorDomain;

//int _faultCode;
@property (nonatomic, setter = setFaultCode:) int faultCode;
//@synthesize faultCode = _faultCode;

//NSMutableDictionary *_faultContext;
@property (nonatomic, retain) NSMutableDictionary* faultContext;
//@synthesize faultContext = _faultContext;

//NSString* _file;
@property (nonatomic, retain) NSString* file;
//@synthesize file = _file;


//NSString* _function;
@property (nonatomic, retain) NSString* function;
//@synthesize function = _function;

//NSString* _originator;
@property (nonatomic, retain) NSString* originator;
//@synthesize originator = _originator;

// underlyingFaultMessage
//NSString* _underlyingFaultMessage;
@property (nonatomic, retain) NSString* underlyingFaultMessage;
//@synthesize underlyingFaultMessage = _underlyingFaultMessage;





@end
