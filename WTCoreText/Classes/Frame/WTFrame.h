//
//  WTFrame.h
//  WTCoreText
//
//  Created by walter on 08/09/2017.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>

@interface WTFrame : NSObject
/*
 该Frame所包含的 WTLine
 */
@property (nonatomic, strong) NSArray *lines;

/*
 该Frame所对应的要显示内容所需要的大小
 */
@property (nonatomic, assign) CGSize  size;

/*
 用于保存属性的字符串
 */
@property (nonatomic, strong) NSAttributedString *attributedString;

- (id)initWithAttributeString:(NSAttributedString *)attributedString size:(CGSize)size numberOfLines:(NSUInteger)numberOfLines;

@end
