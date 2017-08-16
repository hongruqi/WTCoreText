//
//  WTClient.m
//  Pods
//
//  Created by walter on 24/07/2017.
//
//

#import "WTClient.h"
#import "WTTextData.h"
#import "WTDataConfig.h"
#import "WTContext.h"
#import "WTTextStrategy.h"
#import "WTImageData.h"
#import "WTImageStrategy.h"
#import "WTLinkData.h"

@implementation WTClient

+ (WTTextData *)parseContentsWithArray:(NSArray *)contents config:(WTDataConfig *)config
{
    NSMutableArray *imageArray = [NSMutableArray array];
    NSMutableArray *linkArray = [NSMutableArray array];
    NSAttributedString *content = [self parseContents:contents config:config imageArray:imageArray linkArray:linkArray];
    WTTextData *data = [self parseAttributedContent:content config:config];
    data.imageArray = imageArray;
    data.linkArray = linkArray;
    return data;
}


+ (NSAttributedString *)parseContents:(NSArray *)contents
                               config:(WTDataConfig *)config
                           imageArray:(NSMutableArray *)imageArray
                            linkArray:(NSMutableArray *)linkArray
{
    NSMutableAttributedString *result = [[NSMutableAttributedString alloc] init];
    
    if ([contents isKindOfClass:[NSArray class]]) {
        for (NSDictionary *dict in contents) {
            NSString *type = dict[@"type"];
            if ([type isEqualToString:@"txt"]) {
                WTContext *context = [[WTContext alloc] initWithStrategy:[WTTextStrategy new]];
                NSAttributedString *as = [context executeParserWithDict:dict config:config];
                
                [result appendAttributedString:as];
            } else if ([type isEqualToString:@"img"]) {
                // 创建 CoreTextImageData
                WTImageData *imageData = [[WTImageData alloc] init];
                imageData.name = dict[@"name"];
                imageData.position = [result length];
                [imageArray addObject:imageData];
                // 创建空白占位符，并且设置它的CTRunDelegate信息
                WTContext *context = [[WTContext alloc] initWithStrategy:[WTImageStrategy new]];
                NSAttributedString *as = [context executeParserWithDict:dict config:config];
                [result appendAttributedString:as];
            } else if ([type isEqualToString:@"link"]) {
                NSUInteger startPos = result.length;
                WTContext *context = [[WTContext alloc] initWithStrategy:[WTTextStrategy new]];
                NSAttributedString *as = [context executeParserWithDict:dict config:config];
                [result appendAttributedString:as];
                // 创建 WTLinkData
                NSUInteger length = result.length - startPos;
                NSRange linkRange = NSMakeRange(startPos, length);
                WTLinkData *linkData = [[WTLinkData alloc] init];
                linkData.title = dict[@"content"];
                linkData.url = dict[@"url"];
                linkData.range = linkRange;
                [linkArray addObject:linkData];
            }
        }
    }
    
    return result;
}

+ (WTTextData *)parseContent:(NSString *)content config:(WTDataConfig*)config
{
    NSDictionary *attributes = [self attributesWithConfig:config];
    NSAttributedString *contentString = [[NSAttributedString alloc] initWithString:content
                                                                        attributes:attributes];
    return [self parseAttributedContent:contentString config:config];
}

+ (WTTextData *)parseAttributedContent:(NSAttributedString *)content config:(WTDataConfig*)config {
    // 创建CTFramesetterRef实例
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)content);
    
    // 获得要缓制的区域的高度
    CGSize restrictSize = CGSizeMake(config.width, CGFLOAT_MAX);
    CGSize coreTextSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0,0), nil, restrictSize, nil);
    CGFloat textHeight = coreTextSize.height;
    
    // 生成CTFrameRef实例
    CTFrameRef frame = [self createFrameWithFramesetter:framesetter config:config height:textHeight];
    
    // 将生成好的CTFrameRef实例和计算好的缓制高度保存到CoreTextData实例中，最后返回CoreTextData实例
    WTTextData *data = [[WTTextData alloc] init];
    data.ctFrame = frame;
    data.height = textHeight;
    data.content = content;
    
    // 释放内存
    CFRelease(frame);
    CFRelease(framesetter);
    return data;
}

+ (CTFrameRef)createFrameWithFramesetter:(CTFramesetterRef)framesetter
                                  config:(WTDataConfig *)config
                                  height:(CGFloat)height
{
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0, 0, config.width, height));
    
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
    CFRelease(path);
    return frame;
}

+ (NSMutableDictionary *)attributesWithConfig:(WTDataConfig *)config
{
    CGFloat fontSize = config.fontSize;
    CTFontRef fontRef = CTFontCreateWithName((CFStringRef)@"ArialMT", fontSize, NULL);
    CGFloat lineSpacing = config.lineSpace;
    const CFIndex kNumberOfSettings = 3;
    CTParagraphStyleSetting theSettings[kNumberOfSettings] = {
        { kCTParagraphStyleSpecifierLineSpacingAdjustment, sizeof(CGFloat), &lineSpacing },
        { kCTParagraphStyleSpecifierMaximumLineSpacing, sizeof(CGFloat), &lineSpacing },
        { kCTParagraphStyleSpecifierMinimumLineSpacing, sizeof(CGFloat), &lineSpacing }
    };
    
    CTParagraphStyleRef theParagraphRef = CTParagraphStyleCreate(theSettings, kNumberOfSettings);
    
    UIColor * textColor = config.textColor;
    
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[(id)kCTForegroundColorAttributeName] = (id)textColor.CGColor;
    dict[(id)kCTFontAttributeName] = (__bridge id)fontRef;
    dict[(id)kCTParagraphStyleAttributeName] = (__bridge id)theParagraphRef;
    
    CFRelease(theParagraphRef);
    CFRelease(fontRef);
    return dict;
}

@end
