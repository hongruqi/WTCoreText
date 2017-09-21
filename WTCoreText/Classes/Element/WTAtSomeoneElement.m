//
//  WTAtSomeoneElement.m
//  WTCoreText
//
//  Created by walter on 08/09/2017.
//

#import "WTAtSomeoneElement.h"
#import "WTAtSomeoneRun.h"

@implementation WTAtSomeoneElement

+ (Class)glyphRunClass {
    
    return [WTAtSomeoneRun class];
}

+ (id)elementWithSomeoneId:(NSString *)someoneId name:(NSString *)name {
    
    WTAtSomeoneElement *element = [[WTAtSomeoneElement alloc] init];
    element.someoneId = someoneId;
    element.name = name;
    element.text = name;
    
    return element;
}

@end
