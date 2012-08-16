//
//  EDINode.h
//  Docz
//
//  Created by Erwin Mombay on 8/16/12.
//  Copyright (c) 2012 win. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EDINode : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *nodeType;

-(id)initWithName:(NSString *)name type:(NSString *)type;

@end
