//
//  WTDocument.m
//  WTCoreText
//
//  Created by walter on 08/09/2017.
//

#import "WTDocument.h"
#import "WTElement.h"
#import "WTFrame.h"
#import "WTElementAttribute.h"
#import "WTAttributedStringBuilder.h"

@implementation WTDocument

- (void)addElement:(WTElement *)element {
    
    if (!element) {
        return;
    }
    
    [self.childElements addObject:element];
    
}

- (CGSize)size {
    
    return self.frame.size;
}

- (void)build {
    
    NSDictionary *attributes = [self.attribute generateCoreTextAttributes];
    
    self.frame = [self.builder createFrame:attributes withNumberOfLines:self.numberOfLines];
}

@end
