//
//  EDINode.m
//  EDITor
//
//  Created by Erwin Mombay on 8/16/12.
//  Copyright (c) 2012 win. All rights reserved.
//

#import "EDINode.h" 

@implementation EDINode

- (id)initWithLabel:(NSString *)label
            ediName:(NSString *)ediName
           nodeType:(NSString *)nodeType
         collection:(id)collection {
    self = [super init];
    if (self) {
        _label = label;
        _ediName = ediName;
        _nodeType = nodeType;
        _collection = collection;
    }
    return self;
}

+ (NSArray *)createEDINodesFromDictionary:(NSDictionary *)dict {
    static NSString *sep = @"_";
    NSMutableArray *models = [[NSMutableArray alloc] init];
    [[dict objectForKey:@"collection"] enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [models addObject:[[EDINode alloc] initWithLabel:[obj objectForKey:@"name"]
                                                 ediName:[obj objectForKey:@"fullName"]
                                                nodeType:@"s"
                                              collection:[obj objectForKey:@"collection"]]];
    }];
    return [models sortedArrayUsingComparator:^(EDINode *obj1, EDINode *obj2) {
        NSString *name1 = [[obj1.ediName componentsSeparatedByString:sep] lastObject];
        NSString *name2 = [[obj2.ediName componentsSeparatedByString:sep] lastObject];
        return [name1 caseInsensitiveCompare:name2];
    }];
}

+ (EDINode *)createEDINodeFromDictionary:(NSDictionary *)dict withKey:(NSString *)key {
    NSDictionary *node = [dict objectForKey:key];
    return [[EDINode alloc] initWithLabel:[node objectForKey:@"name"]
                                  ediName:[node objectForKey:@"fullName"]
                                 nodeType:@"s"
                               collection:[EDINode createEDINodesFromDictionary:node]];
}

@end