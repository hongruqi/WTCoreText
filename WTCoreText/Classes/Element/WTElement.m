//
//  WTElement.m
//  WTCoreText
//
//  Created by walter on 08/09/2017.
//

#import "WTElement.h"
#import "WTRun.h"
#import "WTElementAttribute.h"
#import "WTElementAttachment.h"
#import "WTCoreTextConstants.h"

@interface WTElement ()

@property (nonatomic, strong) NSAttributedString *attributeString;
@property (nonatomic, strong) NSMutableArray *subElementAttributes;

@end

@implementation WTElement


+ (Class)glyphRunClass {
    
    return [WTRun class];
}

- (void)addSubElementAttribute:(WTElementAttribute *)attribute {
    
    if (!self.subElementAttributes) {
        self.subElementAttributes = [NSMutableArray array];
    }
    
    [self.subElementAttributes addObject:attribute];
}

- (NSAttributedString *)generateAttributeString:(NSDictionary *)dictionary {
    
    if (!_attributeString) {
        
        NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:self.text attributes:dictionary];
        
        WTElementAttachment *attachment = [[WTElementAttachment alloc] initWithOriginElement:self];
        [attributeString addAttribute:kWTElementAttachmentName value:attachment range:NSMakeRange(0, attributeString.length)];
        
        if (self.attribute) {
            [attributeString addAttributes:[self.attribute generateCoreTextAttributes] range:NSMakeRange(0, attributeString.length)];
        }
        
        [self decorateSubAttributes:attributeString attachment:attachment];
        
        if (self.subElementAttributes) {
            for (WTElementAttribute *attribute in self.subElementAttributes) {
                [attributeString addAttributes:[attribute generateCoreTextAttributes] range:attribute.range];
            }
        }
        
        _attributeString = attributeString;
    }
    
    return _attributeString;
}

- (NSString *)text {
    if (!_text) {
        _text = @"";
    }
    return _text;
}

- (void)decorateSubAttributes:(NSMutableAttributedString *)attributedString attachment:(WTElementAttachment *)attachment {
    
}

- (void)resetForBuild {
}

@end
