//
//  WTStrategy.h
//  Pods
//
//  Created by walter on 24/07/2017.
//
//

#import <Foundation/Foundation.h>
#import "WTCoreTextInterface.h"

@class WTDataConfig;

@interface WTStrategy : NSObject<WTCoreTextInterface>

+ (UIColor *)colorFromTemplate:(NSString *)name;

- (NSMutableDictionary *)attributesWithConfig:(WTDataConfig *)config;

@end
