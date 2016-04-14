//
//  BusViewController.m
//  DSCrashDemo
//
//  Created by dasheng on 16/4/14.
//  Copyright © 2016年 dasheng. All rights reserved.
//

#import "BusViewController.h"

@implementation BusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScrollView  *contentScroller = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    contentScroller.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height*1.5);
    [self.view addSubview:contentScroller];
    
    UIButton *crashSignalBUSButton = [[UIButton alloc] initWithFrame:CGRectMake(60, 200, 200, 100)];
    crashSignalBUSButton.backgroundColor = [UIColor redColor];
    [crashSignalBUSButton setTitle:@"Signal(BUS)" forState:UIControlStateNormal];
    [crashSignalBUSButton addTarget:self action:@selector(crashSignalBUSClick) forControlEvents:UIControlEventTouchUpInside];
    [contentScroller addSubview:crashSignalBUSButton];
}

- (void)crashSignalBUSClick{
    
    //SIGBUS，内存地址未对齐
    //EXC_BAD_ACCESS(code=1,address=0x1000dba58)
    char *s = "hello world";
    *s = 'H';
}


@end
