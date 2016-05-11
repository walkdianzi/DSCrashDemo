//
//  DeadLockViewController.m
//  DSCrashDemo
//
//  Created by dasheng on 16/4/18.
//  Copyright © 2016年 dasheng. All rights reserved.
//

#import "DeadLockViewController.h"
#import <Foundation/Foundation.h>

@implementation DeadLockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScrollView  *contentScroller = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    contentScroller.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height*1.5);
    [self.view addSubview:contentScroller];
    
    UIButton *bugButton = [[UIButton alloc] initWithFrame:CGRectMake(60, 200, 100, 100)];
    bugButton.backgroundColor = [UIColor redColor];
    [bugButton setTitle:@"queue死锁" forState:UIControlStateNormal];
    [bugButton addTarget:self action:@selector(bugButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [contentScroller addSubview:bugButton];
    
    UIButton *bugTwoButton = [[UIButton alloc] initWithFrame:CGRectMake(200, 200, 100, 100)];
    bugTwoButton.backgroundColor = [UIColor redColor];
    [bugTwoButton setTitle:@"queue死锁2" forState:UIControlStateNormal];
    [bugTwoButton addTarget:self action:@selector(bugTwoButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [contentScroller addSubview:bugTwoButton];
    
    UIButton *bugThreeButton = [[UIButton alloc] initWithFrame:CGRectMake(60, 350, 100, 100)];
    bugThreeButton.backgroundColor = [UIColor redColor];
    [bugThreeButton setTitle:@"queue死锁3" forState:UIControlStateNormal];
    [bugThreeButton addTarget:self action:@selector(bugThreeButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [contentScroller addSubview:bugThreeButton];

}

- (void)bugButtonClick{
    
    //队列的执行顺序跟同步线程中的执行顺序不同，找出死锁
    //加入队列的顺序是任务1->任务3->任务2
    
    NSLog(@"任务1 - %@",[NSThread currentThread]); // 任务1
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"任务2 - %@",[NSThread currentThread]); // 任务2
    });
    NSLog(@"任务3 - %@",[NSThread currentThread]); // 任务3
}

- (void)bugTwoButtonClick{
    
    //加入myQueue队列的顺序是【任务2、任务4、任务3】，同步线程【任务2、任务3、任务4】造成死锁
    dispatch_queue_t queue = dispatch_queue_create("myQueue", DISPATCH_QUEUE_SERIAL);
    NSLog(@"任务1 - %@", [NSThread currentThread]);
    dispatch_async(queue, ^{
        NSLog(@"任务2 - %@",[NSThread currentThread]);
        dispatch_sync(queue, ^{
            NSLog(@"任务3 - %@", [NSThread currentThread]);
        });
        NSLog(@"任务4 - %@",[NSThread currentThread]);
    });
    NSLog(@"任务5 - %@", [NSThread currentThread]);
}

- (void)bugThreeButtonClick{
    
    //加入主队列的顺序是【异步线程、任务4、死循环、任务5、任务2】
    //这里主队列中死循环使Main Queue阻塞，所以任务2没有执行，又因为任务2是同步线程中，任务3没办法执行
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"任务1 - %@", [NSThread currentThread]); // 任务1
        dispatch_sync(dispatch_get_main_queue(), ^{
            NSLog(@"任务2 - %@", [NSThread currentThread]); // 任务2
        });
        NSLog(@"任务3 - %@", [NSThread currentThread]); // 任务3
    });
    NSLog(@"任务4 - %@", [NSThread currentThread]); // 任务4
    while (1) {
        
    }
    NSLog(@"任务5 - %@", [NSThread currentThread]); // 任务5
}

@end
