//
//  WTAttributedStringBuilder.h
//  WTCoreText
//
//  Created by walter on 08/09/2017.
//

#import <Foundation/Foundation.h>
@class WTDocument;
@class WTFrame;

@interface WTAttributedStringBuilder : NSObject

- (id)initWithDocument:(WTDocument *)document size:(CGSize)size;

- (WTFrame *)createFrame:(NSDictionary *)dictionary withNumberOfLines:(NSUInteger)numberOfLines;

@end
