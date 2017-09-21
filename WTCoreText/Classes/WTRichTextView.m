//
//  WTRichTextView.m
//  WTCoreText
//
//  Created by walter on 08/09/2017.
//

#import "WTRichTextView.h"
#import "WTFrame.h"
#import "WTLine.h"
#import "WTRun.h"
#import "WTDocument.h"
#import "WTRichTextParse.h"
#import "WTAttributedStringBuilder.h"
#import "WTElementAttribute.h"
#import "WTDocument.h"

@interface WTRichTextView()

@property (nonatomic, strong) WTDocument *document;

@property (nonatomic, strong) NSString *text;

@end

@implementation WTRichTextView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.document = [[WTDocument alloc] init];
    }
    
    return self;
}

- (id)init {
    self = [super init];
    if (self) {
        self.document = [[WTDocument alloc] init];
    }
    
    return self;
}

- (void)setup {
    
    CATiledLayer *tiledLayer = (CATiledLayer *) self.layer;
    
    UIScreen *mainScreen = [UIScreen mainScreen];
    CGFloat largerDimension = MAX(mainScreen.applicationFrame.size.width, mainScreen.applicationFrame.size.height);
    CGFloat scale = mainScreen.scale;
    
    // this way tiles cover entire screen regardless of orientation or scale
    CGSize tileSize = CGSizeMake(largerDimension * scale, largerDimension * scale);
    
    tiledLayer.tileSize = tileSize;
}

- (void)drawRect:(CGRect)rect_ {

    dispatch_async(dispatch_get_main_queue(), ^{
        for (UIView *customView in self.subviews) {
            [customView removeFromSuperview];
        }
    });

    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGRect rect = CGContextGetClipBoundingBox(ctx);

    CGContextRef context = ctx;
    CGContextClearRect(context, rect);

    CGAffineTransform transform = [self transformForCoreText];
    CGContextConcatCTM(context, transform);

    WTFrame *frame = self.document.frame;
    NSArray *lines = frame.lines;

    for (WTLine *line in lines) {
        NSArray *runs = line.runs;
        for (WTRun *run in runs) {
            [run renderInView:self context:context];
        }
    }

}

- (void)drawView
{
//    self.document.childElements = [WTRichTextParse parseRichText:self.text];
//    self.document.builder = [[XYAttributedStringBuilder alloc] initWithDocument:self.document size:CGSizeMake([UIScreen mainScreen].bounds.size.width, 5000)];
//    WTElementAttribute *attribute = [[WTElementAttribute alloc] init];
//    attribute.font = [UIFont fontWithName:@"Helvetica" size:14];
////    attribute.textColor = RGBCOLOR(94.0, 180.0, 67.0);
//    attribute.maximunLineSpacing = 6;
//    attribute.minimunLineSpacing = 6;
//    self.document.attribute = attribute;
//    [self.document build];
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.document.size.height);
    [self setNeedsLayout];
    [self setNeedsDisplay];
}

- (void)setRichText:(NSString *)richText
{
    self.text = richText;
}

- (void)build
{
    self.document.childElements = [WTRichTextParse parseRichText:self.text];
    self.document.builder = [[WTAttributedStringBuilder alloc] initWithDocument:self.document size:CGSizeMake([UIScreen mainScreen].bounds.size.width, 5000)];
    WTElementAttribute *attribute = [[WTElementAttribute alloc] init];
    attribute.font = [UIFont fontWithName:@"Helvetica" size:14];
    //    attribute.textColor = RGBCOLOR(94.0, 180.0, 67.0);
    attribute.maximunLineSpacing = 6;
    attribute.minimunLineSpacing = 6;
    self.document.attribute = attribute;
    [self.document build];
}

- (CGFloat)viewHeight
{

    return self.document.size.height;
}

- (CGAffineTransform)transformForCoreText {
    // CoreText context coordinates are the opposite to UIKit so we flip the bounds
    return CGAffineTransformScale(CGAffineTransformMakeTranslation(0, self.bounds.size.height), 1.f, -1.f);
}

@end
