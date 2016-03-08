// Copyright (c) 2013 Richard Long & HexBeerium
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//


#import "CAHostName_Generated.h"
#import "CAJsonObject.h"


////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

@interface CAHostName_Generated ()

@end

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

@implementation CAHostName_Generated 


-(CAJsonObject*)toJsonObject {
	CAJsonObject* answer = [[CAJsonObject alloc] init];
	[answer setObject:_applicationName forKey:@"application_name"];
	[answer setObject:_zeroconfName forKey:@"zeroconf_name"];
	[answer setObject:_dnsName forKey:@"dns_name"];
	return answer;
    
}

#pragma mark -
#pragma mark instance lifecycle

-(id)init {
	return [super init];
}

-(id)initWithJsonObject:(CAJsonObject*)jsonObject {
	
	CAHostName_Generated* answer = [super init];
	
	[answer setApplicationName:[jsonObject stringForKey:@"application_name" defaultValue:nil]];
	[answer setZeroconfName:[jsonObject stringForKey:@"zeroconf_name" defaultValue:nil]];
	[answer setDnsName:[jsonObject stringForKey:@"dns_name" defaultValue:nil]];
	
	
	
	return answer;
	
}


-(void)dealloc {
    
	[self setApplicationName:nil];
	[self setZeroconfName:nil];
	[self setDnsName:nil];
    
    
}

#pragma mark -
#pragma mark fields


//////////////////////////////////////////////////////
// applicationName
//NSString* _applicationName;
//@property (nonatomic, retain) NSString* applicationName;
@synthesize applicationName = _applicationName;

//////////////////////////////////////////////////////
// zeroconfName
//NSString* _zeroconfName;
//@property (nonatomic, retain) NSString* zeroconfName;
@synthesize zeroconfName = _zeroconfName;

//////////////////////////////////////////////////////
// dnsName
//NSString* _dnsName;
//@property (nonatomic, retain) NSString* dnsName;
@synthesize dnsName = _dnsName;

@end
