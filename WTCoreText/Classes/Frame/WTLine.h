//
//  WTLine.h
//  WTCoreText
//
//  Created by walter on 08/09/2017.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>

@class WTFrame;

@interface WTLine : NSObject

@property (nonatomic, weak)     WTFrame    *frame;

/*
 该line所包含的 XYRun
 */
@property (nonatomic, strong)   NSArray    *runs;

/*
 The text attachments occuring in glyph runs of the receiver.
 */
@property (nonatomic, readonly) NSArray    *attachments;

@property (nonatomic)           CGFloat    ascent;

@property (nonatomic)           CGFloat    descent;

@property (nonatomic)           CGFloat    leading;

@property (nonatomic, assign)   CGPoint    origin;

@property (nonatomic, assign)   CGSize     size;

@property (nonatomic, assign)   CTLineRef  ctLine;

- (id)initWithFrame:(WTFrame *)frame line:(CTLineRef)line lineOrigin:(CGPoint)origin;

@end
