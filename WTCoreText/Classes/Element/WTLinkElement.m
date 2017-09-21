//
//  WTLinkElement.m
//  WTCoreText
//
//  Created by walter on 08/09/2017.
//

#import "WTLinkElement.h"
#import "WTLinkRun.h"

@implementation WTLinkElement

+ (id)elementWithLinkText:(NSString *)linkText {
    
    WTLinkElement *element = [[WTLinkElement alloc] init];
    element.linkText = linkText;
    element.text = linkText;
    element.GUID = [self stringWithUUID];
    
    return element;
}

+ (NSString *)stringWithUUID {
    CFUUIDRef uuidObj = CFUUIDCreate(nil);//create a new UUID
    
    //get the string representation of the UUID
    NSString *uuidString = (__bridge_transfer NSString *) CFUUIDCreateString(nil, uuidObj);
    
    CFRelease(uuidObj);
    return uuidString;
}

+ (Class)glyphRunClass {
    return [WTLinkRun class];
}

+ (id)elementWithLinkString:(NSString *)string {
    WTLinkElement *element = [[WTLinkElement alloc] init];
    element.linkString = string;
    return element;
}

@end
