//
//  ViewController.m
//  PreSniffSDKDemo
//
//  Created by WangSiyu on 21/02/2017.
//  Copyright © 2017 pre-engineering. All rights reserved.
//

#import "ViewController.h"
#import <PreSniffSDK/PreSniffSDK.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        NSArray *urls = @[@"http://www.qq.com", @"http://www.baidu.com", @"http://www.163.com"];
        for (int i = 0; i < 30; i ++) {
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urls[i%3]]];
            NSURLSession *session = [NSURLSession sessionWithConfiguration:NSURLSessionConfiguration.defaultSessionConfiguration];
            //    session = [NSURLSession sharedSession];
            NSURLSessionDataTask *task = [session dataTaskWithRequest:request];
            [task resume];
            sleep(1);
        }
    });
    
    [self testEventTracking];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self forceCrashing];
    });
}

- (void)testEventTracking {
    PRESMetricsManager *metricsManager = [PreSniffManager sharedPreSniffManager].metricsManager;
    
    [metricsManager trackEventWithName:@"viewDidLoadEvent" properties:@{@"helloKey": @"worldValue"} measurements:@{@"helloKey": @7}];
}

- (void)forceCrashing {
    @throw [NSException exceptionWithName:@"Manually Exception" reason:@"嗯，我是故意的" userInfo:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
