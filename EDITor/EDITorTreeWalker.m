//
//  EDITorTreeWalker.m
//  EDITor
//
//  Created by Erwin Mombay on 8/18/12.
//  Copyright (c) 2012 win. All rights reserved.
//

#import "EDITorTreeWalker.h"

static EDITorTreeWalker *instance;

@interface EDITorTreeWalker() {
    NSMutableArray *stack;
}

@end

@implementation EDITorTreeWalker

+ (EDITorTreeWalker *)getInstance {
    if (instance == nil) {
        instance = [self alloc];
    }
    return instance;
}

- (void)setRoot:(EDINode *)root {
    self.root = root;
}

- (void)next {
}

@end
