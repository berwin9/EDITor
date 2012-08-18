//
//  EDINode.h
//  Docz
//
//  Created by Erwin Mombay on 8/16/12.
//  Copyright (c) 2012 win. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EDINode : NSObject

@property (nonatomic, copy) NSString *label;
@property (nonatomic, copy) NSString *ediName;
@property (nonatomic, copy) NSString *nodeType;
@property (nonatomic, copy) id collection;

- (id)initWithLabel:(NSString *)label
            ediName:(NSString *)ediName
           nodeType:(NSString *)nodeType
         collection:(id)collection;

+ (NSArray *)createEDINodesFromDictionary:(NSDictionary *)dict;

@end