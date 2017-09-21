//
//  WTLinkButton.h
//  WTCoreText
//
//  Created by walter on 08/09/2017.
//

#import <UIKit/UIKit.h>

@class WTLinkElement;

@interface WTLinkButton : UIButton

/*
 链接的url
 */
@property (nonatomic, copy)   NSString      *url;

@property (nonatomic, strong) WTLinkElement *element;

@property (nonatomic, assign) CGFloat       cornerRadius;

@property (nonatomic, strong) UIColor       *highlightColor;

@end
