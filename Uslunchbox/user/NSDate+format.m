//
//  NSDate+format.m
//  Uslunchbox
//
//  Created by Wubai Zhou on 9/4/13.
//  Copyright (c) 2013 wubai zhou. All rights reserved.
//

#import "NSDate+format.h"

@implementation NSDate (format)


+(NSString *)formatWeekDate:(NSDate *)date ToFormat:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    
    return [formatter stringFromDate:date];
}

@end
