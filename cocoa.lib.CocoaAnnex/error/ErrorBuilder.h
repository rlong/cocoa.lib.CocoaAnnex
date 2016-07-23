//
//  ErrorBuilder.h
//  
//
//  Created by rlong on 3/10/2015.
//
//

#import <Foundation/Foundation.h>



#define ErrorBuilder_errorForFailure( failure ) [ErrorBuilder errorForFailure:failure file:[NSString stringWithUTF8String:__FILE__] line:__LINE__ function:[NSString stringWithUTF8String:__FUNCTION__]];


