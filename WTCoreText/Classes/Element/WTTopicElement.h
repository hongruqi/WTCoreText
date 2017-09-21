//
//  WTTopicElement.h
//  WTCoreText
//
//  Created by walter on 08/09/2017.
//

#import "WTLinkElement.h"

@interface WTTopicElement : WTLinkElement

@property (nonatomic, copy) NSString *topic;

+ (id)elementWithTopic:(NSString *)topic;

@end
