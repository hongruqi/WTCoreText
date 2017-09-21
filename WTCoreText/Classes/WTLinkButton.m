//
//  WTLinkButton.m
//  WTCoreText
//
//  Created by walter on 08/09/2017.
//

#import "WTLinkButton.h"
#import "WTLinkElement.h"

NSString *kWTLinkButtonDidHighlightNotification = @"kWTLinkButtonDidHighlightNotification";

@implementation WTLinkButton

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    
    return self;
}

- (id)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    
    return self;
}

- (void)setup {
    self.userInteractionEnabled = YES;
    self.enabled = YES;
    self.opaque = NO;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(highlightNotification:) name:kWTLinkButtonDidHighlightNotification object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    if (self.highlighted) {
        
        CGRect imageRect = [self contentRectForBounds:self.bounds];
        
        //        imageRect = CGRectInset(imageRect, 0, 2);
        
        UIBezierPath *roundedPath = [UIBezierPath bezierPathWithRoundedRect:imageRect cornerRadius:self.cornerRadius];
        //        CGContextSetGrayFillColor(ctx, 0.73f, 0.4f);
        //        CGContextSetRGBFillColor(ctx, 0.2, 0.2, 0.7, 0.7);
        CGContextSetFillColorWithColor(ctx, self.highlightColor.CGColor);
        [roundedPath fill];
    }
}

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    [self setNeedsDisplay];
    
    // notify other parts of the same link
    if (_element) {
        NSDictionary *userInfo = @{@"Highlighted" : @(highlighted), @"ELEMENT" : _element};
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kWTLinkButtonDidHighlightNotification object:self userInfo:userInfo];
    }
}

- (void)highlightNotification:(NSNotification *)notification {
    if ([notification object] == self) {
        // that was me
        return;
    }
    
    NSDictionary *userInfo = [notification userInfo];
    
    WTLinkElement *element = userInfo[@"ELEMENT"];
    
    if ([element isEqual:_element]) {
        BOOL highlighted = [userInfo[@"Highlighted"] boolValue];
        [super setHighlighted:highlighted];
        [self setNeedsDisplay];
    }
}

@end
