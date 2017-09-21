//
//  WTElementAttachment.m
//  WTCoreText
//
//  Created by walter on 08/09/2017.
//

#import "WTElementAttachment.h"

@implementation WTElementAttachment


- (id)initWithOriginElement:(WTElement *)element {
    self = [super init];
    if (self) {
        self.originElement = element;
    }
    
    return self;
}

- (void)addAttachElement:(WTElement *)element
{
    return;
}

@end
