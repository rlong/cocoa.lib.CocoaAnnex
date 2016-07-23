// Copyright (c) 2013 Richard Long & HexBeerium
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//


#import "CABaseException.h"
#import "CAJsonBooleanHandler.h"
#import "CAJsonDataInput.h"
#import "CAJsonNumberHandler.h"
#import "CAJsonNullHandler.h"
#import "CAJsonReader.h"
#import "CAJsonStringHandler.h"


@implementation CAJsonReader

-(void)readArrayFromInput:(CAJsonInput*)input handler:(id<CAJsonDocumentHandler>)handler {
 
    int index = -1;

    for (UInt8 nextTokenStart = [input scanToNextToken]; ']' != nextTokenStart; nextTokenStart = [input scanToNextToken] ) {
        
        if( !_continue ) {
            return;
        }

        index++;
        
        if ('"' == nextTokenStart) {
            
            NSString* value = [CAJsonStringHandler readString:input];
            [handler onStringWithIndex:index value:value];
            continue;
        }
        
        if ('0' <= nextTokenStart && nextTokenStart <= '9') {
            
            NSNumber* value = [CAJsonNumberHandler readNumber:input];
            [handler onNumberWithIndex:index value:value];
            continue;
        }
        
        if ('[' == nextTokenStart) {
            
            [handler onArrayStartWithIndex:index];
            [input nextByte]; // skip past the '['
            [self readArrayFromInput:input handler:handler];
            [input nextByte]; // skip past the ']'
            [handler onArrayEndWithIndex:index];
            continue;
        }
        
        if ('{' == nextTokenStart) {
            
            [handler onObjectStartWithIndex:index];
            [input nextByte]; // skip past the '{'
            [self readObjectFromInput:input handler:handler];
            [input nextByte]; // skip past the '}'
            [handler onObjectEndWithIndex:index];
            continue;
            
        }
        
        if ('+' == nextTokenStart ) {
            
            NSNumber* value = [CAJsonNumberHandler readNumber:input];
            [handler onNumberWithIndex:index value:value];
            continue;
        }
        
        if ('-' == nextTokenStart ) {
            
            NSNumber* value = [CAJsonNumberHandler readNumber:input];
            [handler onNumberWithIndex:index value:value];
            continue;
        }
        
        if( 't' == nextTokenStart || 'T' == nextTokenStart ) {
            bool value = [CAJsonBooleanHandler readBoolean:input];
            [handler onBooleanWithIndex:index value:value];
            continue;
        }
        
        
        if( 'f' == nextTokenStart || 'F' == nextTokenStart ) {
            bool value = [CAJsonBooleanHandler readBoolean:input];
            [handler onBooleanWithIndex:index value:value];
            continue;
        }
        
        if( 'n' == nextTokenStart || 'N' == nextTokenStart ) {
            [CAJsonNullHandler readNull:input];
            [handler onNullWithIndex:index];
            continue;
        }


        @throw [CABaseException baseExceptionWithOriginator:self line:__LINE__ faultStringFormat:@"bad tokenBeginning; tokenBeginning = %d (%c)", nextTokenStart, nextTokenStart];

    }
}


