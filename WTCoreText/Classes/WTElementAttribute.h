//
//  WTElementAttribute.h
//  WTCoreText
//
//  Created by walter on 08/09/2017.
//

#import <Foundation/Foundation.h>

@interface WTElementAttribute : NSObject

@property (nonatomic, assign) NSRange  range;

@property (nonatomic, strong) UIFont   *font;

@property (nonatomic, strong) UIColor  *textColor;

@property (nonatomic, assign) NSNumber *underLineStyle;

///////////////////////////////////////////////////
// 段落相关的属性

@property (nonatomic, assign) CGFloat  minimunLineSpacing;

@property (nonatomic, assign) CGFloat  maximunLineSpacing;

@property (nonatomic, assign) CTLineBreakMode   lineBreakMode;

@property (nonatomic, assign) CGFloat  lineAdjustment;

- (NSDictionary *)generateCoreTextAttributes;

@end
