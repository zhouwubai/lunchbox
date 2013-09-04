//
//  NSDate+format.h
//  Uslunchbox
//
//  Created by Wubai Zhou on 9/4/13.
//  Copyright (c) 2013 wubai zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (format)
+(NSString *)formatWeekDate:(NSDate *)date ToFormat:(NSString *)format;
@end
