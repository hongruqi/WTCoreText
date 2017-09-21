//
//  WTCoreTextConstants.h
//  WTCoreText
//
//  Created by walter on 08/09/2017.
//

#define UNICODE_OBJECT_PLACEHOLDER @"\ufffc"

// 通用的属性字符串key

extern NSString *const kWTDefaultFont; // 值为UIFont
extern NSString *const kWTDefaultTextColor; // 值为UIColor
extern NSString *const kWTDefaultLinkColor; // 值为UIColor

// 自定义的属性字符串key

extern NSString *const kWTTextAttachment;

extern NSString *const kWTElementAttachmentName;

extern NSString *const kWTExtraElementName;

extern NSString *const kWTElementName;

extern NSString *const kWTImageElementName;
extern NSString *const kWTLinkElementName;
extern NSString *const kWTFaceElementName;

extern NSString *const kWTMaxWidth; // 定义绘制的时候，最大的宽度



// 内部使用，外部调用者不能使用
extern NSString *const kWTDefaultFont_CT; // CTFontRef
