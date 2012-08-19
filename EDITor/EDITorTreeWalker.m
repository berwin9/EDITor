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

@end

@implementation EDITorTreeWalker

+ (EDITorTreeWalker *)getInstance {
    static dispatch_once_t onceToken;
    static EDITorTreeWalker *instance;
    //: this creates a singleton that is thread-safe.
    //: this seems to be the most idiomatic way to create
    //: singletons in Obj-C and enforcing/asserting on the alloc/init
    //: is frowned upon.
    dispatch_once(&onceToken, ^{
        instance = [[EDITorTreeWalker alloc] init];
    });
    return instance;
}

- (void)setRoot:(EDINode *)root {
    self.root = root;
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
