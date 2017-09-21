//
//  XYLinkRun.m
//  WTCoreText
//
//  Created by walter on 08/09/2017.
//

#import "WTLinkRun.h"
#import "WTLine.h"
#import "WTLinkElement.h"
#import "WTElementAttachment.h"
#import "WTRichTextView.h"

@implementation WTLinkRun

- (void)renderInView:(WTRichTextView *)view context:(CGContextRef)context {
    
    //    CGFloat positionY = self.origin.y + self.line.descent + self.leading;
    
    CGFloat ascentOffset = 0;
    
    //    CGContextSetTextPosition(context, self.line.origin.x, positionY + ascentOffset);
    
    //    CTRunDraw(self.run, context, CFRangeMake(0, 0));
    
    WTElement *element = self.attachment.originElement;
    
    if ([element isKindOfClass:[WTLinkElement class]]) {
        
        WTLinkElement *linkElement = (WTLinkElement *) element;
        
        CGRect frameForSubview = CGRectMake(self.origin.x, view.frame.size.height - self.origin.y - self.size.height - ascentOffset, self.size.width, self.size.height);
        
        frameForSubview = CGRectIntegral(frameForSubview);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            UIView *existingView = [view.delegate viewForElement:linkElement];
            existingView.frame = frameForSubview;
            
            if (existingView) {
                [view addSubview:existingView];
            }
        });
    }
}
@end
