//
//  EDINode.m
//  Docz
//
//  Created by Erwin Mombay on 8/16/12.
//  Copyright (c) 2012 win. All rights reserved.
//

#import "EDINode.h"

@implementation EDINode

@synthesize name = _name;
@synthesize nodeType = _nodeType;

-(id)initWithName:(NSString *)name type:(NSString *)type {
    self = [super init];
    if (self) {
        ;
    }
    return self;
}

@end