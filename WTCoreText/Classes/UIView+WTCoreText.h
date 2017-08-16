//
//  UIView+WTCoreText.h
//  Pods
//
//  Created by walter on 24/07/2017.
//
//

#import <UIKit/UIKit.h>

@class WTLinkData;
@class WTTextData;

@interface UIView (WTCoreText)
- (CGPoint)origin;
- (void)setOrigin:(CGPoint) point;

- (CGFloat)height;
- (void)setHeight:(CGFloat)height;

+ (WTLinkData *)touchLinkInView:(UIView *)view atPoint:(CGPoint)point data:(WTTextData *)data;
+ (CFIndex)touchContentOffsetInView:(UIView *)view atPoint:(CGPoint)point data:(WTTextData *)data;

@end
