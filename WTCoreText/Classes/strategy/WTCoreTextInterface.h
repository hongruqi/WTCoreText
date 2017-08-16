//
//  WTCoreTextInterface.h
//  Pods
//
//  Created by walter on 24/07/2017.
//
//

#import <Foundation/Foundation.h>

@class WTDataConfig;

@protocol WTCoreTextInterface <NSObject>

- (NSAttributedString *)parseDataFromNSDictionary:(NSDictionary *)dict
                                           config:(WTDataConfig*)config;
@end
