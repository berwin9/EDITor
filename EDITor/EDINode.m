//
//  EDINode.m
//  Docz
//
//  Created by Erwin Mombay on 8/16/12.
//  Copyright (c) 2012 win. All rights reserved.
//

#import "EDINode.h" 

@implementation EDINode

@synthesize label = _label;
@synthesize ediName = _ediName;
@synthesize nodeType = _nodeType;
@synthesize collection = _collection;

-(id)initWithLabel:(NSString *)label
           ediName:(NSString *)ediName
          nodeType:(NSString *)nodeType
        collection:(id)collection {
    self = [super init];
    if (self) {
        self.label = label;
        self.ediName = ediName;
        self.nodeType = nodeType;
        self.collection = collection;
    }
    return self;
}

+(NSArray *)createModelPoolWithTsetDict:(NSDictionary *)tset {
    NSMutableArray *stack = [[NSMutableArray alloc] initWithCapacity:30];
    NSMutableArray *temp = [[NSMutableArray alloc] initWithCapacity:30];
    [stack addObject:tset];
    while ([stack count]) {
        id cur = [stack lastObject];
        [stack removeLastObject];
        NSLog(@"stack type: %@", [cur class]);
        for (NSDictionary *key in cur) {
            NSLog(@"type: %@", [key class]);
            NSLog(@"%@", key);
//            NSDictionary *test = key;
//            [stack addObject:key];
            [temp addObject:key];
        }
    }
    return temp;
}

@end