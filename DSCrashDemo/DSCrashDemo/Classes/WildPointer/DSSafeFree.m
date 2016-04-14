//
//  DSSafeFree.m
//  DSCrashDemo
//
//  Created by dasheng on 16/4/14.
//  Copyright © 2016年 dasheng. All rights reserved.
//

#import "DSSafeFree.h"
#import "fishhook.h"
#import <malloc/malloc.h>
#import "TYLQueue.h"
#import <libkern/OSAtomic.h>
long unfreeSize = 0;
TYLQueue *_unfreeQueue = NULL;
OSSpinLock spinLock = OS_SPINLOCK_INIT;


#define MAX_SAVE_MEM_SIZE 1024*1024*100 //最多存这么多值,大于这个值就释放一部分
#define MAX_SAVE_MEM_NUM  1024*1024*10 //最多保留这么多指针,再多就释放一部分
#define PER_FREE_NUM 100 //每次释放指针数量

static int (*orig_free)(const void *);


void free_some_mem(size_t freeNum){
    size_t count = tyl_queue_length(_unfreeQueue);
    freeNum = freeNum > count ? count : freeNum;
    for (int i = 0; i < freeNum; i++) {
        void *unfreePoint = tyl_queue_dequeue(_unfreeQueue);
        size_t memSize = malloc_size(unfreePoint);
        OSSpinLockLock(&spinLock);
        unfreeSize -= memSize;
        OSSpinLockUnlock(&spinLock);
        orig_free(unfreePoint);
    }
}


void safe_free(void* p){
#if 0
    size_t memSize = malloc_size(p);
    memset(p, 0x55, memSize);
    orig_free(p);
#else
    int unfreeCount = tyl_queue_length(_unfreeQueue);
    if (unfreeCount > MAX_SAVE_MEM_NUM * 0.9 || unfreeSize > MAX_SAVE_MEM_SIZE) {
        free_some_mem(PER_FREE_NUM);
    }
    size_t memSize = malloc_size(p);
    memset(p, 0x55, memSize);
    OSSpinLockLock(&spinLock);
    unfreeSize += memSize;
    OSSpinLockUnlock(&spinLock);
    tyl_queue_enqueue(_unfreeQueue, p);
#endif
    return;
}


bool init_safe_free(){
    _unfreeQueue = tyl_queue_create_capacity(MAX_SAVE_MEM_NUM);
    rebind_symbols((struct rebinding[1]){{"free", safe_free,(void *)&orig_free},},1);
    return true;
}


@implementation DSSafeFree

@end
