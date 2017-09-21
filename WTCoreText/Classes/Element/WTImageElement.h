//
//  WTImageElement.h
//  WTCoreText
//
//  Created by walter on 08/09/2017.
//

#import <CoreText/CoreText.h>
#import "WTElement.h"

typedef NS_ENUM(NSUInteger, WTImageElementDownloadStatus) {
    WTImageElementDownloadStatus_None = 0,
    WTImageElementDownloadStatus_Downloading = 1,
    WTImageElementDownloadStatus_Success = 2,
    WTImageElementDownloadStatus_Failed = 3
};

/*
 用于保存图片的的源数据
 */
@interface WTImageElement : WTElement

/*
 图片的key
 */
@property (nonatomic, assign) NSString                     *key;

@property (nonatomic, assign) CGSize                       maxSize;

@property (nonatomic, strong) UIImage                      *image;

@property (nonatomic, assign) WTImageElementDownloadStatus downloadStatus;

@property (nonatomic, assign) CGSize                       entitySize;

@property (nonatomic, strong) NSString                     *imageName;

+ (id)elementWithKey:(NSString *)key isGif:(BOOL)isGif maxSize:(CGSize)maxSize;

+ (id)elementWithImageName:(NSString *)imageName maxSize:(CGSize)maxSize;

- (void)reset;

@end
