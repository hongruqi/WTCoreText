//
//  WTContext.m
//  Pods
//
//  Created by walter on 24/07/2017.
//
//

#import "WTContext.h"
#import "WTStrategy.h"

@interface WTContext()

@property (nonatomic, strong) WTStrategy *strategy;

@end

@implementation WTContext

- (instancetype)init
{
    if (self = [super init]) {
        
    }
    
    return self;
}

- (instancetype)initWithStrategy:(WTStrategy *)strategy
{
    if (self = [super init]) {
        self.strategy = strategy;
    }
    
    return self;
}

- (NSAttributedString *)executeParserWithDict:(NSDictionary *)dict config:(WTDataConfig *)config
{
   return [self.strategy parseDataFromNSDictionary:dict config:config];
}

@end