-(void)readObjectFromInput:(CAJsonInput*)input handler:(id<CAJsonDocumentHandler>)handler {
    

    for (UInt8 nextTokenStart = [input scanToNextToken]; '}' != nextTokenStart; nextTokenStart = [input scanToNextToken] ) {
        
        if( !_continue ) {
            return;
        }
        
        NSString* key = [CAJsonStringHandler readString:input];
        
        nextTokenStart = [input scanToNextToken];
        
        if ('"' == nextTokenStart) {
            
            NSString* value = [CAJsonStringHandler readString:input];
            [handler onStringWithKey:key value:value];
            continue;
        }
        
        if ('0' <= nextTokenStart && nextTokenStart <= '9') {
            
            NSNumber* value = [CAJsonNumberHandler readNumber:input];
            [handler onNumberWithKey:key value:value];
            continue;
        }
        
        if ('[' == nextTokenStart) {
            
            [handler onArrayStartWithKey:key];
            [input nextByte]; // skip past the '['
            [self readArrayFromInput:input handler:handler];
            [input nextByte]; // skip past the ']'
            [handler onArrayEndWithKey:key];
            continue;
        }
        
        if ('{' == nextTokenStart) {
            
            [handler onObjectStartWithKey:key];
            [input nextByte]; // skip past the '{'
            [self readObjectFromInput:input handler:handler];
            [input nextByte]; // skip past the '}'
            [handler onObjectEndWithKey:key];
            continue;
            
        }
        
        if ('+' == nextTokenStart ) {
            
            NSNumber* value = [CAJsonNumberHandler readNumber:input];
            [handler onNumberWithKey:key value:value];
            continue;
        }
        
        if ('-' == nextTokenStart ) {
            
            NSNumber* value = [CAJsonNumberHandler readNumber:input];
            [handler onNumberWithKey:key value:value];
            continue;
        }
        
        if( 't' == nextTokenStart || 'T' == nextTokenStart ) {
            bool value = [CAJsonBooleanHandler readBoolean:input];
            [handler onBooleanWithKey:key value:value];
            continue;
        }
        
        
        if( 'f' == nextTokenStart || 'F' == nextTokenStart ) {
            bool value = [CAJsonBooleanHandler readBoolean:input];
            [handler onBooleanWithKey:key value:value];
            continue;
        }
        
        if( 'n' == nextTokenStart || 'N' == nextTokenStart ) {
            [CAJsonNullHandler readNull:input];
            [handler onNullWithKey:key];
            continue;
        }

        @throw [CABaseException baseExceptionWithOriginator:self line:__LINE__ faultStringFormat:@"bad tokenBeginning; tokenBeginning = %d (%c)", nextTokenStart, nextTokenStart];
        
    }
    
}



-(void)readFromInput:(CAJsonInput*)input handler:(id<CAJsonDocumentHandler>)handler {
    
    _continue = true;
    
    UInt8 nextByte = [input currentByte];
    
    const UInt8 ht = 0x09;
    const UInt8 nl = 0x0a;
    const UInt8 cr = 0x0d;
    const UInt8 spc = 0x20;
    
    while( nextByte != '{' && nextByte != '[' ) {
        if( nextByte != ht && nextByte != nl && nextByte != cr  && nextByte != spc ) {
            @throw [CABaseException baseExceptionWithOriginator:self line:__LINE__ faultStringFormat:@"unexpected character before beginning of JSON document; nextByte = %d (%c)", nextByte, nextByte ];
        }
        nextByte = [input nextByte];
    }

        
    [input nextByte];  // skip past the '{' / '['

    if( '{' == nextByte ) {
        
        [handler onObjectDocumentStart];
        [self readObjectFromInput:input handler:handler];
        [handler onObjectDocumentEnd];
        
    } else {
        
        [handler onArrayDocumentStart];
        [self readArrayFromInput:input handler:handler];
        [handler onArrayDocumentEnd];
        
    }
    
    
}


-(void)readFromData:(NSData*)data handler:(id<CAJsonDocumentHandler>)handler {
    
    CAJsonDataInput* input = [[CAJsonDataInput alloc] initWithData:data];
    @try {
        [self readFromInput:input handler:handler];
    }
    @finally {
    }
}



+(void)readFromInput:(CAJsonInput*)input handler:(id<CAJsonDocumentHandler>)handler {
    
    
    CAJsonReader* reader = [[CAJsonReader alloc] init];
    
    @try {
        
        [reader readFromInput:input handler:handler];
    }
    @finally {
    }
    
    
    
}

+(void)readFromData:(NSData*)data handler:(id<CAJsonDocumentHandler>)handler {

    CAJsonDataInput* input = [[CAJsonDataInput alloc] initWithData:data];
    CAJsonReader* reader = [[CAJsonReader alloc] init];

    @try {
        
        [reader readFromInput:input handler:handler];
    }
    @finally {
    }

}


-(void)stop {
    _continue = false;
}



#pragma mark -
#pragma mark instance lifecycle

-(id)init {
    
    CAJsonReader* answer = [super init];
    if( nil != answer ) {
        
        answer->_continue = true;
        
    }
    
    return answer;
}


@end
