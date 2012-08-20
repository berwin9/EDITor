//
//  EDITorTreeWalker.m
//  EDITor
//
//  Created by Erwin Mombay on 8/18/12.
//  Copyright (c) 2012 win. All rights reserved.
//

#import "EDITorTreeWalker.h"

@interface EDITorTreeWalker() {
    NSMutableArray *stack;
}

@property (nonatomic,  weak) EDINode *curNode;
@property (nonatomic) NSUInteger curDepth;
@property (nonatomic) NSUInteger curIndex;

@end

@implementation EDITorTreeWalker

+ (EDITorTreeWalker *)sharedManager {
    static dispatch_once_t onceToken;
    static EDITorTreeWalker *instance;
    //: this creates a singleton that is thread-safe.
    //: this seems to be the most idiomatic way to create
    //: singletons in Obj-C as there is no good reason to do an
    //: `enforced singleton` as the `shared singleton` approach
    //: is usually good enough
    dispatch_once(&onceToken, ^{
        instance = [[EDITorTreeWalker alloc] init];
    });
    return instance;
}

- (void)resetTarget:(EDINode *)root
            curNode:(EDINode *)curNode
           curDepth:(NSUInteger)curDepth
           curIndex:(NSUInteger)curIndex {
    [stack removeAllObjects];
    self.root = nil;
    self.curNode = nil;
    self.curDepth = 0;
    self.curIndex = 0;
}

- (void)setRoot:(EDINode *)root {
    [self resetTarget:root curNode:root curDepth:0 curIndex:0];
}

- (void)next {
    //TODO: stub
}

- (void)prev {
    //TODO: stub
}

- (void)up {
    //TODO: stub
}
- (void)down {
    //TODO: stub
}

- (EDINode *)parent {
    //TODO: stub
    return nil;
}

- (EDINode *)child {
    //TODO: stub
    return nil;
}

@end
