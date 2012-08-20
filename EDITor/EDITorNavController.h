//
//  EDITorNavController.h
//  EDITor
//
//  Created by Erwin Mombay on 8/19/12.
//  Copyright (c) 2012 win. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EDITorTreeWalker.h"

@interface EDITorNavController : UINavigationController

@property (nonatomic, strong) NSArray *nodes;

- (void)reloadVisibleTableViewChild;

@end
