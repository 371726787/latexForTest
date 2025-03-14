//
//  ViewController.m
//  LCModalHelperDemo
//
//  Created by xxxx on 2018/1/13.
//  Copyright © 2018年 xxxx. All rights reserved.
//

#import "ViewController.h"

#import "test-Swift.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.orangeColor;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 在 Objective-C 的视图控制器中加载 SwiftUI
        UIViewController *swiftUIViewController = [SwiftUIWrapper createHostingController];
        [self presentViewController:swiftUIViewController animated:YES completion:nil];
    });
    
}

@end

