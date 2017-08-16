//
//  WTViewController.m
//  WTCoreText
//
//  Created by lbrsilva-allin on 07/15/2017.
//  Copyright (c) 2017 lbrsilva-allin. All rights reserved.
//

#import "WTViewController.h"
#import "WTTestCoreTextView.h"
#import "WTDisplayView.h"
#import "WTDataConfig.h"
#import "WTTextData.h"
#import "WTClient.h"

@interface WTViewController ()<WTDisplayViewDelegate>

@property (nonatomic, strong) WTDisplayView *ctView;

@end

@implementation WTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.ctView = [[WTDisplayView alloc] initWithFrame:CGRectMake(0, 64, 320, 200)];
    
    [self.view addSubview:self.ctView];
    WTDataConfig *config = [[WTDataConfig alloc] init];
    config.width = self.ctView.frame.size.width;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"content" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSArray *array = [NSJSONSerialization JSONObjectWithData:data
                                                     options:NSJSONReadingAllowFragments
                                                       error:nil];
    WTTextData *textdata = [WTClient parseContentsWithArray:array config:config];
    
//    WTTextData *textdata = [WTFrameParserClient parseContent:@"qihrhhrhrhrhrhhrh" config:config];
    self.ctView.data = textdata;
    [self.ctView setViewHeight:textdata.height];
    self.ctView.backgroundColor = [UIColor whiteColor];
    self.ctView.delgate = self;
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)wt_displayView:(WTDisplayView *)displayView linkDidClick:(WTLinkData *)linkData
{

}

- (void)wt_displayView:(WTDisplayView *)displayView imageDidClick:(WTImageData *)imageData
{

}

@end
