//
//  WTTextData.h
//  Pods
//
//  Created by walter on 23/07/2017.
//
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>

@interface WTTextData : NSObject

@property (nonatomic, assign) CTFrameRef ctFrame;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, strong) NSArray * imageArray;
@property (nonatomic, strong) NSArray * linkArray;
@property (nonatomic, strong) NSAttributedString *content;

@end
