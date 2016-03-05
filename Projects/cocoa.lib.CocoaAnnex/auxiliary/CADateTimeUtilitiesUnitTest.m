// Copyright (c) 2013 Richard Long & HexBeerium
//
// Released under the MIT license ( http://opensource.org/licenses/MIT )
//

#import "CALog.h"
#import "CADateTimeUtilities.h"
#import "CADateTimeUtilitiesUnitTest.h"

@implementation CADateTimeUtilitiesUnitTest


static NSCalendar *gregorianCalendar;

+(void)initialize {
	gregorianCalendar =  [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
}

-(NSInteger)yearFromDate:(NSDate*)date {
	
	NSDateComponents *comps = [gregorianCalendar components:NSCalendarUnitYear fromDate:date];
	return [comps year];
}


-(NSInteger)monthFromDate:(NSDate*)date {
	
	NSDateComponents *comps = [gregorianCalendar components:NSCalendarUnitMonth fromDate:date];
	return [comps month];
}

-(NSInteger)daysFromDate:(NSDate*)date {
	NSDateComponents *comps = [gregorianCalendar components:NSCalendarUnitDay fromDate:date];
	return [comps day];
}


-(NSInteger)hoursFromDate:(NSDate*)date {
	NSDateComponents *comps = [gregorianCalendar components:NSCalendarUnitHour fromDate:date];
	return [comps hour];
}

-(NSInteger)minutesFromDate:(NSDate*)date {
	NSDateComponents *comps = [gregorianCalendar components:NSCalendarUnitMinute fromDate:date];
	return [comps minute];
}


-(NSInteger)secondsFromDate:(NSDate*)date {
	NSDateComponents *comps = [gregorianCalendar components:NSCalendarUnitSecond fromDate:date];
	return [comps second];
}



-(void)validateDate:(NSDate*)date {

	XCTAssertTrue( nil != date, @"actual = %p", date );

	NSInteger year = [self yearFromDate:date];
	XCTAssertTrue( 1998 == year, @"actual = %ld", year );
	
	NSInteger month = [self monthFromDate:date];
	XCTAssertTrue( 7 == month, @"actual = %ld", month );
	
	NSInteger days = [self daysFromDate:date];
	XCTAssertTrue( 17 == days, @"actual = %ld", days );
	
	NSInteger hours = [self hoursFromDate:date];
	XCTAssertTrue( 14 == hours, @"actual = %ld", hours );

	NSInteger minutes = [self minutesFromDate:date];
	XCTAssertTrue( 8 == minutes, @"actual = %ld", minutes );
	
	NSInteger seconds = [self secondsFromDate:date];
	XCTAssertTrue( 55 == seconds, @"actual = %ld", seconds );
	
}

-(void)testParseDateFromString {
	
	NSDate* date = [CADateTimeUtilities parseDateFromString:@"1998-07-17T14:08:55"];
	[self validateDate:date];
	
	date = [CADateTimeUtilities parseDateFromString:@"19980717T14:08:55"];
	[self validateDate:date];

	date = [CADateTimeUtilities parseDateFromString:@"1998-07-17T140855"];
	[self validateDate:date];

	date = [CADateTimeUtilities parseDateFromString:@"19980717T140855"];
	[self validateDate:date];

	if( NO ) { // dateFormatter4 will parse an empty string a 1970-01-01:00:00:00
		@try {  
			NSDate* date = [CADateTimeUtilities parseDateFromString:@""];
			XCTFail( @"Exception should have been thrown" );
			[self validateDate:date];
		}
		@catch (NSException * e) {
			// good 
		}
	}
	
}

-(void)testIso8601RepresentationOfDate {

	NSDate* date = [CADateTimeUtilities parseDateFromString:@"19980717T14:08:55"];
	[self validateDate:date];

	NSString* iso8601Representation = [CADateTimeUtilities iso8601RepresentationOfDate:date];
	XCTAssertTrue( [@"1998-07-17T14:08:55" isEqualToString:iso8601Representation], @"actual = %@", iso8601Representation );
}
@end
