//
//  WTImageElement.m
//  WTCoreText
//
//  Created by walter on 08/09/2017.
//

#import "WTImageElement.h"
#import "WTImageRun.h"
#import "WTCoreTextConstants.h"

CGFloat XYImageRunDelegateAscentCallback(void *refCon) {
    
    WTImageElement *element = (__bridge WTImageElement *) refCon;
    
    CGFloat ascent = MIN(element.entitySize.height, element.maxSize.height);
    
    return ascent;
}

CGFloat XYImageRunDelegateDscentCallback(void *refCon) {
    
    return 0;
}

CGFloat XYImageRunDelegateWidthCallback(void *refCon) {
    
    WTImageElement *element = (__bridge WTImageElement *) refCon;
    CGFloat width = 0;
    
    if ([element isKindOfClass:[WTImageElement class]]) {
        width = MIN(element.entitySize.width, element.maxSize.width);
    }
    
    return width;
}

@implementation WTImageElement

+ (Class)glyphRunClass {
    
    return [WTImageRun class];
}

- (void)setDownloadStatus:(WTImageElementDownloadStatus)downloadStatus {
    
    _downloadStatus = downloadStatus;
    self.image = nil;
}

+ (id)elementWithKey:(NSString *)key isGif:(BOOL)isGif maxSize:(CGSize)maxSize {
    
    WTImageElement *element = [[WTImageElement alloc] init];
    
    element.key = key;
    element.text = UNICODE_OBJECT_PLACEHOLDER;
    element.maxSize = maxSize;
    
    [element reset];
    
    return element;
}

+ (id)elementWithImageName:(NSString *)imageName maxSize:(CGSize)maxSize{
    WTImageElement *element = [[WTImageElement alloc] init];
    element.image = [UIImage imageNamed:imageName];
    element.text = UNICODE_OBJECT_PLACEHOLDER;
    element.maxSize = maxSize;
    element.imageName = imageName;
    [element setImageSize];
    
    return  element;
}

- (void)reset {
    self.image = nil;
    
    [self setImageSize];
}

- (void)setImageSize {
    CGSize size = self.image.size;
    CGSize maxSize = self.maxSize;
    
    CGFloat newWidth = size.width;
    CGFloat newHeight = size.height;
    if (size.width > maxSize.width || size.height > maxSize.height) {
        
        double widthPercent = size.width / maxSize.width;
        double heightPercent = size.height / maxSize.height;
        
        if (widthPercent > heightPercent) {
            
            newWidth = maxSize.width;
            newHeight = (newWidth / size.width) * size.height;
        } else {
            
            newHeight = maxSize.height;
            newWidth = (newHeight / size.height) * size.width;
        }
    }
    self.entitySize = CGSizeMake(newWidth, newHeight);
}

- (UIImage *)image
{
    return [UIImage imageNamed:self.imageName];
}

- (CTRunDelegateCallbacks)createRunDelegate {
    
    // 设置CTRun的回调
    CTRunDelegateCallbacks imageCallbacks;
    memset(&imageCallbacks, 0, sizeof(CTRunDelegateCallbacks));
    imageCallbacks.version = kCTRunDelegateVersion1;
    imageCallbacks.getAscent = XYImageRunDelegateAscentCallback;
    imageCallbacks.getDescent = XYImageRunDelegateDscentCallback;
    imageCallbacks.getWidth = XYImageRunDelegateWidthCallback;
    
    return imageCallbacks;
}

- (void)decorateSubAttributes:(NSMutableAttributedString *)attributedString attachment:(WTElementAttachment *)attachment {
    
    CTRunDelegateCallbacks imageCallbacks = [self createRunDelegate];
    
    CTRunDelegateRef runDelegate = CTRunDelegateCreate(&imageCallbacks, (__bridge void *) self);
    
    [attributedString addAttribute:(NSString *) kCTRunDelegateAttributeName value:(__bridge id) runDelegate range:NSMakeRange(0, self.text.length)];
    CFRelease(runDelegate);
}

- (void)resetForBuild {
    
    [self reset];
}
@end
