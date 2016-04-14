//
//  MyMrcView.m
//  TYLCopyLabel
//
//  Created by 橙子 on 16/4/8.
//  Copyright © 2016年 Lengain. All rights reserved.
//

#import "MyMrcView.h"

@implementation MyMrcView

- (instancetype)init
{
    self = [super init];
    if (self) {
        UIView *tempView = [[UIView alloc]init];
        [tempView release];
        
        //AppDelegate里开启了init_safe_free()，表示释放的内存不会被覆盖，所以tempView调用setNeedsDisplay肯定会崩溃
        //如果不开启init_safe_free()，下面创建了10个UIView，那块被释放的内存可能会被覆盖，所以tempView调用setNeedsDisplay不一定会崩溃
        for (int i = 0; i < 10; i ++) {
            UIView *temp = [[[UIView alloc]init] autorelease];
            [self addSubview:temp];
        }
        [tempView setNeedsDisplay];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
