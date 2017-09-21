//
//  WTTextElement.h
//  WTCoreText
//
//  Created by walter on 08/09/2017.
//

#import <CoreText/CoreText.h>
#import "WTElement.h"

@interface WTTextElement : WTElement

@property (nonatomic, strong) NSMutableArray *linkElementArray;

+ (id)elementWithText:(NSString *)text;

@end
