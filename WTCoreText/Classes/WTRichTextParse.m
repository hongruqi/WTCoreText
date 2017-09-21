//
//  WTRichTextParse.m
//  WTCoreText
//
//  Created by walter on 12/09/2017.
//

#import "WTRichTextParse.h"
#import "WTLinkElement.h"
#import "WTLinkButton.h"
#import "WTTopicElement.h"
#import "WTAtSomeoneElement.h"
#import "WTImageElement.h"
#import "WTElementAttribute.h"
#import "WTTextElement.h"

#define RGBCOLOR(r,g,b) \
[UIColor colorWithRed:r/255.f green:g/255.f blue:b/255.f alpha:1.f]

@implementation WTRichTextParse

+ (NSMutableArray *)parseRichText:(NSString *)text
{
    NSMutableArray *parseArray = [NSMutableArray array];
    
    NSString* pattern = @"(#[^#]+?#)";
   
    __block NSString *tagResult = @"";
    NSError *error = NULL;
    NSRegularExpression *expression = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:&error];
    NSRange rangeTotal = [text rangeOfString:text];
    __block NSUInteger length = rangeTotal.length;
    
    if (length <= 0) {
        return parseArray;
    }
    __block NSInteger currentLocation = 0;
    
    [expression enumerateMatchesInString:text
                                 options:0
                                   range:rangeTotal
                              usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
                                  
                                  NSRange subRange = [result range];
                                  NSUInteger subLocation = subRange.location;
                                  NSUInteger subLength = subRange.length;
                                  NSString* subString = [text substringWithRange:subRange];
                                  
                                  if(currentLocation < subLocation){
                                      NSRange beforeSubRange = NSMakeRange(currentLocation, (subLocation - currentLocation));
                                      NSString *beforeSubString = [text substringWithRange:beforeSubRange];
                                      
                                      WTTextElement *textElement = [WTTextElement elementWithText:beforeSubString];
                                      WTElementAttribute *textAttribute = [[WTElementAttribute alloc] init];
                                      textAttribute.font = [UIFont fontWithName:@"Helvetica" size:16];
                                      textAttribute.textColor = RGBCOLOR(180.0, 180.0, 67.0);
                                      [parseArray addObject:textElement];
                                      
                                      if ([tagResult isEqualToString:@""]) {
                                          tagResult = beforeSubString;
                                      }else{
                                          tagResult = [NSString stringWithFormat:@"%@%@",tagResult,beforeSubString];
                                      }
                                  }
                                  
                                  if ([subString isEqualToString:@"##"] ||
                                      [subString isEqualToString:@"# #"] ||
                                      [subString isEqualToString:@"#"] ||
                                      [subString isEqualToString:@"# "] ) {
                                      
                                      WTTextElement *textElement = [WTTextElement elementWithText:subString];
                                      WTElementAttribute *textAttribute = [[WTElementAttribute alloc] init];
                                      textAttribute.font = [UIFont fontWithName:@"Helvetica" size:16];
                                      textAttribute.textColor = RGBCOLOR(180.0, 180.0, 67.0);
                                      [parseArray addObject:textElement];
                                      
                                  }else{
                                      WTTopicElement *element = [WTTopicElement elementWithTopic:subString];
                                      WTElementAttribute *attribute = [[WTElementAttribute alloc] init];
                                      attribute.font = [UIFont fontWithName:@"Helvetica" size:16];
                                      attribute.textColor = RGBCOLOR(180.0, 180.0, 67.0);
                                      attribute.maximunLineSpacing = 6;
                                      attribute.minimunLineSpacing = 6;
                                      element.attribute = attribute;
                                      [parseArray addObject:element];
                                  }
                                  
                                  if ([tagResult isEqualToString:@""]) {
                                      tagResult = subString;
                                  }else{
                                      tagResult = [NSString stringWithFormat:@"%@%@",tagResult,subString];
                                  }
                                  
                                  currentLocation = subLocation + subLength;
                              }];
    
    if ( currentLocation < rangeTotal.length ) {
        NSRange beforeSubRange = NSMakeRange(currentLocation, (rangeTotal.length - currentLocation));
        NSString* beforeSubString = [text substringWithRange:beforeSubRange];
        
        WTTextElement *textElement = [WTTextElement elementWithText:beforeSubString];
        WTElementAttribute *textAttribute = [[WTElementAttribute alloc] init];
        textAttribute.font = [UIFont fontWithName:@"Helvetica" size:16];
        textAttribute.textColor = RGBCOLOR(180.0, 180.0, 67.0);
        [parseArray addObject:textElement];
        
        if ([tagResult isEqualToString:@""]) {
            tagResult = beforeSubString;
        }else{
            tagResult = [NSString stringWithFormat:@"%@%@",tagResult,beforeSubString];
        }
    }
    
    return parseArray;
}
@end
