//
//  WTAtSomeoneElement.h
//  WTCoreText
//
//  Created by walter on 08/09/2017.
//

#import "WTLinkElement.h"

@interface WTAtSomeoneElement : WTLinkElement

@property (nonatomic, copy) NSString *someoneId;
@property (nonatomic, copy) NSString *name;

+ (id)elementWithSomeoneId:(NSString *)someoneId name:(NSString *)name;

@end
