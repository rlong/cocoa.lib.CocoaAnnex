//
//  CAJsonMlHelper.h
//  jsonbroker
//
//  Created by rlong on 1/04/2014.
//
//

#import <Foundation/Foundation.h>

#import "CAJsonArray.h"

@interface CAJsonMlHelper : NSObject


+(CAJsonArray*)buildWithContentsOfData:(NSData*)data;

+(CAJsonArray*)buildWithContentsOfURL:(NSURL *)url;

+(NSArray*)allChildrenOfParent:(CAJsonArray*)parentElement withName:(NSString*)elementName;

// can return nil
+(NSString*)attributeOfElement:(CAJsonArray*)element withName:(NSString*)attributeName;

// can return nil
+(CAJsonArray*)firstChildOfParent:(CAJsonArray*)parentElement withName:(NSString*)elementName;

// can return nil
+(NSString*)firstTextContentFromElement:(CAJsonArray*)element;

// can return nil
+(NSString*)firstTextContentFromFirstChildOfParent:(CAJsonArray*)parentElement withName:(NSString*)childsName;

@end
