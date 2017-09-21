//
//  WTElementAttachment.h
//  WTCoreText
//
//  Created by walter on 08/09/2017.
//

#import <Foundation/Foundation.h>

@class WTElement;

@interface WTElementAttachment : NSObject

@property (nonatomic, weak) WTElement *originElement;
@property (nonatomic, assign) BOOL hasExtraElement;

- (void)addAttachElement:(WTElement *)element;

- (id)initWithOriginElement:(WTElement *)element;

@end
