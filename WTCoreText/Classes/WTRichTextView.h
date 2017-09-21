//
//  WTRichTextView.h
//  WTCoreText
//
//  Created by walter on 08/09/2017.
//

#import <UIKit/UIKit.h>

@class WTDocument;
@class WTElement;

@protocol WTRichTextViewDelegate <NSObject>

@optional

- (UIView *)viewForElement:(WTElement *)element;

@end

/*
 用于显示WTDocument的view
 */
@interface WTRichTextView : UIView

@property (nonatomic, weak) id <WTRichTextViewDelegate> delegate;

- (void)drawView;

- (void)setRichText:(NSString *)richText;

- (void)build;

- (CGFloat)viewHeight;

@end
