//
//  CAJsonMlHelper.m
//  jsonbroker
//
//  Created by rlong on 1/04/2014.
//
//


#import "CAJsonBuilder.h"
#import "CAJsonMlHelper.h"
#import "CAJsonObject.h"
#import "CASaxHandler.h"

@implementation CAJsonMlHelper



+(CAJsonArray*)buildWithParser:(NSXMLParser*)parser {

    CAJsonBuilder* jsonBuilder = [[CAJsonBuilder alloc] init];
    CASaxHandler* handler = [[CASaxHandler alloc] initWithJsonHandler:jsonBuilder];

    [parser setDelegate:handler];
    [parser parse];
    
    CAJsonArray* answer = [jsonBuilder arrayDocument];
    return answer;

}


+(CAJsonArray*)buildWithContentsOfData:(NSData*)data {

    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    
    return [self buildWithParser:parser];

}

+(CAJsonArray*)buildWithContentsOfURL:(NSURL *)url {
    
    
    NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    
    return [self buildWithParser:parser];

}


+(NSArray*)allChildrenOfParent:(CAJsonArray*)parentElement withName:(NSString*)elementName {
    
    NSMutableArray* answer = [[NSMutableArray alloc] init];

    // no attributes or children ?
    if( 1 == [parentElement count] ) {
        return answer;
    }
    
    int startingIndex = 1;
    
    id objectAtIndex1 = [parentElement objectAtIndex:1];
    
    // skip past the attributes if they exit
    if( [objectAtIndex1 isKindOfClass:[CAJsonObject class]] ) {
        startingIndex = 2;
    }
    
    for( int i = startingIndex, count = [parentElement count]; i < count; i++ ) {

        id candidate = [parentElement objectAtIndex:i];
        if( [candidate isKindOfClass:[CAJsonArray class]] ) {
            CAJsonArray* candidateElement = (CAJsonArray*)candidate;
            NSString* candidateElementName = [candidateElement getString:0];
            if( [elementName isEqualToString:candidateElementName] ) {
                [answer addObject:candidateElement];
            }
        }
    }
    
    return answer;
    
}

// can return nil
+(NSString*)attributeOfElement:(CAJsonArray*)element withName:(NSString*)attributeName {
    
    
    // no attributes ?
    if( 2 > [element count] ) {
        return nil;
    }
    
    id objectAtIndex1 = [element objectAtIndex:1];
    
    // second element is attributes ?
    if( ![objectAtIndex1 isKindOfClass:[CAJsonObject class]] ) {
        return nil;
    }
    
    CAJsonObject* attributes = (CAJsonObject*)objectAtIndex1;
    NSString* answer = [attributes stringForKey:attributeName defaultValue:nil];
    return answer;

    
}

// can return nil
+(CAJsonArray*)firstChildOfParent:(CAJsonArray*)parentElement withName:(NSString*)childsName {
    
    // no attributes or children ?
    if( 1 == [parentElement count] ) {
        return nil;
    }
    
    int startingIndex = 1;
    
    id objectAtIndex1 = [parentElement objectAtIndex:1];
    
    // skip past the attributes if they exit
    if( [objectAtIndex1 isKindOfClass:[CAJsonObject class]] ) {
        startingIndex = 2;
    }
    
    for( int i = startingIndex, count = [parentElement count]; i < count; i++ ) {
        
        id candidate = [parentElement objectAtIndex:i];
        if( [candidate isKindOfClass:[CAJsonArray class]] ) {
            CAJsonArray* candidateElement = (CAJsonArray*)candidate;
            NSString* candidateElementName = [candidateElement getString:0];
            if( [childsName isEqualToString:candidateElementName] ) {
                return candidateElement;
            }
        }
    }
    
    return nil;
    
}

// can return nil
+(NSString*)firstTextContentFromElement:(CAJsonArray*)element {
    
    // no attributes or children ?
    if( 1 == [element count] ) {
        return nil;
    }
    
    int startingIndex = 1;
    
    id objectAtIndex1 = [element objectAtIndex:1];
    
    // skip past the attributes if they exit
    if( [objectAtIndex1 isKindOfClass:[CAJsonObject class]] ) {
        startingIndex = 2;
    }

    for( int i = startingIndex, count = [element count]; i < count; i++ ) {
        
        id candidate = [element objectAtIndex:i];
        if( [candidate isKindOfClass:[NSString class]] ) {
            return (NSString*)candidate;
        }
    }
    
    return nil;
}

// can return nil
+(NSString*)firstTextContentFromFirstChildOfParent:(CAJsonArray*)parentElement withName:(NSString*)childsName {
    
    
    CAJsonArray* firstChild = [self firstChildOfParent:parentElement withName:childsName];
    
    if( nil == firstChild ) {
        return nil;
    }
    
    return [self firstTextContentFromElement:firstChild];
    
    
}

@end
