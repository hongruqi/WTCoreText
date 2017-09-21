//
//  WTTextElement.m
//  WTCoreText
//
//  Created by walter on 08/09/2017.
//

#import "WTTextElement.h"
#import "WTLinkElement.h"
#import "WTElementAttachment.h"
#import "WTTextRun.h"
#import "WTCoreTextConstants.h"
#import "WTElementAttribute.h"

@implementation WTTextElement

+ (Class)glyphRunClass {
    
    return [WTTextRun class];
}

+ (id)elementWithText:(NSString *)text {
    
    WTTextElement *element = [[WTTextElement alloc] init];
    element.text = text;
    
    return element;
}

- (void)decorateSubAttributes:(NSMutableAttributedString *)attributedString attachment:(WTElementAttachment *)attachment {
    
    self.linkElementArray = [NSMutableArray array];
    
    NSError *error = nil;
    NSTextCheckingType dataDetectorTypes = NSTextCheckingTypeLink | NSTextCheckingTypePhoneNumber;
    NSDataDetector *linkDetector = [NSDataDetector dataDetectorWithTypes:(NSTextCheckingTypes) dataDetectorTypes
                                                                   error:&error];
    NSArray *results = [linkDetector matchesInString:attributedString.string options:0 range:NSMakeRange(0, attributedString.length)];
    if (results.count) {
        
        for (NSTextCheckingResult *result in results) {
            
            WTLinkElement *element = nil;
            
            if (result.resultType == NSTextCheckingTypeLink) {
                element = [WTLinkElement elementWithLinkText:[result.URL absoluteString]];
            } else {
                element = [WTLinkElement elementWithLinkString:result.phoneNumber];
            }
            
            WTElementAttribute *decorater = [[WTElementAttribute alloc] init];
            decorater.textColor = [UIColor blueColor];
            decorater.underLineStyle = @(kCTUnderlinePatternSolid | kCTUnderlineStyleSingle);
            decorater.maximunLineSpacing = 6;
            decorater.minimunLineSpacing = 6;
            decorater.range = result.range;
            
            [self addSubElementAttribute:decorater];
            [self.linkElementArray addObject:element];
            
            attachment.hasExtraElement = YES;
            
            [attributedString addAttribute:kWTExtraElementName value:element range:result.range];
        }
    }
    
}
@end
