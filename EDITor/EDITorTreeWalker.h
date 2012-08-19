//
//  EDITorTreeWalker.h
//  EDITor
//
//  Created by Erwin Mombay on 8/18/12.
//  Copyright (c) 2012 win. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EDINode.h"

@interface EDITorTreeWalker : NSObject

@property (nonatomic, weak) EDINode *root;
@property (nonatomic, readonly, weak) EDINode *curNode;
@property (nonatomic, readonly) NSUInteger curDepth;
@property (nonatomic, readonly) NSUInteger curIndex;

+ (EDITorTreeWalker *)getInstance;

- (void)setRoot:(EDINode *)root;
- (void)next;
- (void)prev;
- (void)up;
- (void)down;
- (EDINode *)child;
- (EDINode *)parent;

@end
