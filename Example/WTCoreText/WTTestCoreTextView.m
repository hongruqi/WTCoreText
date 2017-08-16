//
//  WTTestCoreTextView.m
//  WTCoreText
//
//  Created by walter on 19/07/2017.
//  Copyright © 2017 lbrsilva-allin. All rights reserved.
//

#import "WTTestCoreTextView.h"

@interface WTTestCoreTextView()

@end

@implementation WTTestCoreTextView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    
    return self;
}

//- (UIView *)viewForElement:(WTElement *)element {
//    
//    if ([element isKindOfClass:[WTTopicElement class]]) {
//        
//        WTTopicElement *topicElement = (WTTopicElement *) element;
//        
//        WTLinkButton *linkButton = [[WTLinkButton alloc] init];
//        linkButton.element = topicElement;
//        CGFloat gray = 0.5;
//        linkButton.highlightColor = [UIColor colorWithRed:gray green:gray blue:gray alpha:0.3];
//        
//        [linkButton addTarget:self action:@selector(topicPushed:) forControlEvents:UIControlEventTouchUpInside];
//        linkButton.layer.borderColor = [UIColor redColor].CGColor;
//        linkButton.layer.borderWidth = .5f;
//        return linkButton;
//    }
//
//    return nil;
//}

- (void)topicPushed:(id)sender
{
    NSLog(@"topic click");
}


@end
