//
//  EDINode.h
//  EDITor
//
//  Created by Erwin Mombay on 8/16/12.
//  Copyright (c) 2012 win. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EDINode : NSObject

@property (nonatomic, readonly, copy) NSString *label;
@property (nonatomic, readonly, copy) NSString *ediName;
@property (nonatomic, readonly, copy) NSString *nodeType;
@property (nonatomic, readonly, copy) id collection;

- (id)initWithLabel:(NSString *)label
            ediName:(NSString *)ediName
           nodeType:(NSString *)nodeType
         collection:(id)collection;

+ (NSArray *)createEDINodesFromDictionary:(NSDictionary *)dict;

+ (EDINode *)createEDINodeFromDictionary:(NSDictionary *)dict withKey:(NSString *)key;

@end