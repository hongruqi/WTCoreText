//
//  XYRun.h
//  WTCoreText
//
//  Created by walter on 08/09/2017.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>

@class WTLine;
@class WTElementAttachment;
@class WTRichTextView;

@interface WTRun : NSObject

@property (nonatomic, weak) WTLine *line;

@property (nonatomic, assign) CTRunRef run;

@property (nonatomic, assign) CGPoint origin;

@property (nonatomic, assign) CGFloat ascent;

@property (nonatomic, assign) CGFloat descent;

@property (nonatomic, assign) CGFloat leading;

@property (nonatomic, assign) CGSize size;

@property (nonatomic, strong) WTElementAttachment *attachment;

- (void)renderInView:(WTRichTextView *)view context:(CGContextRef)context;

- (id)initWithLine:(WTLine *)line run:(CTRunRef)run attachment:(WTElementAttachment *)attachment;


@end
