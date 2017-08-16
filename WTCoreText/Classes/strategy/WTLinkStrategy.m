//
//  WTLinkStrategy.m
//  Pods
//
//  Created by walter on 24/07/2017.
//
//

#import "WTLinkStrategy.h"
#import <CoreText/CoreText.h>

@implementation WTLinkStrategy

- (NSAttributedString *)parseDataFromNSDictionary:(NSDictionary *)dict config:(WTDataConfig *)config
{
    NSMutableDictionary *attributes = [self attributesWithConfig:config];
    // set color
    UIColor *color = [WTStrategy colorFromTemplate:dict[@"color"]];
    if (color) {
        attributes[(id)kCTForegroundColorAttributeName] = (id)color.CGColor;
    }
    // set font size
    CGFloat fontSize = [dict[@"size"] floatValue];
    if (fontSize > 0) {
        CTFontRef fontRef = CTFontCreateWithName((CFStringRef)@"ArialMT", fontSize, NULL);
        attributes[(id)kCTFontAttributeName] = (__bridge id)fontRef;
        CFRelease(fontRef);
    }
    NSString *content = dict[@"content"];
    return [[NSAttributedString alloc] initWithString:content attributes:attributes];
}
@end
