//
//  EDITorTableViewController.h
//  EDITor
//
//  Created by Erwin Mombay on 8/15/12.
//  Copyright (c) 2012 win. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EDITorTableViewController: UITableViewController

@property (nonatomic, strong) NSArray *nodes;

-(IBAction)next:(id)sender;
-(IBAction)back:(id)sender;

@end