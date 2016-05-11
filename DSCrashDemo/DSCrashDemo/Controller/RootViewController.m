//
//  RootViewController.m
//  DSCategories
//
//  Created by dasheng on 15/12/17.
//  Copyright © 2015年 dasheng. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController(){
    
    NSDictionary *_itemsName;
}

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"崩溃";
    _items = @{
               
               @"EXC_BAD_ACCESS":@[
                                    @"SEGV",
                                    @"Bus",
                                    @"ABRT"
                                ],
               @"野指针":@[
                       
                            @"MRCOne"
                       ],
               
               @"内存泄露":@[
                            @"LeakOne"
                       ],
               
               @"主线程卡死":@[
                            @"DeadLock"
                       ]
             };
    
    _itemsName = @{
                   
                   @"EXC_BAD_ACCESS":@[
                                    @"无效内存中止信号（SIGSEGV）",
                                    @"内存地址未对齐（SIGBUS）",
                                    @"程序中止命令中止信号（SIGABRT）",
                                ],
                   
                   @"野指针":@[
                                @"MRC提高野指针崩溃率"
                           ],
                   
                   @"内存泄露":@[
                                @"performSelector:afterDelay"
                           ],
                   @"主线程卡死":@[
                                @"死锁"
                           ]
                   };
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.tableView reloadData];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[_items allKeys] count];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [_items allKeys][section];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[_items objectForKey:[_items allKeys][section]] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.textLabel.text =  [_itemsName objectForKey:[_itemsName allKeys][indexPath.section]][indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *name =  [_items objectForKey:[_items allKeys][indexPath.section]][indexPath.row];
    NSString *className = [name stringByAppendingString:@"ViewController"];
    Class class = NSClassFromString(className);
    UIViewController *controller = [[class alloc] init];
    controller.title = name;
    [self.navigationController pushViewController:controller animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
