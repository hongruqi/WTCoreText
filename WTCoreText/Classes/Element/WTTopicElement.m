//
//  WTTopicElement.m
//  WTCoreText
//
//  Created by walter on 08/09/2017.
//

#import "WTTopicElement.h"
#import "WTTopicRun.h"

@implementation WTTopicElement

+ (Class)glyphRunClass {
    
    return [WTTopicRun class];
}

+ (id)elementWithTopic:(NSString *)topic {
    WTTopicElement *topicElement = [[WTTopicElement alloc] init];
    topicElement.topic = topic;
    topicElement.text = topic;
    
    return topicElement;
}
@end
