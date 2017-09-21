//
//  WTDocument.h
//  WTCoreText
//
//  Created by walter on 08/09/2017.
//

#import <Foundation/Foundation.h>

@class WTElement;
@class WTFrame;
@class WTAttributedStringBuilder;
@class WTElementAttribute;

/*
 代表富文本的文档模型，通过这个模型来构建view
 */
@interface WTDocument : NSObject

@property (nonatomic, strong) WTFrame *frame;

@property (nonatomic, strong) NSMutableArray *childElements;

@property (nonatomic, strong) WTAttributedStringBuilder *builder;

/*
 这个针对的是全局
 */
@property (nonatomic, strong) WTElementAttribute *attribute;

@property (nonatomic, assign) NSUInteger numberOfLines;

- (void)addElement:(WTElement *)element;

- (CGSize)size;

- (void)build;
@end
