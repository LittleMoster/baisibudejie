//
//  UTF-8&Unicode.m
//  百思不得姐
//
//  Created by cguo on 2017/4/27.
//  Copyright © 2017年 ZJQ. All rights reserved.
//

#import "UTF-8&Unicode.h"

@implementation UTF_8_Unicode


//Unicode转UTF-8

+ (NSString *)encodeToPercentEscapeString: (NSString *) input

{
    
    // Encode all the reserved characters, per RFC 3986
    
    // (<http://www.ietf.org/rfc/rfc3986.txt>)
    
    NSString *outputStr = (NSString *)
    
    CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                            
                                            (CFStringRef)input,
                                            
                                            NULL,
                                            
                                            (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                            
                                            kCFStringEncodingUTF8);  
    
    return outputStr;  
    
}
+ (NSString *)decodeFromPercentEscapeString: (NSString *) input

{
    
    NSMutableString *outputStr = [NSMutableString stringWithString:input];
    
    [outputStr replaceOccurrencesOfString:@"+"
     
                               withString:@" "
     
                                  options:NSLiteralSearch
     
                                    range:NSMakeRange(0, [outputStr length])];
    
    
    
    return [outputStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
}
//Unicode转UTF-8

+ (NSString*) replaceUnicode:(NSString*)aUnicodeString

{
    
    NSString *tempStr1 = [aUnicodeString stringByReplacingOccurrencesOfString:@"\\u" withString:@"\\U"];
    
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    
    NSString *tempStr3 = [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                           
                                                           mutabilityOption:NSPropertyListImmutable
                           
                                                                     format:NULL
                           
                                                           errorDescription:NULL];
    
    
    
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n" withString:@"\n"]; 
    
}
@end
