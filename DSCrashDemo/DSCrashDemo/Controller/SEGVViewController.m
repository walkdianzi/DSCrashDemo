//
//  SEGVViewController.m
//  DSCrashDemo
//
//  Created by dasheng on 16/4/14.
//  Copyright © 2016年 dasheng. All rights reserved.
//

#import "SEGVViewController.h"

@interface SEGVViewController ()

@end

@implementation SEGVViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScrollView  *contentScroller = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    contentScroller.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height*1.5);
    [self.view addSubview:contentScroller];
    
    UIButton *crashSignalEGVButton = [[UIButton alloc] initWithFrame:CGRectMake(60, 200, 200, 100)];
    crashSignalEGVButton.backgroundColor = [UIColor redColor];
    [crashSignalEGVButton setTitle:@"Signal(EGV)" forState:UIControlStateNormal];
    [crashSignalEGVButton addTarget:self action:@selector(crashSignalEGVClick) forControlEvents:UIControlEventTouchUpInside];
    [contentScroller addSubview:crashSignalEGVButton];
}

- (void)crashSignalEGVClick{
    
    //需要不连xcode进行测试，不然在连接xcode的debug模式下，debug是先截获signal的，不会弹出alert
    //EXC_BAD_ACCESS(code=1,address=0x1111)：表示0x00001111此内存并不合法，SIGSEGV类型崩溃
    int *pi = (int*)0x00001111;
    *pi = 17;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
