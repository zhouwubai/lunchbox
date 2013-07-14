//
//  SHA1.m
//  Uslunchbox
//
//  Created by wubai zhou on 7/14/13.
//  Copyright (c) 2013 wubai zhou. All rights reserved.
//

#import "SHA1.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation SHA1

-(NSString *)stringToSha1:(NSString *) str
{
    const char *cstr = [str cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:str.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, data.length, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH];
    
    for(int i=0; i < CC_SHA1_DIGEST_LENGTH;i++)
        [output appendFormat:@"%02x",digest[i]];
    
    return output;
    
}

@end
