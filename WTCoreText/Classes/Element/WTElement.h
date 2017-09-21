//
//  WTElement.h
//  WTCoreText
//
//  Created by walter on 08/09/2017.
//

#import <Foundation/Foundation.h>

@class WTRichTextView;
@class WTElementAttachment;
@class WTElementAttribute;

@interface WTElement : NSObject
/*
 纯文本的内容
 */
@property (nonatomic, copy) NSString *text;

@property (nonatomic, assign) NSRange range;
/*
 用于描述
 */
@property (nonatomic, strong) WTElementAttribute *attribute;

+ (Class)glyphRunClass;

- (void)addSubElementAttribute:(WTElementAttribute *)attribute;

/*
 生成属性的字符串
 */
- (NSAttributedString *)generateAttributeString:(NSDictionary *)dictionary;

/*
 子类做额外的装饰处理
 */
- (void)decorateSubAttributes:(NSMutableAttributedString *)attributedString attachment:(WTElementAttachment *)attachment;

- (void)resetForBuild;
@end
