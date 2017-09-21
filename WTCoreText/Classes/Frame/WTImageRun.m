//
//  XYImageRun.m
//  WTCoreText
//
//  Created by walter on 08/09/2017.
//

#import "WTImageRun.h"
#import "WTElementAttachment.h"
#import "WTImageElement.h"
#import "WTRichTextView.h"

@implementation WTImageRun

- (void)renderInView:(WTRichTextView *)view context:(CGContextRef)context {
    
    WTImageElement *element = (WTImageElement *) self.attachment.originElement;
    
    CGRect frameForSubview = CGRectMake(self.origin.x, view.frame.size.height - self.origin.y - self.size.height, self.size.width, self.size.height);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        UIView *existingView = [view.delegate viewForElement:element];
        
        existingView.frame = frameForSubview;
        
        if (existingView) {
            [view addSubview:existingView];
            [existingView setNeedsDisplay];
        }
    });
}
@end
