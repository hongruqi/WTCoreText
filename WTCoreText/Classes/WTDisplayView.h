//
//  WTDisplayView.h
//  Pods
//
//  Created by walter on 24/07/2017.
//
//

#import <UIKit/UIKit.h>

@class WTTextData;
@class WTImageData;
@class WTDisplayView;
@class WTLinkData;

@protocol WTDisplayViewDelegate<NSObject>

- (void)wt_displayView:(WTDisplayView *)displayView imageDidClick:(WTImageData *)imageData;
- (void)wt_displayView:(WTDisplayView *)displayView linkDidClick:(WTLinkData *)linkData;

@end

@interface WTDisplayView : UIView

@property (nonatomic, weak) id<WTDisplayViewDelegate>delgate;

@property (nonatomic, strong) WTTextData *data;

- (void)setViewHeight:(CGFloat)height;

@end
