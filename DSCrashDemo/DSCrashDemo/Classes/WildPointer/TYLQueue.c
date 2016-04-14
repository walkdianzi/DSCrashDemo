//
//  TYLQueue.c
//  TYLCopyLabel
//
//  Created by 橙子 on 16/4/9.
//  Copyright © 2016年 Lengain. All rights reserved.
//

#include "TYLQueue.h"
static void tyl_queue_realloc(TYLQueue *q);

int tyl_queue_length(TYLQueue *q){
    return q->_size;
}

TYLQueue *tyl_queue_create(int priority){
    TYLQueue *q = (TYLQueue *)malloc(sizeof(TYLQueue));
    q->_priority = priority;
    q->_size = 0;
    q->_capacity = 11;//default initial value
    q->_node = (void **)malloc(sizeof(void*)*q->_capacity);
    return q;
}

TYLQueue *tyl_queue_create_capacity(long capacity){
    TYLQueue *q = (TYLQueue *)malloc(sizeof(TYLQueue));
    q->_priority = TYL_PRIORITY_DEFAULT;
    q->_size = 0;
    if (capacity > 0) {
        q->_capacity = capacity;
    }else{
        q->_capacity = 11;//default initial value
    }
    q->_node = (void **)malloc(sizeof(void*)*q->_capacity);
    return q;
}

void tyl_queue_free(TYLQueue *q){
    int i;
    if (q) {
        for (i = 0; i < q->_size; i ++) {
            free(q->_node[i]);
        }
        free(q->_node);
        free(q);
    }
}

void tyl_queue_enqueue(TYLQueue *q,void *p){
    q->_node[q->_size] = p;
    q->_size++;
    if (q->_size >= q->_capacity) {
        tyl_queue_realloc(q);
    }
}

void *tyl_queue_dequeue(TYLQueue *q){
    void *p = NULL;
    if (q->_size > 0) {
        p = q->_node[0];
    }
    return p;
}

#pragma mark - internal method

static void tyl_queue_realloc(TYLQueue *q){
    q->_capacity = q->_capacity*2;
    q->_node = realloc(q->_node, sizeof(void *) * q->_capacity);
}





