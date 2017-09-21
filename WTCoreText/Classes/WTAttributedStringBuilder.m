//
//  WTAttributedStringBuilder.m
//  WTCoreText
//
//  Created by walter on 08/09/2017.
//

#import "WTAttributedStringBuilder.h"
#import "WTElement.h"
#import "WTDocument.h"
#import "WTFrame.h"

/*
 指定一个绘制时最大的高度
 */
#define kMaxHeight 5000

@interface WTAttributedStringBuilder ()

@property (nonatomic, weak)   WTDocument *document;
@property (nonatomic, strong) NSAttributedString *attributeString;
@property (nonatomic)         CGSize size;

@end

@implementation WTAttributedStringBuilder

- (id)initWithDocument:(WTDocument *)document size:(CGSize)size {
    self = [super init];
    if (self) {
        self.document = document;
        self.size = size;
    }
    
    return self;
}

- (WTFrame *)createFrame:(NSDictionary *)dictionary withNumberOfLines:(NSUInteger)numberOfLines{
    
    [self reset];
    
    NSAttributedString *attributeString = [self generateAttributeString:dictionary];
    
    WTFrame *frame = [[WTFrame alloc] initWithAttributeString:attributeString size:self.size numberOfLines:numberOfLines];
    
    return frame;
}

- (NSAttributedString *)generateAttributeString:(NSDictionary *)dictionary {
    
    if (!_attributeString) {
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:@"" attributes:dictionary];
        
        NSArray *elements = self.document.childElements;
        
        for (WTElement *element in elements) {
            
            NSAttributedString *string = [element generateAttributeString:dictionary];
            
            [attributedString appendAttributedString:string];
        }
        
        _attributeString = attributedString;
    }
    
    return _attributeString;
}

- (void)reset {
    
    NSArray *elements = self.document.childElements;
    
    for (WTElement *element in elements) {
        
        [element resetForBuild];
    }
}

@end
