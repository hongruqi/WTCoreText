//
//  WTContext.h
//  Pods
//
//  Created by walter on 24/07/2017.
//
//

#import <Foundation/Foundation.h>
#import "WTStrategy.h"

@class WTTextData;
@class WTDataConfig;

@interface WTContext : NSObject

- (instancetype)initWithStrategy:(WTStrategy *)strategy;
- (NSAttributedString *)executeParserWithDict:(NSDictionary *)dict config:(WTDataConfig *)config;
@end
