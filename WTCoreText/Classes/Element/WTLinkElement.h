//
//  WTLinkElement.h
//  WTCoreText
//
//  Created by walter on 08/09/2017.
//

#import <UIKit/UIKit.h>
#import "WTElement.h"

@interface WTLinkElement : WTElement

@property (nonatomic, copy) NSString *linkText;

@property (nonatomic, copy) NSString *GUID;

@property (nonatomic, copy) NSString *linkString;


+ (id)elementWithLinkText:(NSString *)linkText;

+ (id)elementWithLinkString:(NSString *)string;


@end
