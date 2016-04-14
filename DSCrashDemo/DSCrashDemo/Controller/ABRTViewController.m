//
//  ABRTViewController.m
//  DSCrashDemo
//
//  Created by dasheng on 16/4/14.
//  Copyright © 2016年 dasheng. All rights reserved.
//

#import "ABRTViewController.h"

typedef struct Test
{
    int a;
    int b;
}Test;

@implementation ABRTViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScrollView  *contentScroller = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    contentScroller.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height*1.5);
    [self.view addSubview:contentScroller];
    
    UIButton *crashSignalBRTButton = [[UIButton alloc] initWithFrame:CGRectMake(60, 200, 200, 100)];
    crashSignalBRTButton.backgroundColor = [UIColor redColor];
    [crashSignalBRTButton setTitle:@"Signal(ABRT)" forState:UIControlStateNormal];
    [crashSignalBRTButton addTarget:self action:@selector(crashSignalBRTClick) forControlEvents:UIControlEventTouchUpInside];
    [contentScroller addSubview:crashSignalBRTButton];
}

- (void)crashSignalBRTClick{
    
    //导致SIGABRT的错误，程序中止命令，中止信号
    
}

@end
