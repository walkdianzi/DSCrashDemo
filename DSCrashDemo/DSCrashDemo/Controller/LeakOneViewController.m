//
//  LeakOneViewController.m
//  DSCrashDemo
//
//  Created by dasheng on 16/4/13.
//  Copyright © 2016年 dasheng. All rights reserved.
//

#import "LeakOneViewController.h"

@interface LeakOneViewController ()

@property (nonatomic, strong)UIView  *countView;

@end

@implementation LeakOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
    执行了下面这一句的时候，对self.countView引用计数加1，等待leakSelect:执行完毕之后self.countView减一。
    所以如果leakSelect:一直没执行，target就会一直释放不掉，发送内存泄露。
     
    这里我模拟了leakSelect:只在mode为UITrackingRunLoopMode时才会执行，所以返回上一层时如果不滚动，
    leakSelect:就一直不执行，target也一直不释放。
    */
    [self performSelector:@selector(leakSelect:) withObject:self.countView afterDelay:5 inModes:@[UITrackingRunLoopMode]];
}

- (void)leakSelect:(id)sender{
    
    NSLog(@"方法执行了");
}

- (void)dealloc{
        
    NSLog(@"我被释放了");
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
