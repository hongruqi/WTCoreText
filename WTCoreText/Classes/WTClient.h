//
//  WTClient.h
//  Pods
//
//  Created by walter on 24/07/2017.
//
//

#import <Foundation/Foundation.h>

@class WTDataConfig;
@class WTTextData;

@interface WTClient : NSObject

+ (NSMutableDictionary *)attributesWithConfig:(WTDataConfig *)config;

+ (WTTextData *)parseContent:(NSString *)content config:(WTDataConfig*)config;

+ (WTTextData *)parseAttributedContent:(NSAttributedString *)content config:(WTDataConfig*)config;

+ (WTTextData *)parseContentsWithArray:(NSArray *)contents config:(WTDataConfig *)config;

@end
