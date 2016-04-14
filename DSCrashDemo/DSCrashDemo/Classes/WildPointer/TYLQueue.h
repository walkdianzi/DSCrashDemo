//
//  TYLQueue.h
//  TYLCopyLabel
//
//  Created by 橙子 on 16/4/9.
//  Copyright © 2016年 Lengain. All rights reserved.
//

#ifndef TYLQueue_h
#define TYLQueue_h

#include <stdio.h>
#include <stdlib.h>

#define TYL_PRIORITY_MAX 3
#define TYL_PRIORITY_DEFAULT 2
#define TYL_PRIORTTY_MIN 1
typedef struct tyl_queue_struct TYLQueue;

struct tyl_queue_struct {
    int _priority;//优先级
    int _size;//大小
    long _capacity;//容量
    void **_node;
};

int tyl_queue_length(TYLQueue *q);

//新建
TYLQueue *tyl_queue_create(int priority);

TYLQueue *tyl_queue_create_capacity(long capacity);

void tyl_queue_free(TYLQueue *q);

//放入一个值
void tyl_queue_enqueue(TYLQueue *q,void *p);

//得到当前的值
void *tyl_queue_dequeue(TYLQueue *q);

#endif /* TYLQueue_h */
